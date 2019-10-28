package game.handler
{
	import game.manager.MessageManager;
	import laya.utils.Handler;
	import com.google.protobuf.CodedInputStream;
	import game.proto.*;
	import game.net.NetClient;
	import game.base.HandlerBase;
	import game.control.NetAction;

	/**
	 * ...
	 * @dengcs
	 */
	public final class GameHandler extends HandlerBase{
		private static  var _instance:GameHandler = new GameHandler();

		public function GameHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():GameHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("game_leave_resp", new Handler(this, handler_game_leave));
			msgManager.registerMessage("game_start_notify", new Handler(this, notify_game_start));
			msgManager.registerMessage("game_update_notify", new Handler(this, notify_game_update));
		}

		private function handler_game_leave(ntMessage:NetMessage):void
		{
			var resp_data:game_leave_resp = new game_leave_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function notify_game_start(ntMessage:NetMessage):void
		{
			var resp_data:game_start_notify = new game_start_notify();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function notify_game_update(ntMessage:NetMessage):void
		{
			var resp_data:game_update_notify = new game_update_notify();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));

			NetAction.update(resp_data.data);
		}
	}

}