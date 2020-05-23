package game.handler
{
	import com.google.protobuf.CodedInputStream;
	import game.manager.MessageManager;
	import laya.utils.Handler;
	import game.net.NetClient;
	import game.proto.*;
	import game.base.HandlerBase;
	import common.GameStatic;

	/**
	 * ...
	 * @dengcs
	 */
	public final class PlayerHandler extends HandlerBase{
		private static  var _instance:PlayerHandler = new PlayerHandler();

		public function PlayerHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():PlayerHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("query_players_resp", new Handler(this, handler_query_players));
			msgManager.registerMessage("create_player_resp", new Handler(this, handler_create_player));
			msgManager.registerMessage("player_login_resp", new Handler(this, handler_player_login));
			msgManager.registerMessage("game_login_resp", new Handler(this, handler_game_login));
			msgManager.registerMessage("room_login_resp", new Handler(this, handler_room_login));			
		}

		private function handler_query_players(ntMessage:NetMessage):void
		{
			var resp_data:query_players_resp = new query_players_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)

			// 没有就创建角色
			if(resp_data.ret != 0)
			{
				var createMsg:create_player = new create_player();
				createMsg.nickname = "邓1";
				createMsg.portrait = "portrait";
				createMsg.sex = 1;

				NetClient.send("create_player", createMsg);
			}else{
				var loginMsg:player_login = new player_login();
				NetClient.send("player_login", loginMsg);
			}
		}

		private function handler_create_player(ntMessage:NetMessage):void
		{
			var resp_data:create_player_resp = new create_player_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)

			// 创建成功则登录
			if(resp_data.ret == 0)
			{
				var loginMsg:player_login = new player_login();
				NetClient.send("player_login", loginMsg);
			}
		}

		private function handler_player_login(ntMessage:NetMessage):void
		{
			var resp_data:player_login_resp = new player_login_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)

			if(resp_data.ret == 0)
			{
				GameStatic.pid = resp_data.pid;
				var loginMsg1:room_login = new room_login();
				loginMsg1.pid = resp_data.pid;
				NetClient.send("room_login", loginMsg1);
				var loginMsg2:game_login = new game_login();
				loginMsg2.pid = resp_data.pid;
				NetClient.send("game_login", loginMsg2);
			}
		}

		private function handler_room_login(ntMessage:NetMessage):void
		{
			var resp_data:room_login_resp = new room_login_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_game_login(ntMessage:NetMessage):void
		{
			var resp_data:game_login_resp = new game_login_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
	}

}