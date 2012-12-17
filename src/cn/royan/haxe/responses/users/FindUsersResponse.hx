package cn.royan.haxe.responses.users;

import cn.royan.haxe.responses.PageResponse;

/**
 * ...
 * @author RoYan
 */

class FindUsersResponse extends PageResponse{
	static inline var TYPE:Int = 502;
	
	public function new(page:Int, total:Int, params:Dynamic, list:Array<Dynamic>) {
		super(TYPE, page, total, params, list);
	}
}