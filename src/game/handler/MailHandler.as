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
	public final class MailHandler extends HandlerBase{
		private static  var _instance:MailHandler = new MailHandler();

		public function MailHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():MailHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("mail_append_notice", new Handler(this, notify_mail_append));
			msgManager.registerMessage("mail_open_resp", new Handler(this, handler_mail_open));
			msgManager.registerMessage("mail_remove_resp", new Handler(this, handler_mail_remove));
			msgManager.registerMessage("mail_receive_resp", new Handler(this, handler_mail_receive));
		}

		private function notify_mail_append(ntMessage:NetMessage):void
		{
			var resp_data:mail_append_notice = new mail_append_notice();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_mail_open(ntMessage:NetMessage):void
		{
			var resp_data:mail_open_resp = new mail_open_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_mail_remove(ntMessage:NetMessage):void
		{
			var resp_data:mail_remove_resp = new mail_remove_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}

		private function handler_mail_receive(ntMessage:NetMessage):void
		{
			var resp_data:mail_receive_resp = new mail_receive_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
	}

}