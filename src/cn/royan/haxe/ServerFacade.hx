package cn.royan.haxe;

import cn.royan.haxe.controllers.commands.SystemInitCommand;
import cn.royan.haxe.controllers.commands.SystemOpenCommand;
import cn.royan.haxe.controllers.commands.SendMessageCommand;
import cn.royan.haxe.controllers.commands.RegistListenCommand;
import org.puremvc.haxe.interfaces.IFacade;
import org.puremvc.haxe.patterns.facade.Facade;

/**
 * ...
 * @author RoYan
 */
 
class ServerFacade extends Facade, implements IFacade{
	static private var __instance:ServerFacade;
	static public function getInstance():ServerFacade
	{
		if( __instance == null ) __instance = new ServerFacade();
		return __instance;
	}
	
	public function startUp():Void
	{
		sendNotification(ServerFacade.SYSTEM_INIT,"/Users/RoYan/Documents/workspace/Haxe/nServer/out/conf/Config.json"); //
	}
	
	override private function initializeController():Void
	{
		super.initializeController();
		
		registerCommand(ServerFacade.SYSTEM_INIT,		SystemInitCommand);
		registerCommand(ServerFacade.SYSTEM_OPEN,		SystemOpenCommand);
		registerCommand(ServerFacade.SEND_MESSAGE,		SendMessageCommand);
		registerCommand(ServerFacade.REGIST_LISTEN,		RegistListenCommand);
	}
	
	static public inline var SYSTEM_INIT:String 	= 'system_init';
	static public inline var SYSTEM_OPEN:String		= 'system_open';
	static public inline var REGIST_LISTEN:String	= 'regist_listen';
	
	static public inline var CLIENT_LEAVE:String	= 'client_leave';
	
	static public inline var SEND_MESSAGE:String	= "send_message";
	static public inline var READ_MESSAGE:String	= "read_message";
	
	static public inline var SERVER_TIMER:String	= 'server_timer';
}