package cn.royan.haxe.requests.buddys;

/**
 * ...
 * @author RoYan
 */

class BlockBuddyRequest extends OrderRequest{
	static public inline var CODE:Int	= 232;
	static inline var ORDERS:Array<String> = ['buddyName','blocked'];
	
	public var buddyName:String;
	public var blocked:Bool;
	
	public function new() {
		super(CODE, ORDERS);
	}
}