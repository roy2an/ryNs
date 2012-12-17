package cn.royan.haxe.controllers.commands;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.builders.ZoneBuilder;
import cn.royan.haxe.builders.ExtensionBuilder;
import cn.royan.haxe.managers.ZoneListManager;
import cn.royan.haxe.managers.ExtensionsManager;
import cn.royan.haxe.proxys.SocketListenerProxy;
import org.puremvc.haxe.interfaces.ICommand;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
 * ...
 * @author RoYan
 */

class SystemOpenCommand extends SimpleCommand, implements ICommand{
	override public function execute(notification:INotification):Void
	{
		var configData:Array<Dynamic>;
		if( !Std.is(notification.getBody(),Array) )
			configData = [notification.getBody()];
		else configData = notification.getBody();
		
		for( item in configData ){
			switch( item.type ){
				case "listener":
					addListenerHandler(Std.string(item.host), Std.int(item.port), Std.int(item.max), item);
				case "listenee":
					addListeneeHandler(Std.string(item.host), Std.int(item.port));
			}
		}
	}
	
	private function addListenerHandler(host:String,port:Int,max:Int,item:Dynamic):Void
	{
		var zones:Array<Dynamic> = item.zones;
		for( zone in zones ){
			ZoneListManager.getInstance().addZone(new ZoneBuilder().build(zone).getResult());
		}
		
		var exts:Array<Dynamic> = item.extensions;
		for( ext in exts ){
			ExtensionsManager.getInstance().registerExtension(ext.target,new ExtensionBuilder().build(ext).getResult());
		}
		
		if ( !facade.hasProxy( SocketListenerProxy.NAME ) )
			facade.registerProxy(new SocketListenerProxy( SocketListenerProxy.NAME ));
		var socketProxy:SocketListenerProxy = cast(facade.retrieveProxy( SocketListenerProxy.NAME ));
			socketProxy.openSystem(host, port, max);
	}
	
	private function addListeneeHandler(host:String,port:Int):Void
	{
		LogerTool.print(host+":"+port);
	}
}