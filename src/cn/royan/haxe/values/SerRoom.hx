package cn.royan.haxe.values;

import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.RoomType;
import cn.royan.haxe.managers.UserListManager;
import cn.royan.haxe.interfaces.IUserListManager;

/**
 * ...
 * @author RoYan
 */

class SerRoom implements Room{
	static public inline var CODE:Int = 27;
	static inline var orders:Array<String> = ['id','name','max','type'];
	
	var id:Int;
	var max:Int;
	var type:RoomType;
	var name:String;
	var groupId:String;
	var userListManager:UserListManager;
	static var __id:Int = 0;
	
	public function new() {
		id = ++__id;
		max = 100;
		type = normal;
		userListManager = new UserListManager(max);
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
	
	public function getType():RoomType
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
	
	public function setGroupId(value:String):Void
	{
		groupId = value;
	}
	
	public function getGroupId():String
	{
		return groupId;
	}
	
	public function addUser(user:User):Bool
	{
		return userListManager.addUser(user);
	}
	
	public function removeUser(user:User):Bool
	{
		return userListManager.removeUser(user);
	}
	
	public function removeUserById(id:Int):Bool
	{
		return userListManager.removeUserById(id);
	}
	
	public function removeUserByName(name:String):Bool
	{
		return userListManager.removeUserByName(name);
	}
	
	public function getUserById(id:Int):User
	{
		return userListManager.getUserById(id);
	}
	
	public function getUserByName(name:String):User
	{
		return userListManager.getUserByName(name);
	}
	
	public function containsUser(name:String):Bool
	{
		return userListManager.containsUser(name);
	}
	
	public function getUserListManager():IUserListManager
	{
		return userListManager;
	}
	
	public function toString():String
	{
		return "[Room=>{id:"+getId()+", max:"+getMax()+", name:"+getName()+", size:"+userListManager.getSize()+"}]";
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