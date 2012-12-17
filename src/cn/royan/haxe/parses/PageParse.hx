package cn.royan.haxe.parses;

import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.requests.PageRequest;
import cn.royan.haxe.parses.rooms.FindRoomsParse;
import cn.royan.haxe.parses.users.FindUsersParse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class PageParse extends MacroParse<{message:Message,socket:Socket}>{
	public function new(){
		super();
		
		addSubParse(FindRoomsParse);
		addSubParse(FindUsersParse);
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return info.message.getCode() == PageRequest.CODE;
	}
}