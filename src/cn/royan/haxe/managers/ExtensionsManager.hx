package cn.royan.haxe.managers;

import cn.royan.haxe.interfaces.IExtensionsManager;
import cn.royan.haxe.core.objects.Extension;

/**
 * ...
 * @author RoYan
 */
 
class ExtensionsManager implements IExtensionsManager{
	var libs:Hash<Extension>;
	static var _instance:ExtensionsManager;
	static public function getInstance():ExtensionsManager
	{
		if(_instance == null) _instance = new ExtensionsManager();
		return _instance;
	}
	
	function new() {
		libs = new Hash<Extension>();
	}
	
	public function registerExtension(code:String, ext:Extension):Void
	{
		libs.set(code,ext);
	}
	
	public function retrieveExtension(code:String):Extension
	{
		return libs.get(code);
	}
}