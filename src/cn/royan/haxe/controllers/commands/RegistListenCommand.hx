package cn.royan.haxe.controllers.commands;

import cn.royan.haxe.mediators.ConsoleMediator;
import org.puremvc.haxe.interfaces.ICommand;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
 * ...
 * @author RoYan
 */
 
class RegistListenCommand extends SimpleCommand, implements ICommand{
	override public function execute(notification:INotification):Void
	{
		if ( !facade.hasMediator(ConsoleMediator.NAME) )
			facade.registerMediator(new ConsoleMediator());
		
	}
}