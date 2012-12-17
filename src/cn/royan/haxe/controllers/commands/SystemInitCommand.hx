package cn.royan.haxe.controllers.commands;

import cn.royan.haxe.ServerFacade;
import cn.royan.haxe.core.objects.FileInfo;
import cn.royan.haxe.proxys.FileLoaderProxy;
import org.puremvc.haxe.interfaces.ICommand;
import org.puremvc.haxe.interfaces.INotification;
import org.puremvc.haxe.patterns.command.SimpleCommand;

/**
 * ...
 * @author RoYan
 */

class SystemInitCommand extends SimpleCommand, implements ICommand{
	override public function execute(notification:INotification):Void
	{
		sendNotification(ServerFacade.REGIST_LISTEN);
		
		if ( !facade.hasProxy( FileLoaderProxy.NAME ) )
			facade.registerProxy( new FileLoaderProxy() );
		
		var files:Array<FileInfo> = [];
			files.push({info:"Config",
						path:notification.getBody(),
						version:"1.0",
						field:"Config",
						data:null,
						format:"json"});
		
		var fileloaderProxy:FileLoaderProxy = cast( facade.retrieveProxy( FileLoaderProxy.NAME ) );
			fileloaderProxy.load( files );
	}
}