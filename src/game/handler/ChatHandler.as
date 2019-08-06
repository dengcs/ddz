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
	public final class ChatHandler extends HandlerBase{
		private static  var _instance:ChatHandler = new ChatHandler();

		public function ChatHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():ChatHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("chat_msg_notice", new Handler(this, notify_chat_msg));
			msgManager.registerMessage("chat_msg_resp", new Handler(this, handler_chat_msg));
		}

		private function notify_chat_msg(ntMessage:NetMessage):void
		{
			var resp_data:chat_msg_notice = new chat_msg_notice();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_chat_msg(ntMessage:NetMessage):void
		{
			var resp_data:chat_msg_resp = new chat_msg_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
	}

}