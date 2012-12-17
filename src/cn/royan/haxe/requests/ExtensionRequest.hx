package cn.royan.haxe.requests;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class ExtensionRequest extends Message, implements IBuilder<ExtensionRequest>{
	static public inline var CODE:Int	= 107;
	static inline var ORDERS:Array<String> = ['isExtension'];
	
	public var isExtension:Bool;
	
	public function new(type:Int,orders:Array<String>) {
		super(type, ORDERS.concat(orders));
	}
	
	public function build(o:Dynamic):IBuilder<ExtensionRequest>
	{
		var i:Int = 0;
		for ( f in getFieldOrder() ) {
			if(Reflect.isFunction(Reflect.field(this, "set"+StringTool.toUpperCaseFirst(f))))
				Reflect.callMethod(this,Reflect.field(this, "set"+StringTool.toUpperCaseFirst(f)),[(cast o)[i]]);
			else
				Reflect.setField(this, f, (cast o)[i]);
			i++;
		}
		return this;
	}
	
	public function getResult():ExtensionRequest
	{
		return this;
	}
	
	public function toString():String
	{
		return "[ExtensionRequest=>{CODE:"+getCode()+", isExtension:"+isExtension+"}]";
	}
}