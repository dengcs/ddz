package game.net
{
	import com.google.protobuf.ByteArray;
	import com.google.protobuf.CodedInputStream;
	import game.manager.DispatchManager;
	import game.proto.NetMessage;
	import game.proto.register;
	import common.GameStatic;

	/**
	 * ...
	 * @author
	 */
	public final class NetHandler{
		private static  var _instance:NetHandler = new NetHandler();

		public function NetHandler(){
			if (_instance != null) {
                 throw new Error("只能用getInstance()来获取实例!");
             }
		}

		public static function getInstance():NetHandler {
            return _instance;
        }

		public function handlerOpen():void
		{
			var reg:register = new register();
				
			reg.account 	= GameStatic.gameAccount;
			reg.passwd 	= "12345678";
			
			NetClient.send("register", reg);
		}

		public function handlerClose():void
		{
			trace("closed");
		}

		public function handlerMsg(message:*=null):void
		{
			if(message != null)
			{
				var bytes:ByteArray = new ByteArray(message);
				var ntMessage:NetMessage = new NetMessage();
				ntMessage.readFrom(new CodedInputStream(bytes));

				DispatchManager.getInstance().messageDispatcher(ntMessage);
			}
		}

		public function handlerError(e:*=null):void
		{
			trace("error");
		}
	}

}