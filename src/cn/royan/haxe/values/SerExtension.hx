package cn.royan.haxe.values;

import cn.royan.haxe.core.objects.Extension;
import neko.vm.Loader;
import neko.vm.Module;

/**
 * ...
 * @author RoYan
 */

class SerExtension implements Extension{
	var safeLoader:Loader;
	var module:Module;
	var plugin:Extension;
	public function new() {
        safeLoader = Loader.make(loadPrimitive, Loader.local().loadModule);
	}
	
	public function setFile(file:String):Void
	{
		module = safeLoader.loadModule(file);
        var classes:Dynamic = module.exportsTable().__classes;
    	plugin = Type.createInstance(classes.Plugin, []);
	}
	
	public function execute(v:Dynamic):Dynamic
	{
		return plugin.execute(v);
	}
	
	function outOfSandbox(f:Array<Dynamic>):Dynamic {
		throw "sandbox exception";
    }
    
    function loadPrimitive(name:String, nargs:Int):Dynamic {
        if (name == "std@file_delete")
            return Reflect.makeVarArgs(outOfSandbox);
        return Loader.local().loadPrimitive(name, nargs);
    }
}