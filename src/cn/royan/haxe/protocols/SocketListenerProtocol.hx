package cn.royan.haxe.protocols;

import flash.events.EventDispatcher;
import haxe.Stack;
import haxe.io.Bytes;
import haxe.io.Output;
import haxe.io.Eof;
import haxe.io.Error;
#if neko
import neko.net.Socket;
import neko.net.Host;
import neko.vm.Thread;
import neko.vm.Lock;
import neko.Sys;
#elseif cpp
import cpp.net.Socket;
import cpp.net.Host;
import cpp.vm.Thread;
import cpp.vm.Lock;
import cpp.Sys;
#end
import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.NetworkEvent;
import cn.royan.haxe.interfaces.INetworkProtocol;

/**
 * ...
 * @author RoYan
 */

private typedef ThreadInfos = {
	var id : Int;
	var t : Thread;
	var socks : Array<Socket>;
}

private typedef ClientInfos<Client> = {
	var client : Client;
	var sock : Socket;
	var thread : ThreadInfos;
	var buf : Bytes;
	var bufpos : Int;
}

class SocketListenerProtocol<Client> extends EventDispatcher, implements INetworkProtocol {
	var host:String;
	var port:Int;
	var threads:Array<ThreadInfos>;
	var sock:Socket;
	var worker:Thread;
	var timer:Thread;
	var listener:Thread;
	var listen:Int;
	var nthreads:Int;
	var connectLag:Float;
	var errorOutput:Output;
	var initialBufferSize:Int;
	var maxBufferSize:Int;
	var messageHeaderSize:Int;
	var updateTime:Float;
	var maxSockPerThread:Int;

	public function new(h:String,p:Int,m:Int)
	{
		super();
		host = h;
		port = p;
		listen = m;
		threads = new Array();
		nthreads = if( Sys.systemName() == "Windows" ) 150 else 10;
		messageHeaderSize = 1;
		//listen = 10;
		connectLag = 0.5;
		errorOutput = Sys.stderr();
		initialBufferSize = (1 << 10);
		maxBufferSize = (1 << 16);
		maxSockPerThread = 64;
		updateTime = 1;
	}
	
	public function sendRequest(?request:Dynamic, ?extra:Dynamic):Void
	{
		if(request!= null && extra != null)
			sendData(cast(extra), cast(request));
	}
	
