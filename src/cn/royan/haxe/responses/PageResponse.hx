package cn.royan.haxe.responses;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;

/**
 * ...
 * @author RoYan
 */

class PageResponse extends Message{
	static public inline var CODE:Int	= 105;
	static inline var ORDERS:Array<String> = ['type','page','total','params','list'];
	
	var type:Int;
	var page:Int;
	var total:Int;
	var params:Dynamic;
	var list:Array<Dynamic>;
	
	public function new(type:Int, page:Int, total:Int, params:Dynamic, list:Array<Dynamic>) {
		this.type = type;
		this.page = page;
		this.total = total;
		this.params = params;
		this.list = list;
		super(CODE, ORDERS);
	}
	
	public function getType():Int
	{
		return type;
	}
	
	public function getPage():Int
	{
		return page;
	}
	
	public function getTotal():Int
	{
		return total;
	}
	
	public function getParams():Dynamic
	{
		return params;
	}
	
	public function getList():Array<Dynamic>
	{
		return list;
	}
}