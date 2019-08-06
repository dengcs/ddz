package game.manager
{
	import game.manager.MessageManager;
	import game.proto.NetMessage;
	import game.handler.*;
	import game.handler.MailHandler;
	import game.handler.FriendHandler;
	import game.handler.ChatHandler;

	/**
	 * ...
	 * @dengcs
	 */
	public final class DispatchManager{
		private static  var _instance:DispatchManager = new DispatchManager();

		public function DispatchManager(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }else{
				 registerHandler();
			 }
		}

		public static function getInstance():DispatchManager
		{
            return _instance;
		}

		private function registerHandler():void
		{
			AccountHandler.getInstance();
			PlayerHandler.getInstance();
			RoomHandler.getInstance();
			GameHandler.getInstance();
			MailHandler.getInstance();
			FriendHandler.getInstance();
			ChatHandler.getInstance();
		}

		public function messageDispatcher(ntMessage:NetMessage):void
		{
			MessageManager.getInstance().processMessage(ntMessage);				
		}

	}

}