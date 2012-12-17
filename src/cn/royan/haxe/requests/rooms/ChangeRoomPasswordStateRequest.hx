package cn.royan.haxe.requests.rooms;

/**
 * ...
 * @author RoYan
 */

class ChangeRoomPasswordStateRequest extends OrderRequest{
	static public inline var CODE:Int	= 214;
	static inline var ORDERS:Array<String> = ['room','newPass'];
	
	public var room:Int;
	public var newPass:String;
	
	public function new() {
		super(CODE, ORDERS);
	}
}