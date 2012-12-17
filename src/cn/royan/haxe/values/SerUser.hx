package cn.royan.haxe.values;

import cn.royan.haxe.core.objects.User;
import cn.royan.haxe.core.objects.UserType;
import haxe.remoting.SocketProtocol.Socket;

/**
 * ...
 * @author RoYan
 */

class SerUser implements User{
	static public inline var CODE:Int = 28;
	static inline var orders:Array<String> = ['id','name','type'];
	var id:Int;
	var name:String;
	var socket:Socket;
	var type:UserType;
	static var __id:Int = 0;
	
	public function new() {
		id = ++__id;
		type = normal;
	}
	
	public function getId():Int
	{
		return id;
	}
	
	public function setType(value:String):Void
	{
		if(value == null) value = "normal";
		type = switch(value){
						case "owner":
							owner;
						case "normal":
							normal;
						case "visitor":
							visitor;
						case "hidden":
							hidden;
					};
	}
	
	public function getType():UserType
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
	
	public function setSocket(value:Socket):Void
	{
		socket = value;
	}
	
	public function getSocket():Socket
	{
		return socket;
	}
	
	public function toString():String
	{
		return "[User=>{id:"+getId()+", name:"+getName()+", type:"+getType()+"}]";
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