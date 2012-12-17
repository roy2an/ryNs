package cn.royan.haxe.requests.users;

/**
 * ...
 * @author RoYan
 */

class FindUsersRequest extends PageRequest{
	static public inline var CODE:Int	= PageRequest.CODE;
	static public inline var TYPE:Int = 502;
	
	public function new() {
		super();
	}
}