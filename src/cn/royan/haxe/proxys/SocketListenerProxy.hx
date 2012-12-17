package cn.royan.haxe.proxys;

import cn.royan.haxe.ServerFacade;
import cn.royan.haxe.nets.Serializer;
import cn.royan.haxe.nets.Unserializer;
import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.NetworkEvent;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.managers.DataListManager;
import cn.royan.haxe.protocols.SocketListenerProtocol;
import org.puremvc.haxe.interfaces.IProxy;
import org.puremvc.haxe.patterns.proxy.Proxy;
import haxe.io.BytesInput;
#if neko
import neko.net.Socket;
#elseif cpp
import cpp.net.Socket;
#end

/**
 * ...
 * @author RoYan
 */

class SocketListenerProxy extends Proxy, implements IProxy
{
	public function new(?name:String) 
	{
		super( name!=null?name:SocketListenerProxy.NAME );
	}
	
	public function openSystem( host:String, port:Int, max:Int ):Void
	{
		_h = host;
		_p = port;
		LogerTool.print( "Listener Starting Server:{" + host +":"+ port +"}");
		socketProtocol = new SocketListenerProtocol<Dynamic>( host, port, max );
		socketProtocol.addEventListener( NetworkEvent.NETWORK_START, 		onStartHandler );
		socketProtocol.addEventListener( NetworkEvent.NETWORK_CONNECT, 		onConnectHandler );
		socketProtocol.addEventListener( NetworkEvent.NETWORK_PROGRESS, 	onProgressHandler );
		socketProtocol.addEventListener( NetworkEvent.NETWORK_ERROR, 		onErrorHandler );
		socketProtocol.addEventListener( NetworkEvent.NETWORK_DISCONNECT, 	onDisconnectHandler );
		socketProtocol.addEventListener( NetworkEvent.NETWORK_CLOSE, 		onCloseHandler );
		socketProtocol.sendRequest();
		socketProtocol.connect();
	}
	
	public function stopServer():Void
	{
		socketProtocol.disconnect();
	}
	
	public function sendMessage(socket:Socket, message:Message):Void
	{
		var serializer:Serializer = new Serializer();
		socketProtocol.sendRequest(serializer.serialize(message).getBytes(),socket);
	}
	
	function onStartHandler(evt:NetworkEvent):Void
	{
		LogerTool.print( "{"+ _h + ":" + _p + "} Server Started" );
	}
	
	function onConnectHandler(evt:NetworkEvent):Void
	{
		LogerTool.print( "{"+ _h + ":" + _p + "} Client Connected" );
	}
	
	function onProgressHandler(evt:NetworkEvent):Void
	{
		LogerTool.print( "{"+ _h + ":" + _p + "} Client Progress:" + evt.params.bytes.length );
		var unserializer:Unserializer = new Unserializer(DataListManager.getInstance());
		var messages:Array<Dynamic> = unserializer.unserialize(new BytesInput(evt.params.bytes));
		for(message in messages){
			var messagepair = {message:message, socket:evt.params.sock};
			sendNotification(ServerFacade.READ_MESSAGE, messagepair);
		}
	}
	
	function onErrorHandler(evt:NetworkEvent):Void
	{
		LogerTool.print( "{"+ _h + ":" + _p + "} Server Error:" + evt.params );
	}
	
	function onDisconnectHandler(evt:NetworkEvent):Void
	{
		LogerTool.print( "{"+ _h + ":" + _p + "} Client Disconnected" );
		sendNotification(ServerFacade.CLIENT_LEAVE, evt.params);
	}
	
	function onCloseHandler(evt:NetworkEvent):Void
	{
		LogerTool.print( "{"+ _h + ":" + _p + "} Server Closed" );
	}
	
	var _h:String;
	var _p:Int;
	var socketProtocol:SocketListenerProtocol<Dynamic>;
	
	static public inline var NAME:String = "SocketListenerProxy";
}