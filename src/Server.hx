package;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.ServerFacade;

/**
 * ...
 * @author RoYan
 */
 
class Server {
	var facade:ServerFacade;
	private function new()
	{
		initialize();

		facade = ServerFacade.getInstance();
		facade.startUp();
	}
	
	private function initialize():Void
	{
		LogerTool.init(true);
	}
	
	static public function main()
	{
		new Server();
	}
}