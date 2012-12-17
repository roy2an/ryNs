package cn.royan.haxe.proxys;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.NetworkEvent;
import cn.royan.haxe.protocols.RemotingListenerProtocol;
import org.puremvc.haxe.interfaces.IProxy;

/**
 * ...
 * @author RoYan
 */

class RemotingListenerProxy extends SocketListenerProxy, implements IProxy{
	public function new(?name:String) 
	{
		super( name!=null?name:RemotingListenerProxy.NAME );
	}
	
	override public function openSystem( host:String, port:Int, max:Int ):Void
	{
		_h = host;
		_p = port;
		LogerTool.print( "Listener Starting Server:{" + host + ":" + port + "}" );
		remotingProtocol = new RemotingListenerProtocol( host, port, max );
		remotingProtocol.addEventListener( NetworkEvent.NETWORK_START, 		onStartHandler );
		remotingProtocol.addEventListener( NetworkEvent.NETWORK_CONNECT, 	onConnectHandler );
		remotingProtocol.addEventListener( NetworkEvent.NETWORK_PROGRESS, 	onProgressHandler );
		remotingProtocol.addEventListener( NetworkEvent.NETWORK_ERROR, 		onErrorHandler );
		remotingProtocol.addEventListener( NetworkEvent.NETWORK_DISCONNECT, onDisconnectHandler );
		remotingProtocol.addEventListener( NetworkEvent.NETWORK_CLOSE, 		onCloseHandler );
		remotingProtocol.sendRequest();
		remotingProtocol.connect();
	}
	
	override public function stopServer():Void
	{
		remotingProtocol.disconnect();
	}
	
	var remotingProtocol:RemotingListenerProtocol;
	static public inline var NAME:String = "RemotingListenerProxy";
}