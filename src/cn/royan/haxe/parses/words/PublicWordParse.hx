package cn.royan.haxe.parses.words;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.RSCEvent;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.managers.ZoneListManager;
import cn.royan.haxe.requests.words.PublicWordRequest;
import cn.royan.haxe.responses.words.PublicWordResponse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class PublicWordParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.message);
		
		var publicWordRequest:PublicWordRequest = cast info.message;
		var user:User = cast info.socket.custom.client;
		var rooms:Array<Room> = cast(ZoneListManager.getInstance()).getUserRooms(user);
		
		var publicWordResponse:PublicWordResponse = new PublicWordResponse(publicWordRequest.word, user);
		for(room in rooms){
			var users:Array<User> = room.getUserListManager().toArray();
			for( roommate in users ){
				sendNotification(ServerFacade.SEND_MESSAGE,{socket:cast(roommate).getSocket(),message:publicWordResponse});
			}
		}
		executeExtension(info);
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionsManager.retrieveExtension("publicWord");
		if( extension != null )
		{
			extension.execute(v.message);
		}
		return true;
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return (cast info.message).type == PublicWordRequest.TYPE;
	}
}