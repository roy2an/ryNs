package cn.royan.haxe.requests.rooms;

/**
 * ...
 * @author RoYan
 */

class CreateRoomRequest extends OrderRequest{
	static public inline var CODE:Int	= 211;
	static inline var ORDERS:Array<String> = ['settings','autoJoin','roomToLeave'];
	
	public var settings:Array<Dynamic>;
	public var autoJoin:Bool;
	public var roomToLeave:Int;
	
	public function new() {
		super(CODE, ORDERS);
	}
}