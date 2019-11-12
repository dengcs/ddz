package game.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import common.GameConstants;
	import laya.display.Sprite;
	import common.GameEvent;
	import game.proto.game_update;
	import game.net.NetClient;
	import common.GameFunctions;
	import game.control.GameAction;
	
	public class ControlScript extends Script {
		private var snatchSp:Sprite = null;
		private var playSp:Sprite = null;

		private var snatchYesBtn:Button = null;
		private var snatchNoBtn:Button = null;

		private var playBtn:Button = null;
		private var promptBtn:Button = null;
		private var cancelBtn:Button = null;

		private var snatchCount:int	= 0;

		override public function onAwake():void
		{
			snatchSp	= this.owner.getChildByName("snatch") as Sprite;
			playSp		= this.owner.getChildByName("play") as Sprite;

			snatchYesBtn	= snatchSp.getChildAt(0) as Button;
			snatchNoBtn		= snatchSp.getChildAt(1) as Button;
			playBtn 	= playSp.getChildAt(0) as Button;
			promptBtn 	= playSp.getChildAt(1) as Button;
			cancelBtn 	= playSp.getChildAt(2) as Button;

			snatchYesBtn.on(Event.CLICK, this, onClickSnatchYes);
			snatchNoBtn.on(Event.CLICK, this, onClickSnatchNo);
			playBtn.on(Event.CLICK, this, onClickPlay);
			promptBtn.on(Event.CLICK, this, onClickPrompt);
			cancelBtn.on(Event.CLICK, this, onClickCancel);
		}

		override public function onStart():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			snatchSp.visible = false;
			playSp.visible = false;
			this.snatchCount = 0;
		}

		private function onSnatch():void
		{
			this.snatchCount++;
			if(this.snatchCount > 1)
			{
				snatchSp.visible = true;
			}
		}

		private function onPlay(data:Object = null):void
		{
			if(data == null)
			{
				var type:int = GameFunctions.ownerList_playPrompt.call();
				if(type == 1)
				{
					playBtn.disabled = false;
					promptBtn.disabled = true;
					cancelBtn.disabled = true;
				}else if(type == 2)
				{
					playBtn.disabled = false;
					promptBtn.disabled = false;
					cancelBtn.disabled = false;
				}else
				{
					playBtn.disabled = true;
					promptBtn.disabled = true;
					cancelBtn.disabled = false;
				}
				playSp.visible = true;
			}else
			{
				playSp.visible = false;
				GameAction.onPlayData(data);
			}
		}

		private function onClickSnatchYes():void
		{
			snatchSp.visible = false;
			GameFunctions.send_game_update(GameConstants.PLAY_STATE_SNATCH, 1);
		}

		private function onClickSnatchNo():void
		{
			snatchSp.visible = false;
			GameFunctions.send_game_update(GameConstants.PLAY_STATE_SNATCH, 0);
		}

		private function onClickPlay():void
		{
			GameFunctions.ownerList_play.call();
		}

		private function onClickPrompt():void
		{
			GameFunctions.ownerList_prompt.call();
		}

		private function onClickCancel():void
		{
			GameFunctions.send_game_update(GameConstants.PLAY_STATE_PLAY, 0);
		}
	}
}