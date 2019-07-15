package common {
	import game.proto.game_update;
	import game.net.NetClient;

	public class GameUtils{
		public static function notify_game_update(data:Object):void
		{
			var sendMsg:game_update = new game_update();
			sendMsg.data = JSON.stringify(data);
			NetClient.send("game_update", sendMsg);
		}
	}
}