package cn.royan.haxe.requests.users;

/**
 * ...
 * @author RoYan
 */

class InvitationReplyRequest extends OrderRequest{
	static public inline var CODE:Int	= 207;
	static inline var ORDERS:Array<String> = ['invitation','invitationReply','params'];
	
	public var invitation:Int;
	public var invitationReply:Int;
	public var params:Dynamic;
	
	public function new() {
		super(CODE, ORDERS);
	}
}