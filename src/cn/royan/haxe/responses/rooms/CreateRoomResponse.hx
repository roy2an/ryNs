package cn.royan.haxe.responses.rooms;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class CreateRoomResponse extends Message{
	static public inline var CODE:Int	= 211;
	static inline var ORDERS:Array<String> = ['type','params'];
	
	var type:Int;
	var params:Data;
	
	public function new(t:Int, ?p:Data) {
		type = t;
		params = p;
		super(CODE, ORDERS);
	}
	
	public function getType():Int
	{
		return type;
	}
	
	public function getParams():Data
	{
		return params;
	}
}