package cn.royan.haxe.responses.words;

import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.Zone;
import cn.royan.haxe.responses.WordResponse;

/**
 * ...
 * @author RoYan
 */

class PublicWordResponse extends WordResponse{
	static inline var TYPE:Int = 402;
	
	public function new(word:String, ?user:User, ?room:Room, ?zone:Zone) {
		super(TYPE, word, user, room, zone);
	}
}