package game.script {
	import laya.components.Script;
	import common.GameEvent;
	import laya.ui.List;
	import laya.ui.Box;
	import laya.display.Sprite;
	import laya.ui.Image;
	import laya.utils.Handler;
	import common.GameConstants;
	import laya.utils.Tween;
	import laya.utils.Ease;

	public class PickUpScript extends Script {
		private var ownerSprite:List = null;

		private var dataArray:Array = [];

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as List;
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_DEAL, this, onDeal);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onEnable():void
		{
			this.ownerSprite.array = this.dataArray;
			this.ownerSprite.renderHandler = new Handler(this, onListRender);
		}

		private function onPrepare():void
		{
			this.dataArray = [];
		}

		private function onDeal(data:Array):void
		{
			var delay:int = 0;
			for(var i:int = 0; i<data.length; i++)
			{
				delay = 300*(i+1);
				var value:int = data[i];
				Laya.timer.once(delay, this, onPickUp, [value]);
			}
			Laya.timer.once(delay, this, onPickUp);
		}

		private function onPickUp(rValue:int):void
		{
			var value:int = Math.ceil(rValue/4);
			var color:int = ((rValue-1) % 4) + 1;

			var itemData:Object = new Object();
			itemData.value = rValue;

			if(rValue == GameConstants.JOKER_SMALL_VALUE)
			{
				itemData.literal = "game/poker/joker_small.png";
				itemData.scolor = "";
				itemData.bcolor = "game/poker/big_small.png";
			}else if(rValue == GameConstants.JOKER_BIG_VALUE){
				itemData.literal = "game/poker/joker_big.png";
				itemData.scolor = "";
				itemData.bcolor = "game/poker/big_joker.png";
			}else{
				var colorStr:String = "red";
				if(color%2 == 0)
				{
					colorStr = "black";
				}
				
				itemData.literal = "game/poker/" + colorStr + "_" + value + ".png";
				itemData.scolor = itemData.bcolor = "game/poker/big_" + color + ".png";
			}
			this.dataArray.push(itemData);
		}

		private function onListRender(cell:Box, index:int): void 
		{
			var item:Object = this.dataArray[index];

			var parent:Sprite = cell.getChildAt(0) as Sprite;

			var literalImg:Image = parent.getChildByName("literal") as Image;
			var scolorImg:Image = literalImg.getChildByName("scolor") as Image;
			var bcolorImg:Image = parent.getChildByName("bcolor") as Image;

			literalImg.skin = item.literal;
			scolorImg.skin 	= item.scolor;
			bcolorImg.skin 	= item.bcolor;
		}

		public function sortAndUpdate():void
		{
			this.dataArray.sort(compareObj);
			this.ownerSprite.refresh();

			function compareObj(a:Object, b:Object):Number
			{
				if(a.value < b.value)
				{
					return 1;
				}
				return -1;
			}
		}

		private function tweenRotateIn():void
		{
			Tween.to(this.ownerSprite, {scaleX:0,scaleY:0,skewY:-15}, 300, Ease.quartIn, Handler.create(this, tweenRotateOut));
		}

		private function tweenRotateOut():void
		{
			this.sortAndUpdate();
			Tween.to(this.ownerSprite, {scaleX:1,scaleY:1,skewY:0}, 300, Ease.quartOut, Handler.create(this, tweenRotateOver));
		}

		private function tweenRotateOver():void
		{
		}
	}
}