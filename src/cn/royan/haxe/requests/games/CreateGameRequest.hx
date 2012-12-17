package cn.royan.haxe.requests.games;

/**
 * ...
 * @author RoYan
 */

class CreateGameRequest extends OrderRequest{
	static public inline var CODE:Int	= 222;
	static inline var ORDERS:Array<String> = ['settings'];
	
	public var settings:Array<Dynamic>;
	
	public function new() {
		super(CODE, ORDERS);
	}
}