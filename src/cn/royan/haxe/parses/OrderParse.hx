package cn.royan.haxe.parses;

import cn.royan.haxe.core.objects.Message;
import cn.royan.haxe.requests.OrderRequest;
import haxe.remoting.SocketProtocol.Socket;

import cn.royan.haxe.parses.users.InvitationReplyParse;
import cn.royan.haxe.parses.users.InviteUsersParse;
import cn.royan.haxe.parses.users.JoinRoomParse;
import cn.royan.haxe.parses.users.LeaveRoomParse;
import cn.royan.haxe.parses.users.PlayerToSpectatorParse;
import cn.royan.haxe.parses.users.SetUserVariablesParse;
import cn.royan.haxe.parses.users.SpectatorToPlayerParse;

import cn.royan.haxe.parses.rooms.ChangeRoomCapacityParse;
import cn.royan.haxe.parses.rooms.ChangeRoomNameParse;
import cn.royan.haxe.parses.rooms.ChangeRoomPasswordStateParse;
import cn.royan.haxe.parses.rooms.CreateRoomParse;
import cn.royan.haxe.parses.rooms.SetRoomVariablesParse;

import cn.royan.haxe.parses.games.CreateGameParse;
import cn.royan.haxe.parses.games.QuickJoinGameParse;

import cn.royan.haxe.parses.buddys.AddBuddyParse;
import cn.royan.haxe.parses.buddys.BlockBuddyParse;
import cn.royan.haxe.parses.buddys.RemoveBuddyParse;
import cn.royan.haxe.parses.buddys.SetBuddyVariablesParse;

/**
 * ...
 * @author RoYan
 */

class OrderParse extends MacroParse<{message:Message,socket:Socket}>{
	public function new(){
		super();
		
		//user
		addSubParse(InvitationReplyParse);
		addSubParse(InviteUsersParse);
		addSubParse(JoinRoomParse);
		addSubParse(LeaveRoomParse);
		addSubParse(PlayerToSpectatorParse);
		addSubParse(SetUserVariablesParse);
		addSubParse(SpectatorToPlayerParse);
		//room
		addSubParse(ChangeRoomCapacityParse);
		addSubParse(ChangeRoomNameParse);
		addSubParse(ChangeRoomPasswordStateParse);
		addSubParse(CreateRoomParse);
		addSubParse(SetRoomVariablesParse);
		//game
		addSubParse(CreateGameParse);
		addSubParse(QuickJoinGameParse);
		//buddy
		addSubParse(AddBuddyParse);
		addSubParse(BlockBuddyParse);
		addSubParse(RemoveBuddyParse);
		addSubParse(SetBuddyVariablesParse);
	}
	
	override function checkValid( info:{message:Message,socket:Socket} ):Bool
	{
		return cast(info.message).isOrder == true;
	}
}