package cn.royan.haxe.requests;

import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.utils.StringTool;

/**
 * ...
 * @author RoYan
 */

class WordRequest extends Message, implements IBuilder<WordRequest>{
	static public inline var CODE:Int	= 104;
	static inline var ORDERS:Array<String> = ['type','word','user','room','zone'];
	
	public var type:Int;
	public var word:String;
	public var user:Int;
	public var room:Int;
	public var zone:Int;
	
	public function new() {
		super(CODE, ORDERS);
	}
	
	public function build(o:Dynamic):IBuilder<WordRequest>
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
	
	public function getResult():WordRequest
	{
		return this;
	}
	
	public function toString():String
	{
		return "[WordRequest=>{type:"+type+", word:"+word+", user:"+user+", room:"+room+", zone:"+zone+"}]";
	}
}