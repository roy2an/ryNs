package cn.royan.haxe.mediators;

import cn.royan.haxe.ServerFacade;
import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.managers.ZoneListManager;
import cn.royan.haxe.parses.MessageParse;
import cn.royan.haxe.proxys.FileLoaderProxy;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Zone;
import cn.royan.haxe.core.objects.Room;
import org.puremvc.haxe.interfaces.IMediator;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.mediator.Mediator;
#if neko
import neko.Lib;
#elseif cpp
import cpp.Lib;
#end

/**
 * ...
 * @author RoYan
 */

class ConsoleMediator extends Mediator, implements IMediator{
	public function new(){
		super(ConsoleMediator.NAME);
		
		sendNotification(ServerFacade.SERVER_TIMER);
	}
	
	override public function listNotificationInterests():Array<String> 
	{
		return [FileLoaderProxy.FILE_LOADED,
				FileLoaderProxy.FILE_COMPLETE,
				ServerFacade.READ_MESSAGE,
				ServerFacade.CLIENT_LEAVE];
	}
	
	override public function handleNotification(notification:INotification):Void 
	{
		switch( notification.getName() ){
			case FileLoaderProxy.FILE_LOADED:
				sendNotification( ServerFacade.SYSTEM_OPEN, notification.getBody().data );
			case FileLoaderProxy.FILE_COMPLETE:
				if(notification.getBody().info == "Config"){
					loop();
				}
			case ServerFacade.READ_MESSAGE:
				LogerTool.print(notification.getBody().message);
				MessageParse.getInstance().parse(cast notification.getBody());
			case ServerFacade.CLIENT_LEAVE:
				var user:User = cast notification.getBody().custom.client;
				if(user != null){
					var rooms:Array<Room> = cast(ZoneListManager.getInstance()).getUserRooms(user);
					for(room in rooms){
						room.removeUser(user);
					}
				}
		}
	}
	
	function loop():Void
	{
		while(true){
			var command = Sys.stdin().readLine();
			switch( command ){
				case "zone":
					Lib.println("|--------------------------------|");
					Lib.println(ZoneListManager.getInstance().toArray());
					Lib.println("|--------------------------------|");
				case "room":
					Lib.println("|--------------------------------|");
					Lib.println("no implements");
					Lib.println("|--------------------------------|");
				case "player":
					Lib.println("|--------------------------------|");
					Lib.println("no implements");
					Lib.println("|--------------------------------|");
				case "exit":
					Lib.println("|--------------------------------|");
					Lib.println("bye!");
					Lib.println("|--------------------------------|");
					break;
				case "quit":
					Lib.println("|--------------------------------|");
					Lib.println("bye!");
					Lib.println("|--------------------------------|");
					break;
				case "dump":
					Lib.println("|--------------------------------|");
					Lib.println("no implements");
					Lib.println("|--------------------------------|");
				default:
					Lib.println("|--------------------------------|");
					Lib.println("no implements");
					Lib.println("|--------------------------------|");
			}
		}
	}
	
	static public inline var NAME:String = "ConsoleMediator";
}