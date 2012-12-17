package cn.royan.haxe.parses;

import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class ExtensionParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.socket.custom.client);
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionManager.retrieveExtension("extension");
		if( extension != null )
		{
			extension.execute(v);
		}
		return true;
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return info.message.getCode() == LoginRequest.CODE;
	}
}