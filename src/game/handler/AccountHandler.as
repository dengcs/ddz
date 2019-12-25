package game.handler
{
	import com.google.protobuf.CodedInputStream;
	import game.manager.MessageManager;
	import game.base.HandlerBase;
	import laya.utils.Handler;
	import game.net.NetClient;
	import game.proto.*;
	import common.GameFunctions;

	/**
	 * ...
	 * @dengcs
	 */
	public final class AccountHandler extends HandlerBase{
		private static  var _instance:AccountHandler = new AccountHandler();

		public function AccountHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerMessage();
			 }
		}

		public static function getInstance():AccountHandler
		{
            return _instance;
		}

		private function registerMessage():void
		{
			var msgManager:MessageManager = MessageManager.getInstance();
			msgManager.registerMessage("register_resp", new Handler(this, handler_register));
			msgManager.registerMessage("verify_resp", new Handler(this, handler_verify));
			msgManager.registerMessage("kick_notify", new Handler(this, handler_kick));
		}

		private function handler_register(ntMessage:NetMessage):void
		{
			var resp_data:register_resp = new register_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)

			if(resp_data.token > 0)
			{
				var vf_msg:verify = new verify();
				
				vf_msg.token = resp_data.token;
				
				NetClient.send("verify", vf_msg);
			}
		}

		private function handler_verify(ntMessage:NetMessage):void
		{
			var resp_data:verify_resp = new verify_resp();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)

			if(resp_data.ret == 0)
			{
				var qp_msg:query_players = new query_players();
				
				qp_msg.account = GameFunctions.getAccount();
				
				NetClient.send("query_players", qp_msg);
			}
		}		

		private function handler_kick(ntMessage:NetMessage):void
		{
			var resp_data:kick_notify = new kick_notify();
			resp_data.readFrom(new CodedInputStream(ntMessage.payload));
			trace(resp_data)
		}
	}

}