package cn.royan.haxe.parses.rooms;

import cn.royan.haxe.ServerFacade;
import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.builders.RoomBuilder;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.requests.rooms.CreateRoomRequest;
import cn.royan.haxe.responses.rooms.CreateRoomResponse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class CreateRoomParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.socket.custom.client);
		var createRoomRequest:CreateRoomRequest = cast info.message;
		trace(createRoomRequest.settings);
		trace(createRoomRequest.autoJoin);
		trace(createRoomRequest.roomToLeave);
		
		//var room:Room = new RoomBuilder().build().getResult();
		
		var createRoomResponse:CreateRoomResponse = new CreateRoomResponse(1);
			//createRoomResponse.params = room;
		
		sendNotification(ServerFacade.SEND_MESSAGE,{socket:info.socket,message:createRoomResponse});
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionsManager.retrieveExtension("createRoom");
		if( extension != null )
		{
			extension.execute(v);
		}
		return true;
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return info.message.getCode() == CreateRoomRequest.CODE;
	}
}