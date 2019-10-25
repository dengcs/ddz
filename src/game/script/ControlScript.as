package game.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import common.GameConstants;
	import common.GameUtils;
	import laya.display.Sprite;
	import common.GameEvent;
	
	public class ControlScript extends Script {
		private var snatchSp:Sprite = null;
		private var doubleSp:Sprite = null;
		private var playSp:Sprite = null;

		private var snatchYesBtn:Button = null;
		private var snatchNoBtn:Button = null;

		private var doubleYesBtn:Button = null;
		private var doubleNoBtn:Button = null;

		private var playBtn:Button = null;
		private var promptBtn:Button = null;
		private var cancelBtn:Button = null;

		override public function onAwake():void
		{
			snatchSp	= this.owner.getChildByName("snatch") as Sprite;
			doubleSp	= this.owner.getChildByName("double") as Sprite;
			playSp		= this.owner.getChildByName("play") as Sprite;

			snatchYesBtn	= snatchSp.getChildAt(0) as Button;
			snatchNoBtn		= snatchSp.getChildAt(1) as Button;
			doubleYesBtn	= doubleSp.getChildAt(0) as Button;
			doubleNoBtn		= doubleSp.getChildAt(1) as Button;
			playBtn 	= playSp.getChildAt(0) as Button;
			promptBtn 	= playSp.getChildAt(1) as Button;
			cancelBtn 	= playSp.getChildAt(2) as Button;

			snatchYesBtn.on(Event.CLICK, this, onClickSnatchYes);
			snatchNoBtn.on(Event.CLICK, this, onClickSnatchNo);
			doubleYesBtn.on(Event.CLICK, this, onClickDoubleYes);
			doubleNoBtn.on(Event.CLICK, this, onClickDoubleNo);
			playBtn.on(Event.CLICK, this, onClickPlay);
			promptBtn.on(Event.CLICK, this, onClickPrompt);
			cancelBtn.on(Event.CLICK, this, onClickCancel);
		}

		override public function onStart():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_GAME_DOUBLE, this, onDouble);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			snatchSp.visible = false;
			doubleSp.visible = false;
			playSp.visible = false;
		}

		private function onSnatch():void
		{
			snatchSp.visible = true;
			doubleSp.visible = false;
			playSp.visible = false;
		}

		private function onDouble():void
		{
			snatchSp.visible = false;
			doubleSp.visible = true;
			playSp.visible = false;
		}

		private function onPlay():void
		{
			snatchSp.visible = false;
			doubleSp.visible = false;
			playSp.visible = true;
		}

		private function onClickSnatchYes():void
		{

		}

		private function onClickSnatchNo():void
		{

		}

		private function onClickDoubleYes():void
		{

		}

		private function onClickDoubleNo():void
		{

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