package cn.royan.haxe.requests.rooms;

/**
 * ...
 * @author RoYan
 */

class SetRoomVariablesRequest extends OrderRequest{
	static public inline var CODE:Int	= 215;
	static inline var ORDERS:Array<String> = ['roomVariables','room'];
	
	public var roomVariables:Array<Dynamic>;
	public var room:Bool;
	
	public function new() {
		super(CODE, ORDERS);
	}
}