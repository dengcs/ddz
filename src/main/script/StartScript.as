package main.script {
	import laya.components.Script;
	import laya.events.Event;
	import game.proto.room_create;
	import game.net.NetClient;
	import game.manager.AudioManager;
	import common.GameConstants;
	
	public class StartScript extends Script {
		/** @prop {name:btnType, tips:"比赛类型", type:Int, default:0}*/
		public var btnType: int = 0;

		override public function onClick(e:Event):void
		{
			switch(btnType)
			{
				case 1:
				case 2:
				case 3:
				case 4:
					this.on_open_game();
					break;
				default:
					break;
			}
		}

		private function on_open_game():void
		{
			var roomMsg:room_create = new room_create();
			roomMsg.channel = 1;
			NetClient.send("room_create", roomMsg);
			AudioManager.getInstance().playOther(GameConstants.SOUND_BUTTON_DOWN);
		}
	}
}