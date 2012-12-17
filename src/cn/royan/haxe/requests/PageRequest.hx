package cn.royan.haxe.requests;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class PageRequest extends Message, implements IBuilder<PageRequest>{
	static public inline var CODE:Int	= 105;
	static inline var ORDERS:Array<String> = ['type','page','limit','params'];
	
	public var type:Int;
	public var page:Int;
	public var limit:Int;
	public var params:Dynamic;
	
	public function new() {
		super(CODE, ORDERS);
	}
	
	public function build(o:Dynamic):IBuilder<PageRequest>
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
	
	public function getResult():PageRequest
	{
		return this;
	}
	
	public function toString():String
	{
		return "[PageRequest=>{type:"+type+", current:"+page+", number:"+limit+", params:"+params+"}]";
	}
	
}