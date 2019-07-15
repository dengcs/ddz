package game.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import common.GameConstants;
	import common.GameUtils;
	
	public class CmdScript extends Script {
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

			GameUtils.notify_game_update(msgData);
		}
	}
}