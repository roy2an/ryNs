package cn.royan.haxe.requests.users;

/**
 * ...
 * @author RoYan
 */

class JoinRoomRequest extends OrderRequest{
	static public inline var CODE:Int	= 201;
	static inline var ORDERS:Array<String> = ['id','pass','roomToLeave','asSpect'];
	
	public var id:Dynamic;
	public var pass:String;
	public var roomToLeave:Int;
	public var asSpect:Bool;
	
	public function new() {
		super(CODE, ORDERS);
	}
}