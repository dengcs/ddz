package common {
	import game.proto.game_update;
	import game.net.NetClient;
	import laya.utils.Utils;

	public class GameFunctions{
		private static var gameAccount:String = null;
		public static var ownerList_play:Function = null;
		public static var ownerList_delCell:Function = null;
		public static var ownerList_prompt:Function = null;
		public static var ownerList_playPrompt:Function = null;
		public static var surface_updateCounter:Function = null;
		public static var control_callLord:Function = null;
		public static var control_markPlay:Function = null;
		public static var control_forcePlay:Function = null;
		public static var control_markStart:Function = null;
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

		public static function generateAccount():String
		{
			if(gameAccount == null)
			{
				var nameArray:Array = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
				var name:String = "";
				for(var i:int = 0; i < 6; i++)
				{
					var idx:int = Math.floor(Math.random() * 52) % 52;
					name += nameArray[idx];
				}
				var guid:Number = Utils.getGID();
				gameAccount = name + guid
			}
			return gameAccount;
		}
	}
}