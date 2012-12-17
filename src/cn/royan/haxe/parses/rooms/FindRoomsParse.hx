package cn.royan.haxe.parses.rooms;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.requests.rooms.FindRoomsRequest;
import cn.royan.haxe.responses.rooms.FindRoomsResponse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class FindRoomsParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.message);
		
		executeExtension(info);
		
		var findRoomsResponse:FindRoomsResponse = new FindRoomsResponse(1,1,{name:"test"},[]);
		
		sendNotification(ServerFacade.SEND_MESSAGE,{socket:info.socket,message:findRoomsResponse});
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionsManager.retrieveExtension("findRooms");
		if( extension != null )
		{
			extension.execute(v);
		}
		return true;
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return cast(info.message).type == FindRoomsRequest.TYPE;
	}
}