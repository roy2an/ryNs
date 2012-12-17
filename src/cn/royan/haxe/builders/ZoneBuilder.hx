package cn.royan.haxe.builders;

import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.values.SerZone;

/**
 * ...
 * @author RoYan
 */

class ZoneBuilder implements IBuilder<SerZone>{
	var result:SerZone;
	public function new (){}
	
	public function build(o:Dynamic):IBuilder<SerZone>
	{
		result = new SerZone();
		result.setName(o.name);
		result.setType(o.type);
		result.setMax(o.max);
		
		var rooms:Array<Dynamic> = o.rooms;
		
		for(r in rooms){
			result.addRoom(new RoomBuilder().build(r).getResult());
		}
		return this;
	}
	
	public function getResult():SerZone
	{
		return result;
	}
}