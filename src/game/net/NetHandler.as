package game.net
{
	import com.google.protobuf.ByteArray;
	import com.google.protobuf.CodedInputStream;
	import game.manager.DispatchManager;
	import game.proto.NetMessage;

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
	}

}