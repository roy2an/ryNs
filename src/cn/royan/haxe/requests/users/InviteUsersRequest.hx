package cn.royan.haxe.requests.users;

/**
 * ...
 * @author RoYan
 */

class InviteUsersRequest extends OrderRequest{
	static public inline var CODE:Int	= 206;
	static inline var ORDERS:Array<String> = ['invitedUsers','secondsForAnswer','params'];
	
	public var invitedUsers:Array<Int>;
	public var secondsForAnswer:Int;
	public var params:Dynamic;
	
	public function new() {
		super(CODE, ORDERS);
	}
}