package cn.royan.haxe.values;

import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.Zone;
import cn.royan.haxe.core.objects.ZoneType;
import cn.royan.haxe.managers.RoomListManager;
import cn.royan.haxe.interfaces.IRoomListManager;

/**
 * ...
 * @author RoYan
 */

class SerZone implements Zone{
	static public inline var CODE:Int = 26;
	static inline var orders:Array<String> = ['id','name','max','type'];
	var id:Int;
	var max:Int;
	var type:ZoneType;
	var name:String;
	var roomListManager:IRoomListManager;
	static var __id:Int = 0;
	
	public function new() {
		id = ++__id;
		max = 100;
		type = normal;
		roomListManager = new RoomListManager(max);
	}
	
	public function getId():Int
	{
		return id;
	}
	
	public function setMax(value:Int):Void
	{
		max = value;
	}
	
	public function getMax():Int
	{
		return max;
	}
	
	public function setType(value:String):Void
	{
		if(value == null) value = "normal";
		type = switch(value){
						case "priority":
							priority;
						case "normal":
							normal;
						case "hidden":
							hidden;
					};
	}
	
	public function getType():ZoneType
	{
		return type;
	}
	
	public function setName(value:String):Void
	{
		name = value;
	}
	
	public function getName():String
	{
		return name;
	}
	
	public function addRoom(room:Room):Bool
	{
		return roomListManager.addRoom(room);
	}
	
	public function containsRoom(name:String):Bool
	{
		return roomListManager.containsRoom(name);
	}
	
	public function getRoomById(id:Int):Room
	{
		return roomListManager.getRoomById(id);
	}
	
	public function getRoomByName(name:String):Room
	{
		return roomListManager.getRoomByName(name);
	}
	
	public function removeRoom(room:Room):Bool
	{
		return roomListManager.removeRoom(room);
	}
	
	public function removeRoomById(id:Int):Bool
	{
		return roomListManager.removeRoomById(id);
	}
	
	public function removeRoomByName(name:String):Bool
	{
		return roomListManager.removeRoomByName(name);
	}
	
	public function addUser(user:User, room:Room):Bool
	{
		return roomListManager.addUser(user, room);
	}
	
	public function removeUser(user:User):Bool
	{
		return roomListManager.removeUser(user);
	}
	
	public function removeUserById(id:Int):Bool
	{
		return roomListManager.removeUserById(id);
	}
	
	public function removeUserByName(name:String):Bool
	{
		return roomListManager.removeUserByName(name);
	}
	
	public function getUserById(id:Int):User
	{
		return roomListManager.getUserById(id);
	}
	
	public function getUserByName(name:String):User
	{
		return roomListManager.getUserByName(name);
	}
	
	public function getUserRooms(user:User):Array<Room>
	{
		return cast(roomListManager).getUserRooms(user);
	}
	
	public function containsUser(name:String):Bool
	{
		return roomListManager.containsUser(name);
	}
	
	public function getRoomListManager():IRoomListManager
	{
		return roomListManager;
	}
	
	public function toString():String
	{
		return "[Zone=>{id:"+getId()+", max:"+getMax()+", name:"+getName()+", size:"+roomListManager.getSize()+", type:"+getType()+"}]";
	}
	
	public function getCode():Int
	{
		return CODE;
	}
	
	public function getFieldOrder():Array<String>
	{
		return orders;
	}
}