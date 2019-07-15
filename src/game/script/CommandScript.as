package game.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import common.GameConstants;
	import game.proto.game_update;
	import game.net.NetClient;
	
	public class CommandScript extends Script {
		private var playBtn:Button = null;
		private var promptBtn:Button = null;
		private var cancelBtn:Button = null;

		override public function onAwake():void
		{
			playBtn 	= this.owner.getChildByName("playBtn") as Button;
			promptBtn 	= this.owner.getChildByName("promptBtn") as Button;
			cancelBtn 	= this.owner.getChildByName("cancelBtn") as Button;

			playBtn.on(Event.CLICK, this, onClickPlay);
			promptBtn.on(Event.CLICK, this, onClickPrompt);
			cancelBtn.on(Event.CLICK, this, onClickCancel);
		}

		private function notify_game_update(data:Object):void
		{
			var sendMsg:game_update = new game_update();
			sendMsg.data = JSON.stringify(data);
			NetClient.send("game_update", sendMsg);
		}

		private function onClickPlay():void
		{

		}

		private function onClickPrompt():void
		{

		}

		private function onClickCancel():void
		{
			var msgData:Object = new Object();
			msgData.cmd = GameConstants.PLAY_STATE_PLAY;
			msgData.msg = 0;

			this.notify_game_update(msgData);
		}
	}
}