package cn.royan.haxe.requests.rooms;

/**
 * ...
 * @author RoYan
 */

class FindRoomsRequest extends PageRequest{
	static public inline var CODE:Int	= PageRequest.CODE;
	static public inline var TYPE:Int = 501;
	
	public function new() {
		super();
	}
}