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
	import laya.utils.Utils;
	import game.manager.AudioManager;
	import common.GameConstants;
	
	public class ClockScript extends Script {
		private var ownerSprite:Sprite = null;
		private var secondLabel:Label = null;

		private var leftPos:int 		= 1;
		private var rightPos:int		= 2;
		private var mineOnePos:int 		= 3;
		private var mineTwoPos:int 		= 4;
		private var mineThreePos:int 	= 5;

		private var currentPos:int 		= 1;

		private var posArray:Array = null;

		private var countdown:int = 0;
		private var shakeCount:int = 0;

		private var isGameOver:Boolean = false;
		override public function onAwake():void
		{
			this.ownerSprite = this.owner as Sprite;
			this.secondLabel = this.owner.getChildByName("second") as Label;
			this.posArray = [0,0];

			GameFunctions.clock_start = Utils.bind(gameStart, this);
		}

		override public function onEnable():void {
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_BOTTOM_NOTIFY, this, onBottom);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);
			this.owner.on(GameEvent.EVENT_GAME_OVER, this, onOver);
		}
		
		override public function onDisable():void {
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			this.countdown = 20;
			this.isGameOver = false;
			this.ownerSprite.visible = false;
		}

		private function gameStart():void
		{
			var toward:int = 0;			
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

			var position:Array = this.getPosition(toward);
			if(position != null)
			{
				this.ownerSprite.pos(position[0], position[1]);
				this.startTick();
			}
		}

		private function onSnatch(data:Object):void
		{
			var toward:int = 0;
			var idx:int = data.idx;
			if(NetAction.idxIsMine(idx))
			{
				if(GameAction.nextCanSnatch(idx))
				{
					toward = this.rightPos;
				}else
				{
					toward = this.leftPos;
				}
			}else if(NetAction.idxIsRight(idx))
			{
				if(GameAction.nextCanSnatch(idx))
				{
					toward = this.leftPos;
				}else
				{
					toward = this.mineTwoPos;
				}
			}else
			{
				if(GameAction.nextCanSnatch(idx))
				{
					toward = this.mineTwoPos;
				}else
				{
					toward = this.rightPos;
				}
			}

			this.toPosition(toward);
		}

		private function onBottom(idx:int):void
		{
			var toward:int = 0;
			if(NetAction.lordIsMine())
			{
				toward = this.mineTwoPos;
			}else if(NetAction.lordIsRight())
			{
				toward = this.rightPos;
			}else
			{
				toward = this.leftPos;
			}

			this.toPosition(toward);
		}

		private function onPlay(data:Object = null):void
		{
			var toward:int = 0;			
			if(data != null)
			{
				var idx:int = data.idx;
				if(NetAction.idxIsMine(idx))
				{					
					toward = this.rightPos;
				}else if(NetAction.idxIsRight(idx))
				{
					toward = this.leftPos;
				}
			}else
			{
				var type:int = GameFunctions.ownerList_playPrompt.call();
				if(type == 1)
				{
					toward = this.mineOnePos;
				}else if(type == 2)
				{
					toward = this.mineTwoPos;
				}else
				{
					toward = this.mineThreePos;
				}
			}
			this.toPosition(toward);
		}

		private function onOver():void
		{
			this.isGameOver = true;
			this.ownerSprite.visible = false;
			this.owner.clearTimer(this, secondTick);
			this.owner.clearTimer(this, shakeTick);
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
				this.posArray[0] = -130;
				this.posArray[1] = 110;
			}else if(toward == this.mineTwoPos)
			{
				this.posArray[0] = 0;
				this.posArray[1] = 110;
			}else if(toward == this.mineThreePos)
			{
				this.posArray[0] = -70;
				this.posArray[1] = 110;
			}else
			{
				return null;
			}
			this.currentPos = toward;
			return this.posArray;
		}

		private function startTick():void
		{
			if(this.isGameOver) return;
			this.ownerSprite.visible = true;
			this.secondLabel.text = this.countdown.toString();
			this.owner.timerLoop(1000, this, secondTick);
		}

		private function startShake():void
		{
			if(this.isGameOver) return;
			this.shakeCount = 0;
			this.owner.clearTimer(this, shakeTick);
			this.owner.timerLoop(125, this, shakeTick, null, false);
			AudioManager.getInstance().playOther(GameConstants.SOUND_BE_FAST);
		}

		private function toPosition(toward:int):void
		{
			var position:Array = this.getPosition(toward);
			if(position != null)
			{
				if(this.currentPos == this.mineOnePos)
				{
					this.countdown = 5;
				}else
				{
					this.countdown = 20;
				}
				this.owner.clearTimer(this, secondTick);
				this.owner.clearTimer(this, shakeTick);
				Tween.to(this.ownerSprite,{x:position[0], y:position[1]}, 300, Ease.expoIn, new Handler(this, moveComplate));
				AudioManager.getInstance().stopOther(GameConstants.SOUND_BE_FAST);
			}
		}

		private function secondTick():void
		{
			this.countdown--;
			if(this.countdown <= 0)
			{
				this.tickComplate();
			}else if(this.countdown <= 3)
			{
				this.startShake();
			}
			
			this.secondLabel.text = this.countdown.toString();
		}

		private function shakeTick():void
		{
			var position:Array = this.getPosition(this.currentPos);
			if(position != null)
			{
				var range:int = 20;
				var x:Number = position[0];
				if(this.shakeCount == 0)
				{
					x += range;
				}else if(this.shakeCount < 4)
				{
					if(this.ownerSprite.x > x)
					{
						x -= range;
					}else
					{
						x += range;
					}
				}else if(this.shakeCount > 4)
				{
					return;
				}

				this.shakeCount++;
				
				Tween.to(this.ownerSprite, {x:x}, 120, Ease.bounceIn, null, null, false);
			}
		}

		private function moveComplate():void
		{			
			this.startTick();
		}

		private function tickComplate():void
		{			
			this.owner.clearTimer(this, secondTick);
			this.owner.clearTimer(this, shakeTick);
			GameFunctions.control_forcePlay.call();
		}
	}
}