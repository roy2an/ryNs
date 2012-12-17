package cn.royan.haxe.requests.buddys;

/**
 * ...
 * @author RoYan
 */

class AddBuddyRequest extends OrderRequest{
	static public inline var CODE:Int	= 231;
	static inline var ORDERS:Array<String> = ['buddyName'];
	
	public var buddyName:String;
	
	public function new() {
		super(CODE, ORDERS);
	}
}