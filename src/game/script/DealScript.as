package game.script {
	import laya.components.Script;
	import common.GameEvent;
	import laya.ui.Image;
	import laya.display.Sprite;
	import common.GameConstants;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import laya.utils.Handler;
	
	public class DealScript extends Script {
		private var placeX0:int = -300;
		private var placeY0:int = 100;
		private var placeX1:int = 0;
		private var placeY1:int = 100;
		private var placeX2:int = 300;
		private var placeY2:int = 100;
		private var placeXStep1:int = 0;

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

			var place:int = index % 3;

			if(place == 0)
			{
				x = this.placeX0;
				y = this.placeY0;
			}else if(place == 1)
			{
				var offsetX:int = Math.floor(index/3) * this.placeXStep1;
				x = this.placeX1 + offsetX;
				y = this.placeY1;
				scaleX = 1;
				scaleY = 1;
			}else
			{
				x = this.placeX2;
				y = this.placeY2;
			}
			Tween.to(pokerImg, {x:x,y:y,scaleX:scaleX,scaleY:scaleY}, 300, Ease.strongIn, Handler.create(this,dealActionComplete,[pokerImg]));
			Laya.timer.once(100, this, dealAction, [index + 1]);
		}

		private function dealActionComplete(pokerImg:Image):void
		{
			pokerImg.visible = false;
			pokerImg.scale(1, 1).pos(0,0);
		}
	}
}