package cn.royan.haxe.managers;

import cn.royan.haxe.utils.LogerTool;
import cn.royan.haxe.interfaces.IZoneListManager;
import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.Room;
import cn.royan.haxe.core.objects.Zone;
import cn.royan.haxe.core.objects.ZoneType;

/**
 * ...
 * @author RoYan
 */

class ZoneListManager implements IZoneListManager{
	var fixedZone:Zone;
	static var _instance:IZoneListManager;
	static public function getInstance():IZoneListManager
	{
		if(_instance == null) _instance = new ZoneListManager();
		return _instance;
	}
	
	var list:Array<Zone>;
	function new() {
		list = [];
	}
	
	public function addZone(zone:Zone):Bool
	{
		if(containsZone(zone.getName())) return false;
		LogerTool.print(zone.toString()+" is added");
		list.push(zone);
		if(zone.getType() == priority) fixedZone = zone;
		return true;
	}
	
	public function removeZone(zone:Zone):Bool
	{
		return list.remove(zone);
	}
	
	public function removeZoneById(id:Int):Bool
	{
		for(zone in list){
			if(zone.getId() == id) return list.remove(zone);
		}
		return false;
	}
	
	public function removeZoneByName(name:String):Bool
	{
		for(zone in list){
			if(zone.getName() == name) return list.remove(zone);
		}
		return false;
	}
	
	public function getZoneById(id:Int):Zone
	{
		for(zone in list){
			if(zone.getId() == id) return zone;
		}
		return null;
	}
	
	public function getZoneByName(name:String):Zone
	{
		for(zone in list){
			if(zone.getName() == name) return zone;
		}
		return null;
	}
	
	public function getFixedZone():Zone
	{
		return fixedZone;
	}
	
	public function getUserRooms(user:User):Array<Room>
	{
		var rooms:Array<Room> = [];
		for(zone in list){
			rooms = rooms.concat(cast(zone).getUserRooms(user));
		}
		return rooms;
	}
	
	public function containsZone(name:String):Bool
	{
		for(zone in list){
			if(zone.getName() == name) return true;
		}
		return false;
	}
	
	public function clearAll():Void
	{
		for(zone in list){
			zone.getRoomListManager().clearAll();
		}
		fixedZone = null;
		list = [];
	}
	
	public function getSize():Int
	{
		return list.length;
	}
	
	public function isEmpty():Bool
	{
		return list.length == 0;
	}
	
	public function toArray():Array<Zone>
	{
		return list;
	}
}