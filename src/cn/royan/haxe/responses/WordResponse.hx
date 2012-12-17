package cn.royan.haxe.responses;

import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Data;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.Zone;
import cn.royan.haxe.core.objects.Message;

/**
 * ...
 * @author RoYan
 */

class WordResponse extends Message{
	static public inline var CODE:Int	= 104;
	static inline var ORDERS:Array<String> = ['type','word','user','room','zone'];
	
	var _t:Int;
	var _w:String;
	var _u:User;
//	var _un:String;
	var _r:Int;
	var _z:Int;
	
	public function new(type:Int, word:String, ?user:User, ?room:Room, ?zone:Zone){
		_t = type;
		_w = word;
		_u = user;//==null?0:user.getId();
//		_un = user==null?"":user.getName();
		_r = room==null?0:room.getId();
		_z = zone==null?0:zone.getId();
		
		super(CODE, ORDERS);
	}
	
	public function getType():Int
	{
		return _t;
	}
	
	public function getWord():String
	{
		return _w;
	}
	
	public function getUser():User
	{
		return _u;
	}
	
//	public function getUserName():String
//	{
//		return _un;
//	}
	
	public function getRoom():Int
	{
		return _r;
	}
	
	public function getZone():Int
	{
		return _z;
	}
}