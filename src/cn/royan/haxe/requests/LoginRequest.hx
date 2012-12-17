package cn.royan.haxe.requests;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class LoginRequest extends Message, implements IBuilder<LoginRequest>{
	static public inline var CODE:Int	= 101;
	static inline var ORDERS:Array<String> = ['name','pswd','zone','params'];
	
	public var name:String;
	public var pswd:String;
	public var zone:String;
	public var params:Data;
	
	public function new() {
		super(CODE, ORDERS);
	}
	
	public function build(o:Dynamic):IBuilder<LoginRequest>
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
	
	public function getResult():LoginRequest
	{
		return this;
	}
	
	public function toString():String
	{
		return "[LoginRequest=>{name:"+name+", pswd:"+pswd+", zone:"+zone+", params:"+params+"}]";
	}
}