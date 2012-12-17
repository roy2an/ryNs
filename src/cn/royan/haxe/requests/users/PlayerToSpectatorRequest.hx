package cn.royan.haxe.requests.users;

/**
 * ...
 * @author RoYan
 */

class PlayerToSpectatorRequest extends OrderRequest{
	static public inline var CODE:Int	= 204;
	static inline var ORDERS:Array<String> = ['settings','autoJoin','roomToLeave'];
	
	public var settings:Array<Dynamic>;
	public var autoJoin:Bool;
	public var roomToLeave:Int;
	
	public function new() {
		super(CODE, ORDERS);
	}
}