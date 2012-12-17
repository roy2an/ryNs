package cn.royan.haxe.requests.games;

/**
 * ...
 * @author RoYan
 */

class QuickJoinGameRequest extends OrderRequest{
	static public inline var CODE:Int	= 221;
	static inline var ORDERS:Array<String> = ['params','roomToLeave'];
	
	public var roomToLeave:Int;
	public var params:Dynamic;
	
	public function new() {
		super(CODE, ORDERS);
	}
}