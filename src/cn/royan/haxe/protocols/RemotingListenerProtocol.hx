package cn.royan.haxe.protocols;

import haxe.io.Eof;
import haxe.io.Error;
import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.NetworkEvent;
import cn.royan.haxe.interfaces.INetworkProtocol;
#if neko
import neko.net.Socket;
#elseif cpp
import cpp.net.Socket;
#end

/**
 * ...
 * @author RoYan
 */

class RemotingListenerProtocol extends SocketListenerProtocol<haxe.remoting.SocketConnection>{
	var domains : Array<String>;

	public function new( h:String,p:Int,m:Int,?d ) {
		super(h,p,m);
		messageHeaderSize = 2;
		domains = d;
	}

	function initClientApi( cnx : haxe.remoting.SocketConnection, ctx : haxe.remoting.Context ) {
		//throw "Not implemented";
	}

	function onXml( cnx : haxe.remoting.SocketConnection, data : String ) {
		if( data == "<policy-file-request/>" ) {
			var str = '<?xml version="1.0"?><!DOCTYPE cross-domain-policy SYSTEM "http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd"><cross-domain-policy>';
				str += '<allow-access-from domain="*" to-ports="*"/>';
			str += "</cross-domain-policy>\0000";
			cnx.getProtocol().socket.output.writeString(str);
			return;
		}
	}

	function makePolicyFile():String {
		var str = '<?xml version="1.0"?><!DOCTYPE cross-domain-policy SYSTEM "http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd"><cross-domain-policy>';
		for( d in domains )
			str += '<allow-access-from domain="*" to-ports="*"/>';
		str += "</cross-domain-policy>\0000";
		return str;
	}

	override function clientConnected( s : Socket ) {
		var ctx = new haxe.remoting.Context();
		var cnx = haxe.remoting.SocketConnection.create(s,ctx);
		var me = this;
		cnx.setErrorHandler(function(e) {
			if( !Std.is(e,Eof) && !Std.is(e,Error) )
				me.logError(e);
			me.stopClient(s);
		});
		//initClientApi(cnx,ctx);
		dispatchEvent( new NetworkEvent( NetworkEvent.NETWORK_CONNECT, {cnx:cnx,ctx:ctx} ) );
		return cnx;
	}

	override function readClientMessage( cnx : haxe.remoting.SocketConnection, buf : haxe.io.Bytes, pos : Int, len : Int, ?s : Socket ) {
		LogerTool.print("Listener read:"+buf.readString(pos,len));
		var msgLen = cnx.getProtocol().messageLength(buf.get(pos),buf.get(pos+1));
		if( msgLen == null ) {
			if( buf.get(pos) != 60 )
				throw "Invalid remoting message '"+buf.readString(pos,len)+"'";
			var p = pos;
			while( p < len ) {
				if( buf.get(p) == 0 )
					break;
				p++;
			}
			if( p == len )
				return null;
			p -= pos;
			return {
				msg : buf.readString(pos,p),
				bytes : p + 1,
			};
		}
		if( len < msgLen )
			return null;
		if( buf.get(pos + msgLen-1) != 0 )
			throw "Truncated message";
		return {
			msg : buf.readString(pos+2,msgLen-3),
			bytes : msgLen,
		};
	}

	override function clientMessage( cnx : haxe.remoting.SocketConnection, msg : String ) {
		try {
			if( msg.charCodeAt(0) == 60 ) {
				if( domains != null && msg == "<policy-file-request/>" ){
					cnx.getProtocol().socket.output.writeString(makePolicyFile());
				}else
					onXml(cnx,msg);
			} else
				cnx.processMessage(msg);
		} catch( e : Dynamic ) {
			if( !Std.is(e,haxe.io.Eof) && !Std.is(e,haxe.io.Error) )
				logError(e);
			stopClient(cnx.getProtocol().socket);
		}
	}
}