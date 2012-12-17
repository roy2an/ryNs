package cn.royan.haxe.managers;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.UserType;
import cn.royan.haxe.interfaces.IUserListManager;

/**
 * ...
 * @author RoYan
 */

class UserListManager implements IUserListManager{
	var max:Int;
	var list:Array<User>;
	var fixedUser:User;
	public function new(max:Int) {
		list = [];
		this.max = max;
	}
	
	public function addUser(user:User):Bool
	{
		if(containsUser(user.getName())) return false;
		LogerTool.print(user.toString()+" is added");
		list.push(user);
		if(user.getType() == owner) fixedUser = user;
		return true;
	}
	
	public function removeUser(user:User):Bool
	{
		return list.remove(user);
	}
	
	public function removeUserById(id:Int):Bool
	{
		for(user in list){
			if(user.getId() == id) return list.remove(user);
		}
		return false;
	}
	
	public function removeUserByName(name:String):Bool
	{
		for(user in list){
			if(user.getName() == name) return list.remove(user);
		}
		return false;
	}
	
	public function getUserById(id:Int):User
	{
		for(user in list){
			if(user.getId() == id) return user;
		}
		return null;
	}
	
	public function getUserByName(name:String):User
	{
		for(user in list){
			if(user.getName() == name) return user;
		}
		return null;
	}
	
	public function containsUser(name:String):Bool
	{
		for(user in list){
			if(user.getName() == name) return true;
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
	
	public function toArray():Array<User>
	{
		return list;
	}
}