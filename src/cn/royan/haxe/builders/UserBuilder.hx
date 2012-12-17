package cn.royan.haxe.builders;

import cn.royan.haxe.values.SerUser;
import cn.royan.haxe.interfaces.IBuilder;

/**
 * ...
 * @author RoYan
 */

class UserBuilder implements IBuilder<SerUser>{
	var result:SerUser;
	public function new (){}
	
	public function build(o:Dynamic):IBuilder<SerUser>
	{
		result = new SerUser();
		result.setName(o.name);
		result.setType(o.type);
		result.setSocket(o.socket);
		return this;
	}
	
	public function getResult():SerUser
	{
		return result;
	}
}