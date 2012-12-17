package cn.royan.haxe.responses.users;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class JoinRoomResponse extends Message, implements IBuilder<JoinRoomResponse>{
	static public inline var CODE:Int	= 205;
	static inline var ORDERS:Array<String> = ['orderType','orderData'];
	
	public var orderType:Int;
	public var orderData:Message;
	
	public function new() {
		super(CODE, ORDERS);
	}
	
	public function build(o:Dynamic):IBuilder<JoinRoomResponse>
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
	
	public function getResult():JoinRoomResponse
	{
		return this;
	}
	
	public function toString():String
	{
		return "[JoinRoomResponse=>{orderType:"+orderType+", orderData:"+orderData+"}]";
	}
}