package cn.royan.haxe.managers;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.RoomType;
import cn.royan.haxe.interfaces.IRoomListManager;

/**
 * ...
 * @author RoYan
 */

class RoomListManager implements IRoomListManager{
	var max:Int;
	var fixedRoom:Room;
	var list:Array<Room>;
	public function new(?max:Int = 100){
		this.max = max;
		list = [];
	}
	
	public function addRoom(room:Room):Bool
	{
		if(containsRoom(room.getName())) return false;
		LogerTool.print(room.toString()+" is added");
		list.push(room);
		if(room.getType() == priority) fixedRoom = room;
		return true;
	}
	
	public function removeRoom(room:Room):Bool
	{
		return list.remove(room);
	}
	
	public function removeRoomById(id:Int):Bool
	{
		for(room in list){
			if(room.getId() == id) return true;
		}
		return false;
	}
	
	public function removeRoomByName(name:String):Bool
	{
		for(room in list){
			if(room.getName() == name) return true;
		}
		return false;
	}
	
	public function getFixedRoom():Room
	{
		return fixedRoom;
	}
	
	public function getRoomById(id:Int):Room
	{
		for(room in list){
			if(room.getId() == id) return room;
		}
		return null;
	}
	
	public function getRoomByName(name:String):Room
	{
		for(room in list){
			if(room.getName() == name) return room;
		}
		return null;
	}
	
	public function containsRoom(name:String):Bool
	{
		for(room in list){
			if(room.getName() == name) return true;
		}
		return false;
	}
	
	public function containsRoomInGroup(idOrName:Dynamic,groupId:String):Bool
	{
		return false;
	}
	
	public function getRoomGroups():Array<Room>
	{
		return [];
	}
	
	public function getRoomListFromGroup(groupId:String):Array<Room>
	{
		return [];
	}
	
	public function addUser(user:User, room:Room):Bool
	{
		return false;
	}
	
	public function removeUser(user:User):Bool
	{
		for(room in list){
			if(room.containsUser(user.getName())) return room.removeUser(user);
		}
		return false;
	}
	
	public function removeUserById(id:Int):Bool
	{
		for(room in list){
			if(room.getUserById(id) != null ) return room.removeUserById(id);
		}
		return false;
	}
	
	public function removeUserByName(name:String):Bool
	{
		for(room in list){
			if(room.getUserByName(name) != null ) return room.removeUserByName(name);
		}
		return false;
	}
	
	public function getUserById(id:Int):User
	{
		for(room in list){
			if(room.getUserById(id) != null ) return room.getUserById(id);
		}
		return null;
	}
	
	public function getUserByName(name:String):User
	{
		for(room in list){
			if(room.getUserByName(name) != null ) return room.getUserByName(name);
		}
		return null;
	}
	
	public function getUserRooms(user:User):Array<Room>
	{
		var rooms:Array<Room> = [];
		for(room in list){
			if(room.getUserById(user.getId())!=null)
			{
				rooms.push(room);
			}
		}
		return rooms;
	}
	
	public function containsUser(name:String):Bool
	{
		for(room in list){
			if(room.containsUser(name)) return true;
		}
		return false;
	}
	
	public function clearAll():Void
	{
		list = [];
	}
	
	public function getSize():Int
	{
		return list.length;
	}
	
	public function getMaxSize():Int
	{
		return max;
	}
	
	public function isEmpty():Bool
	{
		return getSize() == 0;
	}
	
	public function isFull():Bool
	{
		return getSize() >= getMaxSize();
	}
	
	public function toArray():Array<Room>
	{
		return list;
	}
}