package cn.royan.haxe.requests;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class OrderRequest extends Message, implements IBuilder<OrderRequest>{
	static public inline var CODE:Int	= 103;
	static inline var ORDERS:Array<String> = ['isOrder'];
	
	public var isOrder:Bool;
	
	public function new(type:Int,orders:Array<String>) {
		super(type, ORDERS.concat(orders));
	}
	
	public function build(o:Dynamic):IBuilder<OrderRequest>
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
	
	public function getResult():OrderRequest
	{
		return this;
	}
	
	public function toString():String
	{
		return "[OrderRequest=>{CODE:"+getCode()+", isOrder:"+isOrder+"}]";
	}
}