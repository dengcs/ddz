package game.net
{
	import laya.net.Socket;
	import com.google.protobuf.Message;
	import com.google.protobuf.ByteArray;
	import game.net.NetSocket;
	import game.net.NetClient;
	import game.proto.*;
	import common.GameStatic;
	/**
	 * ...
	 * @dengcs
	 */
	public final class NetClient{
		
		public static function send(protoName:String, msg:Message):void
		{
			if(NetSocket.getInstance().isConnected())
			{
				var ntHeader:NetHeader = new NetHeader();
				var ntMessage:NetMessage = new NetMessage();

				ntHeader.proto = protoName;
				ntMessage.header = ntHeader;
				
				var payload:ByteArray = Message.toByteArray(msg);
				ntMessage.payload = payload;

				var sendMsg:ByteArray = Message.toByteArray(ntMessage);			

				NetSocket.getInstance().sendAndFlush(sendMsg.buffer);
			}
		}

		public static function connect(url:String):void
		{
			NetSocket.getInstance().connectToServer(url);
		}

		public static function handshake():void
		{			
			if(NetSocket.getInstance().isConnected() == false)
			{
				// 提示重新连接窗口
				Laya.timer.once(100, null, handshake);
			}
		}
	}

}