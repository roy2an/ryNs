package cn.royan.haxe.parses;

import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.requests.WordRequest;
import haxe.remoting.SocketProtocol.Socket;

import cn.royan.haxe.parses.words.AdminWordParse;
import cn.royan.haxe.parses.words.PublicWordParse;
import cn.royan.haxe.parses.words.PrivateWordParse;
import cn.royan.haxe.parses.words.BuddyWordParse;
import cn.royan.haxe.parses.words.ModeratorWordParse;

/**
 * ...
 * @author RoYan
 */

class WordParse extends MacroParse<{message:Message,socket:Socket}>{
	public function new(){
		super();
		
		addSubParse(AdminWordParse);
		addSubParse(PublicWordParse);
		addSubParse(PrivateWordParse);
		addSubParse(BuddyWordParse);
		addSubParse(ModeratorWordParse);
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return info.message.getCode() == WordRequest.CODE;
	}
}