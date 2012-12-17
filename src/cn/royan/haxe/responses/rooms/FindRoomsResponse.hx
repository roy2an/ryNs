package cn.royan.haxe.responses.rooms;

import cn.royan.haxe.responses.PageResponse;

/**
 * ...
 * @author RoYan
 */

class FindRoomsResponse extends PageResponse{
	static public inline var CODE:Int	= 501;
	
	public function new(page:Int, total:Int, params:Dynamic, list:Array<Dynamic>) {
		super(CODE, page, total, params, list);
	}
}