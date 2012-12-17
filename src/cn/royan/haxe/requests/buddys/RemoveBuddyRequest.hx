package cn.royan.haxe.requests.buddys;

/**
 * ...
 * @author RoYan
 */

class RemoveBuddyRequest extends OrderRequest{
	static public inline var CODE:Int	= 233;
	static inline var ORDERS:Array<String> = ['buddyName'];
	
	public var buddyName:String;
	
	public function new() {
		super(CODE, ORDERS);
	}
}