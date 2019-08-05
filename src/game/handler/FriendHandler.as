package game.handler
{
	import game.manager.MessageManager;
	import laya.utils.Handler;
	import com.google.protobuf.CodedInputStream;
	import game.proto.*;
	import game.net.NetClient;
	import game.base.HandlerBase;

	/**
	 * ...
	 * @dengcs
	 */
	public final class FriendHandler extends HandlerBase{
		private static  var _instance:FriendHandler = new FriendHandler();

		public function FriendHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():FriendHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("center_friend_access_resp", new Handler(this, handler_friend_access_resp));
			msgManager.registerMessage("center_friend_search_resp", new Handler(this, handler_friend_search_resp));
			msgManager.registerMessage("center_friend_submit_application_resp", new Handler(this, handler_friend_submit_application));
			msgManager.registerMessage("center_friend_agree_application_resp", new Handler(this, handler_friend_agree_application));
			msgManager.registerMessage("center_friend_reject_application_resp", new Handler(this, handler_friend_reject_application));
			msgManager.registerMessage("center_friend_delete_resp", new Handler(this, handler_friend_delete));
			msgManager.registerMessage("center_friend_append_enemy_resp", new Handler(this, handler_friend_append_enemy));
			msgManager.registerMessage("center_friend_remove_enemy_resp", new Handler(this, handler_friend_remove_enemy));
			msgManager.registerMessage("friend_add_notice", new Handler(this, notify_friend_add));
			msgManager.registerMessage("friend_del_notice", new Handler(this, notify_friend_del));
			msgManager.registerMessage("friend_authorize_notice", new Handler(this, notify_friend_authorize));
		}

		private function handler_friend_access_resp(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_access_resp = new center_friend_access_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_search_resp(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_search_resp = new center_friend_search_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_submit_application(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_submit_application_resp = new center_friend_submit_application_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_agree_application(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_agree_application_resp = new center_friend_agree_application_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_reject_application(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_reject_application_resp = new center_friend_reject_application_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_delete(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_delete_resp = new center_friend_delete_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_append_enemy(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_append_enemy_resp = new center_friend_append_enemy_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_friend_remove_enemy(ntMessage:NetMessage):void
		{
			var resp_data:center_friend_remove_enemy_resp = new center_friend_remove_enemy_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
		
		private function notify_friend_add(ntMessage:NetMessage):void
		{
			var resp_data:friend_add_notice = new friend_add_notice();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function notify_friend_del(ntMessage:NetMessage):void
		{
			var resp_data:friend_del_notice = new friend_del_notice();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function notify_friend_authorize(ntMessage:NetMessage):void
		{
			var resp_data:friend_authorize_notice = new friend_authorize_notice();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
	}

}