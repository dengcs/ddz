package game.script {
	import laya.components.Script;
	import game.proto.room_create;
	import game.net.NetClient;
	import common.GameGlobal;
	
	public class GameScript extends Script {
		override public function onStart():void
		{
			var roomMsg:room_create = new room_create();
			roomMsg.channel = GameGlobal.roomType;
			NetClient.send("room_create", roomMsg);
		}
	}
}