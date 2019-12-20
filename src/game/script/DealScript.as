package game.script {
	import laya.components.Script;
	import common.GameEvent;
	import laya.ui.Image;
	import laya.display.Sprite;
	import common.GameConstants;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import laya.utils.Handler;
	import common.GameFunctions;
	import common.EffectManager;
	
	public class DealScript extends Script {

		private var ownerSprite:Sprite = null;

		private var dealCard:Image = null;
		private var btmCard1:Image = null;
		private var btmCard2:Image = null;
		private var btmCard3:Image = null;

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as Sprite;

			dealCard = this.owner.getChildAt(0) as Image;
			btmCard1 = this.owner.getChildAt(1) as Image;
			btmCard2 = this.owner.getChildAt(2) as Image;
			btmCard3 = this.owner.getChildAt(3) as Image;
		}		

		override public function onStart():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_DEAL, this, onDeal);
			this.owner.on(GameEvent.EVENT_GAME_BOTTOM, this, onBottom);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			this.dealCard.visible = true;
		}

		private function onDeal():void
		{
			this.dealPoker(1);
		}

		private function onBottom():void
		{
			btmCard1.visible = false;
			btmCard2.visible = false;
			btmCard3.visible = false;
		}

		private function showBottom():void
		{
			btmCard1.visible = true;
			btmCard2.visible = true;
			btmCard3.visible = true;
		}

		// 发牌到玩家
		public function dealPoker(index:int):void
		{
			var maxIndex:int = 10;
			var delay:int = 600;
			var type:int = 0;

			if(index == maxIndex)
			{
				this.dealCard.visible = false;
				type = GameConstants.POKER_TYPE_DEAL6;
				this.owner.timerOnce(2*delay, this, showBottom, null, false);
			}else
			{
				var place:int = 0;
				var toward:int = index % 3
				var divVal:int = Math.floor(index / 3);
				var cardNum:int = 0;
				
				if(toward == 0)
				{
					place = 1;
					cardNum = divVal == 3 ? 5 : 6;
					type = GameConstants.POKER_TYPE_DEAL2;
				}else if(toward == 1)
				{
					place = 2;
					cardNum = divVal == 2 ? 5 : 6;
					type = GameConstants.POKER_TYPE_DEAL1;
				}else
				{					
					type = GameConstants.POKER_TYPE_DEAL3 + divVal;
				}

				this.owner.timerOnce(delay, this, dealComplete, [place, cardNum], false);
			}

			EffectManager.playDeal(type);
			if(index < maxIndex)
			{
				this.owner.timerOnce(delay, this, dealPoker, [index + 1], false);
			}
		}

		private function dealComplete(place:int, count:int):void
		{
			if(place > 0)
			{
				for(var i:int = 0; i < count; i++)
				{
					this.owner.timerOnce(i * 30, this, updateCounter, [place], false);
				}
			}
		}

		private function updateCounter(place:int):void
		{
			GameFunctions.surface_updateCounter.call(null, place, 1);
		}
	}
}