	public function connect() {
		try{
			sock = new Socket();
			sock.bind(new Host(host),port);
			sock.listen(listen);
			init();
			listener = Thread.create(runListener);
			
			dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_START ) );
		}catch(e:Dynamic){
			logError(e);
		}
	}
	
	public function disconnect():Void
	{
		sock.close();
		dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_CLOSE ) );
	}
	
	public function getData():Dynamic 
	{
		return null;
	}
	
	function init() {
		worker = Thread.create(runWorker);
		timer = Thread.create(runTimer);
		for( i in 0...nthreads ) {
			var t = {
				id : i,
				t : null,
				socks : new Array()
			};
			threads.push(t);
			t.t = Thread.create(callback(runThread,t));
		}
	}
	
	function runListener(){
		while( true ) {
			try {
				addSocket(sock.accept());
			} catch( e : Dynamic ) {
				logError(e);
			}
		}
	}
	
	function runThread(t) {
		while( true ) {
			try {
				loopThread(t);
			} catch( e : Dynamic ) {
				logError(e);
			}
		}
	}
	
	function loopThread( t : ThreadInfos ) {
		if( t.socks.length > 0 )
			for( s in Socket.select(t.socks,null,null,connectLag).read ) {
				var infos : ClientInfos<Client> = s.custom;
				try {
					readClientData(infos);
				} catch( e : Dynamic ) {
					t.socks.remove(s);
					if( !Std.is(e,Eof) && !Std.is(e,Error) )
						logError(e);
					work(callback(doClientDisconnected,s,infos.client));
				}
			}
		while( true ) {
			var m : { s : Socket, cnx : Bool } = Thread.readMessage(t.socks.length == 0);
			if( m == null )
				break;
			if( m.cnx )
				t.socks.push(m.s);
			else if( t.socks.remove(m.s) ) {
				var infos : ClientInfos<Client> = m.s.custom;
				work(callback(doClientDisconnected,m.s,infos.client));
			}
		}
	}
	
	function runWorker() {
		while( true ) {
			var f = Thread.readMessage(true);
			try {
				f();
			} catch( e : Dynamic ) {
				logError(e);
			}
			try {
				afterEvent();
			} catch( e : Dynamic ) {
				logError(e);
			}
		}
	}
	
	function runTimer() {
		var l = new Lock();
		while( true ) {
			l.wait(updateTime);
			work(update);
		}
	}
	
	function work( f : Void -> Void ) {
		worker.sendMessage(f);
	}

	function readClientData( c : ClientInfos<Client> ) {
		var available = c.buf.length - c.bufpos;
		if( available == 0 ) {
			var newsize = c.buf.length * 2;
			if( newsize > maxBufferSize ) {
				newsize = maxBufferSize;
				if( c.buf.length == maxBufferSize )
					throw "Max buffer size reached";
			}
			var newbuf = Bytes.alloc(newsize);
			newbuf.blit(0,c.buf,0,c.bufpos);
			c.buf = newbuf;
			available = newsize - c.bufpos;
		}
		var bytes = c.sock.input.readBytes(c.buf,c.bufpos,available);
		var pos = 0;
		var len = c.bufpos + bytes;
		while( len >= messageHeaderSize ) {
			var m = readClientMessage(c.client, c.buf, pos, len, c.sock);
			if( m == null )
				break;
			pos += m.bytes;
			len -= m.bytes;
			work(callback(clientMessage,c.client,m.msg));
		}
		if( pos > 0 )
			c.buf.blit(0,c.buf,pos,len);
		c.bufpos = len;
	}

	function doClientDisconnected(s:Socket,c:Client) {
		try s.close() catch( e : Dynamic ) {};
		clientDisconnected(s);
	}

	function logError( e : Dynamic ) {
		var stack = Stack.exceptionStack();
		if( Thread.current() == worker )
			onError(e,stack);
		else
			work(callback(onError,e,stack));
	}

	function addClient( sock : Socket ) {
		var infos : ClientInfos<Client> = {
			thread : threads[Std.random(nthreads)],
			client : clientConnected(sock),
			sock : sock,
			buf : Bytes.alloc(initialBufferSize),
			bufpos : 0,
		};
		sock.custom = infos;
		infos.thread.t.sendMessage({ s : sock, cnx : true });
	}

	function addSocket( s : Socket ) {
		s.setBlocking(false);
		work(callback(addClient,s));
	}

	function sendData( s : Socket, data : Bytes ) {
		LogerTool.print("Listener send:"+data.length);
		try {
			s.output.write(data);
		} catch( e : Dynamic ) {
			logError(e);
			stopClient(s);
		}
	}

	function stopClient( s : Socket ) {
		var infos : ClientInfos<Client> = s.custom;
		try s.shutdown(true,true) catch( e : Dynamic ) { };
		infos.thread.t.sendMessage({ s : s, cnx : false });
	}

	function onError( e : Dynamic, stack ) {
		var estr = try Std.string(e) catch( e2 : Dynamic ) "???" + try "["+Std.string(e2)+"]" catch( e : Dynamic ) "";
		errorOutput.writeString( estr + "\n" + Stack.toString(stack) );
		errorOutput.flush();
		
		dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_ERROR, e ) );
	}

	function clientConnected( s : Socket ) : Client {
		dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_CONNECT, s ) );
		return null;
	}

	function clientDisconnected( s : Socket ) {
		dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_DISCONNECT, s ) );
	}

	function readClientMessage( c : Client, buf : Bytes, pos : Int, len : Int, ?s:Socket ) : { msg : String, bytes : Int } {
		LogerTool.print("Listener read:"+len);
		if(buf.get(pos) == 60 && buf.readString(pos,len)=="<policy-file-request/>\x00")
			s.write(makePolicyFile());
		else
			dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_PROGRESS, {bytes:buf.sub(pos,len),sock:s} ) );
		return {
			msg : null,
			bytes : len,
		};
	}
	
	function makePolicyFile() {
		var str = "<cross-domain-policy>";
			str += '<allow-access-from domain="*" to-ports="*"/>';
			str += "</cross-domain-policy>\x00";
		return str;
	}

	function clientMessage( c : Client, msg : String ) {
	}

	function update() {
	}

	function afterEvent() {
	}

}