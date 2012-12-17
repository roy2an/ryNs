package cn.royan.haxe.requests.rooms;

/**
 * ...
 * @author RoYan
 */

class ChangeRoomNameRequest extends OrderRequest{
	static public inline var CODE:Int	= 213;
	static inline var ORDERS:Array<String> = ['room','newName'];
	
	public var room:Int;
	public var newName:String;
	
	public function new() {
		super(CODE, ORDERS);
	}
}