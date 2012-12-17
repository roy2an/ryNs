package cn.royan.haxe.parses;

import cn.royan.haxe.ServerFacade;
import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.builders.UserBuilder;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.core.objects.Extension;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Zone;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.managers.ZoneListManager;
import cn.royan.haxe.requests.LoginRequest;
import cn.royan.haxe.responses.LoginResponse;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class LoginParse extends SimpleParse<{message:Message,socket:Socket}>{
	public function new()
	{
		extensionsManager = ExtensionsManager.getInstance();
		super();
	}
	
	override public function parse( info:{message:Message,socket:Socket} ):Void
	{
		if ( !checkValid( info ) ) return;
		LogerTool.print(info.socket.custom.client);
		var loginRequest:LoginRequest = cast info.message;
		
		var config = {name:loginRequest.name,
					  type:"normal",
					  socket:info.socket};
		var builder:UserBuilder = new UserBuilder();
		var user:User = cast builder.build(config).getResult();
		
		var zone:Zone = ZoneListManager.getInstance().getZoneByName(loginRequest.zone);
		if(zone == null) zone = cast(ZoneListManager.getInstance()).getFixedZone();
		var room:Room = cast(zone.getRoomListManager()).getFixedRoom();
			room.addUser(user);
		
		info.socket.custom.client = user;
		
		var loginResponse:LoginResponse = new LoginResponse(1,null);
		
		sendNotification(ServerFacade.SEND_MESSAGE,{socket:info.socket,message:loginResponse});
	}
	
	override function executeExtension(v:Dynamic):Bool
	{
		var extension:Extension = extensionsManager.retrieveExtension("login");
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