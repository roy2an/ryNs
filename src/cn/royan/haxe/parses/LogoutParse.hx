package cn.royan.haxe.parses;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.builders.UserBuilder;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.requests.LogoutRequest;
import cn.royan.haxe.responses.LogoutResponse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class LogoutParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.socket.custom.client);
		
		var logoutResponse:LogoutResponse = new LogoutResponse(1,null);
		
		sendNotification(ServerFacade.SEND_MESSAGE,{socket:info.socket,message:logoutResponse});
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionsManager.retrieveExtension("logout");
		if( extension != null )
		{
			extension.execute(v);
		}
		return true;
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return info.message.getCode() == LogoutRequest.CODE;
	}
}