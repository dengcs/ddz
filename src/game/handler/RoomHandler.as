package game.handler
{
	import game.manager.MessageManager;
	import laya.utils.Handler;
	import com.google.protobuf.CodedInputStream;
	import game.proto.*;
	import game.base.HandlerBase;
	import laya.display.Scene;
	import common.GameConstants;

	/**
	 * ...
	 * @dengcs
	 */
	public final class RoomHandler extends HandlerBase{
		private static  var _instance:RoomHandler = new RoomHandler();

		public function RoomHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():RoomHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("room_create_resp", new Handler(this, handler_room_create));
			msgManager.registerMessage("room_quit_resp", new Handler(this, handler_room_quit));
			msgManager.registerMessage("room_invite_resp", new Handler(this, handler_room_invite));
		}

		private function handler_room_create(ntMessage:NetMessage):void
		{
			var resp_data:room_create_resp = new room_create_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
			if(resp_data.ret == 0)
			{
				Scene.open(GameConstants.gameScene);
			}
		}

		private function handler_room_quit(ntMessage:NetMessage):void
		{
			var resp_data:room_quit_resp = new room_quit_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_room_invite(ntMessage:NetMessage):void
		{
			var resp_data:room_invite_resp = new room_invite_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
	}

}