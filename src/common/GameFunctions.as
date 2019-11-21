package common {
	import game.proto.game_update;
	import game.net.NetClient;

	public class GameFunctions{
		public static var ownerList_play:Function = null;
		public static var ownerList_delCell:Function = null;
		public static var ownerList_prompt:Function = null;
		public static var ownerList_playPrompt:Function = null;
		public static var surface_updateCounter:Function = null;
		public static var control_start:Function = null;
		public static var control_forcePlay:Function = null;
		public static var clock_start:Function = null;

		public static function send_game_update(cmd:int, msg:*=null):void
		{
			var data:Object = new Object();
			data.cmd = cmd;
			data.msg = msg;
			var sendMsg:game_update = new game_update();
			sendMsg.data = JSON.stringify(data);
			NetClient.send("game_update", sendMsg);
		}
	}
}