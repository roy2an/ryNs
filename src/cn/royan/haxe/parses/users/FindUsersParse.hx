package cn.royan.haxe.parses.users;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.RSCEvent;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.requests.users.FindUsersRequest;
import cn.royan.haxe.responses.users.FindUsersResponse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class FindUsersParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.message);
		var findUsersRequest:FindUsersRequest = cast info.message;
		
		executeExtension(info);
		
		var findUsersResponse:FindUsersResponse = new FindUsersResponse(1,1,findUsersRequest.params,[]);
		
		sendNotification(ServerFacade.SEND_MESSAGE,{socket:info.socket,message:findUsersResponse});
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionsManager.retrieveExtension("word");
		if( extension != null )
		{
			extension.execute(v);
		}
		return true;
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return cast(info.message).type == FindUsersRequest.TYPE;
	}
}