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
	import game.manager.AnimationManager;
	import com.google.protobuf.CodedInputStream;
	
	public class DealScript extends Script {

		private var ownerSprite:Sprite = null;

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as Sprite;
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
		}

		private function onDeal():void
		{
			this.dealPoker(1);
		}

		private function onBottom():void
		{

		}

		// 发牌到玩家
		public function dealPoker(index:int):void
		{
			var maxIndex:int = 10;
			var delay:int = 500;
			var type:int = 0;

			if(index == maxIndex)
			{
				type = GameConstants.POKER_TYPE_DEAL6;
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

			AnimationManager.getInstance().playDeal(type);
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
					this.owner.timerOnce(i * 20, this, updateCounter, [place], false);
				}
			}
		}

		private function updateCounter(place:int):void
		{
			GameFunctions.surface_updateCounter.call(null, place, 1);
		}
	}
}