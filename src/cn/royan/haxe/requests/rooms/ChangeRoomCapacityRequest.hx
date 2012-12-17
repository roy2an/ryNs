package cn.royan.haxe.requests.rooms;

/**
 * ...
 * @author RoYan
 */

class ChangeRoomCapacityRequest extends OrderRequest{
	static public inline var CODE:Int	= 212;
	static inline var ORDERS:Array<String> = ['room','newMaxUsers','newMaxSpect'];
	
	public var room:Int;
	public var newMaxUsers:Int;
	public var newMaxSpect:Int;
	
	public function new() {
		super(CODE, ORDERS);
	}
}