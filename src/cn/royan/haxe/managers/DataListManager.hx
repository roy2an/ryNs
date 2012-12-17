package cn.royan.haxe.managers;

import cn.royan.haxe.interfaces.IBuilder;
import cn.royan.haxe.interfaces.IDataListManager;
import cn.royan.haxe.builders.ZoneBuilder;
import cn.royan.haxe.values.SerZone;

import cn.royan.haxe.requests.LoginRequest;
import cn.royan.haxe.requests.LogoutRequest;
import cn.royan.haxe.requests.PageRequest;
import cn.royan.haxe.requests.WordRequest;
import cn.royan.haxe.requests.OrderRequest;
import cn.royan.haxe.requests.ExtensionRequest;

import cn.royan.haxe.requests.users.FindUsersRequest;
import cn.royan.haxe.requests.users.InvitationReplyRequest;
import cn.royan.haxe.requests.users.InviteUsersRequest;
import cn.royan.haxe.requests.users.JoinRoomRequest;
import cn.royan.haxe.requests.users.LeaveRoomRequest;
import cn.royan.haxe.requests.users.PlayerToSpectatorRequest;
import cn.royan.haxe.requests.users.SpectatorToPlayerRequest;
import cn.royan.haxe.requests.users.SetUserVariablesRequest;

import cn.royan.haxe.requests.rooms.ChangeRoomCapacityRequest;
import cn.royan.haxe.requests.rooms.ChangeRoomNameRequest;
import cn.royan.haxe.requests.rooms.ChangeRoomPasswordStateRequest;
import cn.royan.haxe.requests.rooms.CreateRoomRequest;
import cn.royan.haxe.requests.rooms.FindRoomsRequest;
import cn.royan.haxe.requests.rooms.SetRoomVariablesRequest;

import cn.royan.haxe.requests.games.CreateGameRequest;
import cn.royan.haxe.requests.games.QuickJoinGameRequest;

import cn.royan.haxe.requests.buddys.AddBuddyRequest;
import cn.royan.haxe.requests.buddys.BlockBuddyRequest;
import cn.royan.haxe.requests.buddys.RemoveBuddyRequest;
import cn.royan.haxe.requests.buddys.SetBuddyVariablesRequest;

/**
 * ...
 * @author RoYan
 */

class DataListManager implements IDataListManager{
	var libs:IntHash<Class<IBuilder<Dynamic>>>;
	static var _instance:DataListManager;
	static public function getInstance():DataListManager
	{
		if(_instance == null) _instance = new DataListManager();
		return _instance;
	}
	
	function new() {
		libs = new IntHash<Class<IBuilder<Dynamic>>>();
		registerBuilder( SerZone.CODE, ZoneBuilder );
		
		registerBuilder( LoginRequest.CODE, 		LoginRequest );
		registerBuilder( LogoutRequest.CODE, 		LogoutRequest );
		registerBuilder( PageRequest.CODE, 		PageRequest );
		registerBuilder( WordRequest.CODE, 		WordRequest );
		registerBuilder( OrderRequest.CODE, 		OrderRequest );
		registerBuilder( ExtensionRequest.CODE, 	ExtensionRequest );
		//users
		//registerBuilder( FindUsersRequest.CODE, 	FindUsersRequest );
		registerBuilder( InvitationReplyRequest.CODE, 	InvitationReplyRequest );
		registerBuilder( InviteUsersRequest.CODE, 	InviteUsersRequest );
		registerBuilder( JoinRoomRequest.CODE, 		JoinRoomRequest );
		registerBuilder( LeaveRoomRequest.CODE, 	LeaveRoomRequest );
		registerBuilder( PlayerToSpectatorRequest.CODE, 	PlayerToSpectatorRequest );
		registerBuilder( SpectatorToPlayerRequest.CODE, 	SpectatorToPlayerRequest );
		registerBuilder( SetUserVariablesRequest.CODE, 		SetUserVariablesRequest );
		//rooms
		registerBuilder( ChangeRoomCapacityRequest.CODE, 	ChangeRoomCapacityRequest );
		registerBuilder( ChangeRoomNameRequest.CODE, 	ChangeRoomNameRequest );
		registerBuilder( ChangeRoomPasswordStateRequest.CODE, 	ChangeRoomPasswordStateRequest );
		registerBuilder( CreateRoomRequest.CODE, 	CreateRoomRequest );
		//registerBuilder( FindRoomsRequest.CODE, 	FindRoomsRequest );
		registerBuilder( SetRoomVariablesRequest.CODE, 	SetRoomVariablesRequest );
		//games
		registerBuilder( CreateGameRequest.CODE, 	CreateGameRequest );
		registerBuilder( QuickJoinGameRequest.CODE, 	QuickJoinGameRequest );
		//buddys
		registerBuilder( AddBuddyRequest.CODE, 		AddBuddyRequest );
		registerBuilder( BlockBuddyRequest.CODE, 	BlockBuddyRequest );
		registerBuilder( RemoveBuddyRequest.CODE, 	RemoveBuddyRequest );
		registerBuilder( SetBuddyVariablesRequest.CODE, 	SetBuddyVariablesRequest );
	}
	
	public function registerBuilder(code:Int, builder:Class<IBuilder<Dynamic>>):Void
	{
		libs.set(code,builder);
	}
	
	public function retrieveBuilder(code:Int):Class<IBuilder<Dynamic>>
	{
		return libs.get(code);
	}
}