package cn.royan.haxe.builders;

import cn.royan.haxe.values.SerRoom;
import cn.royan.haxe.interfaces.IBuilder;

/**
 * ...
 * @author RoYan
 */

class RoomBuilder implements IBuilder<SerRoom>{
	var result:SerRoom;
	public function new (){}
	
	public function build(o:Dynamic):IBuilder<SerRoom>
	{
		result = new SerRoom();
		result.setName(o.name);
		result.setType(o.type);
		result.setMax(o.max);
		return this;
	}
	
	public function getResult():SerRoom
	{
		return result;
	}
}