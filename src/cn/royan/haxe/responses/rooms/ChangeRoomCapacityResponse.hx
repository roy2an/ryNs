package cn.royan.haxe.responses.rooms;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class ChangeRoomCapacityResponse extends Message, implements IBuilder<ChangeRoomCapacityResponse>{
	static public inline var CODE:Int	= 103;
	static inline var ORDERS:Array<String> = ['orderType','orderData'];
	
	public var orderType:Int;
	public var orderData:Message;
	
	public function new() {
		super(CODE, ORDERS);
	}
	
	public function build(o:Dynamic):IBuilder<ChangeRoomCapacityResponse>
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
	
	public function getResult():ChangeRoomCapacityResponse
	{
		return this;
	}
	
	public function toString():String
	{
		return "[ChangeRoomCapacityResponse=>{orderType:"+orderType+", orderData:"+orderData+"}]";
	}
}