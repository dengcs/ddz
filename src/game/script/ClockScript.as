package game.script {
	import laya.components.Script;
	import laya.display.Sprite;
	import common.GameEvent;
	import laya.ui.Label;
	import common.GameFunctions;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import game.control.NetAction;
	import game.control.GameAction;
	
	public class ClockScript extends Script {
		private var ownerSprite:Sprite = null;
		private var secondLabel:Label = null;

		private var leftPos:int 		= 1;
		private var rightPos:int		= 2;
		private var mineOnePos:int 		= 3;
		private var mineTwoPos:int 		= 4;
		private var mineThreePos:int 	= 5;

		private var posArray:Array = null;

		private var countdown:int = 0;
		private var snatchCount:int = 0;
		private var playCount:int = 0;
		override public function onAwake():void
		{
			this.ownerSprite = this.owner as Sprite;
			this.secondLabel = this.owner.getChildByName("second") as Label;
			this.posArray = [0,0];
		}

		override public function onEnable():void {
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);
		}
		
		override public function onDisable():void {
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			this.ownerSprite.visible = false;
			this.countdown = 20;
			this.snatchCount = 0;
			this.playCount = 0;
		}

		private function onSnatch(data:Object):void
		{			
			var toward:int = 0;

			if(this.snatchCount > 0)
			{
				if(this.snatchCount == 1)
				{
					if(NetAction.idxIsMine(1))
					{					
						toward = this.mineTwoPos;
					}else if(NetAction.idxIsRight(1))
					{
						toward = this.rightPos;
					}else
					{
						toward = this.leftPos;
					}

					this.startTick();
					var position:Array = this.getPosition(toward);
					if(position != null)
					{
						this.ownerSprite.pos(position[0], position[1]);
					}
				}else
				{
					var idx:int = data.idx;
					if(NetAction.idxIsMine(idx))
					{					
						toward = this.rightPos;
					}else if(NetAction.idxIsRight(idx))
					{
						toward = this.leftPos;
					}else
					{
						toward = this.mineTwoPos;
					}

					this.toPosition(toward);
				}
			}
			this.snatchCount++;
		}

		private function onPlay(data:Object = null):void
		{
			var toward:int = 0;
			if(this.playCount == 0)
			{
				if(GameAction.ownerIsMine())
				{
					toward = this.mineTwoPos;
				}else if(GameAction.ownerIsRight())
				{
					toward = this.rightPos;
				}else
				{
					toward = this.leftPos;
				}
			}else
			{
				if(data != null)
				{
					var idx:int = data.idx;
					if(NetAction.idxIsMine(idx))
					{					
						toward = this.rightPos;
					}else if(NetAction.idxIsRight(idx))
					{
						toward = this.leftPos;
					}else
					{
						toward = this.mineTwoPos;
					}
				}
			}
			this.toPosition(toward);
			this.playCount++;
		}

		private function getPosition(toward:int):Array
		{
			if(toward == this.leftPos)
			{
				this.posArray[0] = -240;
				this.posArray[1] = -120;
			}else if(toward == this.rightPos)
			{
				this.posArray[0] = 240;
				this.posArray[1] = -120;
			}else if(toward == this.mineOnePos)
			{
				this.posArray[0] = 0;
				this.posArray[1] = 40;
			}else if(toward == this.mineTwoPos)
			{
				this.posArray[0] = 0;
				this.posArray[1] = 40;
			}else if(toward == this.mineThreePos)
			{
				this.posArray[0] = 0;
				this.posArray[1] = 40;
			}else
			{
				return null;
			}
			return this.posArray;
		}

		private function startTick():void
		{
			this.ownerSprite.visible = true;
			this.secondLabel.text = this.countdown.toString();
			this.owner.timerLoop(1000, this, secondTick);
		}

		private function toPosition(toward:int):void
		{
			var position:Array = this.getPosition(toward);
			if(position != null)
			{
				this.countdown = 20;
				this.owner.clearTimer(this, secondTick);				
				Tween.to(this.ownerSprite,{x:position[0], y:position[1]}, 300, Ease.expoIn, new Handler(this, complatePosition));
			}
		}

		private function secondTick():void
		{
			this.countdown--;
			if(this.countdown <= 0)
			{
				this.complateTick();
			}
			
			this.secondLabel.text = this.countdown.toString();
		}

		private function complatePosition():void
		{			
			this.startTick();
		}

		private function complateTick():void
		{			
			this.owner.clearTimer(this, secondTick);
			GameFunctions.control_forcePlay.call();
		}
	}
}