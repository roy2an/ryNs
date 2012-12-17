package cn.royan.haxe.parses;

import cn.royan.haxe.parses.MacroParse;
import cn.royan.haxe.core.objects.Message;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */
 
class MessageParse extends MacroParse<{message:Message,socket:Socket}>{
	static private var __instance:MessageParse;
	static public function getInstance():MessageParse
	{
		if(__instance == null) __instance = new MessageParse();
		return __instance;
	}
	
	private function new(){
		super();
		
		addSubParse(LoginParse);
		addSubParse(LogoutParse);
		addSubParse(OrderParse);
		addSubParse(PageParse);
		addSubParse(WordParse);
	}
}