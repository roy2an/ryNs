package cn.royan.haxe.parses.words;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.events.RSCEvent;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.managers.ZoneListManager;
import cn.royan.haxe.requests.words.PrivateWordRequest;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class PrivateWordParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.message);
		
		var privateWordRequest:PrivateWordRequest = cast info.message;
		
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
		return (cast info.message).type == PrivateWordRequest.TYPE;
	}
}