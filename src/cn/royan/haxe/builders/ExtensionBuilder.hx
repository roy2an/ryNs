package cn.royan.haxe.builders;

import cn.royan.haxe.values.SerExtension;
import cn.royan.haxe.interfaces.IBuilder;

/**
 * ...
 * @author RoYan
 */

class ExtensionBuilder implements IBuilder<SerExtension>{
	var result:SerExtension;
	public function new (){}
	
	public function build(o:Dynamic):IBuilder<SerExtension>
	{
		result = new SerExtension();
		result.setFile(o.file);
		return this;
	}
	
	public function getResult():SerExtension
	{
		return result;
	}
}