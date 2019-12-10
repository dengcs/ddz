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
	import laya.utils.Utils;
	import game.control.NetAction;
	import laya.ui.Image;
	
	public class ControlScript extends Script {
		private var snatchSp:Sprite = null;
		private var playSp1:Sprite = null;
		private var playSp2:Sprite = null;
		private var playSp3:Sprite = null;

		private var snatchYesBtn:Button = null;
		private var snatchNoBtn:Button = null;
		private var snatchYesImg:Image = null;
		private var snatchNoImg:Image = null;

		private var playBtn2:Button = null;
		private var playBtn3:Button = null;

		override public function onAwake():void
		{
			snatchSp	= this.owner.getChildByName("snatch") as Sprite;
			playSp1		= this.owner.getChildByName("play1") as Sprite;
			playSp2		= this.owner.getChildByName("play2") as Sprite;
			playSp3		= this.owner.getChildByName("play3") as Sprite;

			snatchNoBtn		= snatchSp.getChildAt(0) as Button;
			snatchNoImg		= snatchNoBtn.getChildAt(0) as Image;
			snatchYesBtn	= snatchSp.getChildAt(1) as Button;
			snatchYesImg	= snatchSp.getChildAt(2) as Image;

			var cancelBtn1:Button 	= playSp1.getChildAt(0) as Button;
			var promptBtn2:Button 	= playSp2.getChildAt(0) as Button;
			playBtn2 				= playSp2.getChildAt(1) as Button;
			var cancelBtn3:Button 	= playSp3.getChildAt(0) as Button;
			var promptBtn3:Button 	= playSp3.getChildAt(1) as Button;
			playBtn3 				= playSp3.getChildAt(2) as Button;

			snatchYesBtn.on(Event.CLICK, this, onClickSnatchYes);
			snatchNoBtn.on(Event.CLICK, this, onClickSnatchNo);

			cancelBtn1.on(Event.CLICK, this, onClickCancel);
			playBtn2.on(Event.CLICK, this, onClickPlay);
			promptBtn2.on(Event.CLICK, this, onClickPrompt);
			playBtn3.on(Event.CLICK, this, onClickPlay);
			promptBtn3.on(Event.CLICK, this, onClickPrompt);
			cancelBtn3.on(Event.CLICK, this, onClickCancel);
		}

		override public function onStart():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);

			GameFunctions.control_start = Utils.bind(gameStart, this);
			GameFunctions.control_forcePlay = Utils.bind(forcePlay, this);
			GameFunctions.control_markPlay = Utils.bind(markPlay, this);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			snatchSp.visible = false;
			playSp1.visible = false;
			playSp2.visible = false;
			playSp3.visible = false;
		}

		private function gameStart():void
		{
			if(NetAction.idxIsMine(1))
			{
				snatchYesImg.skin = "button/textCallLord.png";
				snatchNoImg.skin = "button/textCallNo.png";
				snatchSp.visible = true;
			}
		}

		private function onSnatch():void
		{
			if(GameAction.isFirstSnatch())
			{
				if(NetAction.idxIsMine(1) == false)
				{
					snatchYesImg.skin = "button/textCallLord.png";
					snatchNoImg.skin = "button/textCallNo.png";
					snatchSp.visible = true;
				}
			}else
			{
				snatchYesImg.skin = "button/textGrabLord.png";
				snatchNoImg.skin = "button/textGrabNo.png";
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
					playSp1.visible = true;
					playSp2.visible = false;
					playSp3.visible = false;					
				}else if(type == 2)
				{
					playSp1.visible = false;
					playSp2.visible = true;
					playSp3.visible = false;
				}else
				{					
					playSp1.visible = false;
					playSp2.visible = false;
					playSp3.visible = true;
				}
			}else
			{
				playSp1.visible = false;
				playSp2.visible = false;
				playSp3.visible = false;
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

		// 强制操作（出牌或叫地主）
		private function forcePlay():void
		{
			if(snatchSp.visible)
			{
				this.onClickSnatchNo();
			}else if(playSp1.visible)
			{
				this.onClickCancel();
			}else
			{
				this.onClickPrompt();
				this.onClickPlay();
			}
		}

		private function markPlay(disable:Boolean):void
		{
			this.playBtn2.disabled	= disable;
			this.playBtn3.disabled 	= disable;
		}
	}
}