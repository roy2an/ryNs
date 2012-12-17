package cn.royan.haxe.requests;

import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class LogoutRequest extends Message, implements IBuilder<LogoutRequest>{
	static public inline var CODE:Int	= 102;
	static inline var ORDERS:Array<String> = [];
	
	public function new() {
		super(CODE, ORDERS);
	}
	
	public function build(o:Dynamic):IBuilder<LogoutRequest>
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
	
	public function getResult():LogoutRequest
	{
		return this;
	}
	
	public function toString():String
	{
		return "[LogoutRequest]";
	}
}