package cn.royan.haxe.responses;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;

/**
 * ...
 * @author RoYan
 */

class LogoutResponse extends Message{
	static public inline var CODE:Int	= 102;
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