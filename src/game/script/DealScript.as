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
	
	public class DealScript extends Script {
		private var placeX0:int = -233;
		private var placeY0:int = 578;
		private var placeX1:int = -280;
		private var placeY1:int = 278;
		private var placeX2:int = 280;
		private var placeY2:int = 278;
		private var placeXStep:int = 41;

		private var ownerSprite:Sprite = null;
		private var pokerList:Array = [];

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as Sprite;
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_DEAL, this, onDeal);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onStart():void
		{
		}

		private function onPrepare():void
		{
			if (this.pokerList.length > 0)
			{
				for each(var pokerImg:Image in this.pokerList)
				{
					pokerImg.visible = true;
				}
			}
			else
			{
				for(var i:int = 0; i<GameConstants.GLOBAL_DEAL_NUM; i++)
				{
					pokerImg = new Image("game/poker/poker_bg.png");
					pokerImg.anchorX = 0.5;
					pokerImg.anchorY = 0.5;
					pokerImg.pos(0, 0);
					this.pokerList.push(pokerImg);
					this.ownerSprite.addChild(pokerImg);
				}
			}
		}

		private function onDeal():void
		{
			this.dealAction(0);
		}

		public function dealAction(index:int):void
		{
			if(index >= GameConstants.GLOBAL_DEAL_NUM)
			{
				return;
			}

			var pokerImg:Image = this.pokerList[index];

			var x:int = 0; // 发牌的目标位置x坐标
			var y:int = 0; // 发牌的目标位置y坐标
			var scaleX:Number = 0.3;
			var scaleY:Number = 0.3;

			var chg:int = Math.floor(index / 36);
			var dealCount:int = 6 - chg;
			var place:int = (Math.floor((index - chg*36) / dealCount) + 1) % 3;
			if(place == 0)
			{				
				var step:int = (Math.floor(index/18)*6) + ((index - chg*36) % dealCount)
				var offsetX:int = step * this.placeXStep;
				x = this.placeX0 + offsetX;
				y = this.placeY0;
				scaleX = 1;
				scaleY = 1;
			}else if(place == 1)
			{
				x = this.placeX1;
				y = this.placeY1;
			}else
			{
				x = this.placeX2;
				y = this.placeY2;
			}
			var delay:int = ((index % 18) == 0 && index > 0) ? 800 : 10;
			Tween.to(pokerImg, {x:x,y:y,scaleX:scaleX,scaleY:scaleY}, 800, Ease.expoOut, Handler.create(this,dealActionComplete,[pokerImg, place]));
			Laya.timer.once(delay, this, dealAction, [index + 1], false);
		}

		private function dealActionComplete(pokerImg:Image, place:int):void
		{
			pokerImg.visible = false;
			pokerImg.scale(1, 1).pos(0,0);
			if(place > 0)
			{
				GameFunctions.surface_updateCounter.call(null, place, 1);	
			}
		}
	}
}