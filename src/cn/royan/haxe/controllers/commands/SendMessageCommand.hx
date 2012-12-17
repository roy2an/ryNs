package cn.royan.haxe.controllers.commands;

import cn.royan.haxe.proxys.SocketListenerProxy;
import org.puremvc.haxe.interfaces.ICommand;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
 * ...
 * @author RoYan
 */
 
class SendMessageCommand extends SimpleCommand, implements ICommand{
	override public function execute(notification:INotification):Void
	{
		var socketProxy:SocketListenerProxy = cast(facade.retrieveProxy( SocketListenerProxy.NAME ));
			socketProxy.sendMessage(notification.getBody().socket, notification.getBody().message);
	}
}