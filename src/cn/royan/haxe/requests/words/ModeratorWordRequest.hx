package cn.royan.haxe.requests.words;

import cn.royan.haxe.requests.WordRequest;

/**
 * ...
 * @author RoYan
 */

class ModeratorWordRequest extends WordRequest{
	static public inline var CODE:Int = WordRequest.CODE;
	static public inline var TYPE:Int = 405;
	
	public function new() {
		super();
	}
}