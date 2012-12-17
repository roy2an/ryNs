package cn.royan.haxe.requests.buddys;

/**
 * ...
 * @author RoYan
 */

class SetBuddyVariablesRequest extends OrderRequest{
	static public inline var CODE:Int	= 234;
	static inline var ORDERS:Array<String> = ['buddyVariables'];
	
	public var buddyVariables:Array<Dynamic>;
	
	public function new() {
		super(CODE, ORDERS);
	}
}