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
	import game.control.NetAction;

	public class OwnerListScript extends Script {
		private var ownerSprite:List = null;

		private var dataArray:Array = [];
		private var mineIdx:int = 0;

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as List;			
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_DEAL, this, onDeal);
			this.owner.on(GameEvent.EVENT_GAME_BOTTOM, this, onBottom);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onEnable():void
		{
			this.ownerSprite.renderHandler = new Handler(this, onListRender);
		}

		private function onPrepare(data:Object):void
		{
			this.dataArray = [];
			this.ownerSprite.array = [];
			this.ownerSprite.visible = false;
			this.mineIdx = data.idx;
		}

		private function onDeal(... data):void
		{			
			var delay:int = 0;
			for(var i:int = 0; i<data.length; i++)
			{
				delay = 300*(i+1);
				var value:int = data[i];
				Laya.timer.once(delay, this, onPickUp, [value], false);
			}
			delay += 300;
			Laya.timer.once(delay, this, tweenRotateIn);
		}

		private function onBottom(... data):void
		{
			var subX:Number = (3*41)/2;
			this.ownerSprite.x -= subX;
			for(var i:int = 0; i<data.length; i++)
			{
				var value:int = data[i];
				this.pickUp(value);
			}
			this.sortAndUpdate();
			
			for each(var val:int in data)
			{
				for(var j:int = 0; j<this.dataArray.length; j++)
				{
					var itemData:Object = this.dataArray[j];
					if(itemData.value == val)
					{
						var cell:Box = this.ownerSprite.getCell(j);
						if(cell != null)
						{
							cell.y = -30;
							Tween.to(cell, {y : 0}, 300, Ease.quadIn, null, 500);
						}
					}
				}
			}			
		}

		private function pickUp(rValue:int):void
		{
			var value:int = Math.ceil(rValue/4);
			var color:int = ((rValue-1) % 4) + 1;

			var itemData:Object = new Object();
			itemData.value = rValue;

			if(rValue == GameConstants.JOKER_SMALL_VALUE)
			{
				itemData.pValue = "game/poker/joker_small.png";
				itemData.pType1 = "";
				itemData.pType2 = "game/poker/big_small.png";
			}else if(rValue == GameConstants.JOKER_BIG_VALUE){
				itemData.pValue = "game/poker/joker_big.png";
				itemData.pType1 = "";
				itemData.pType2 = "game/poker/big_joker.png";
			}else{
				var colorStr:String = "red";
				if(color%2 == 0)
				{
					colorStr = "black";
				}
				
				itemData.pValue = "game/poker/" + colorStr + "_" + value + ".png";
				itemData.pType1 = itemData.pType2 = "game/poker/big_" + color + ".png";
			}
			this.dataArray.push(itemData);
		}

		private function onPickUp(rValue:int):void
		{
			this.pickUp(rValue);
			this.update();
		}

		private function onListRender(cell:Box, index:int): void 
		{
			var parent:Sprite = cell.getChildAt(0) as Sprite;

			var valueImg:Image = parent.getChildByName("value") as Image;
			var typeImg1:Image = valueImg.getChildByName("type1") as Image;
			var typeImg2:Image = parent.getChildByName("type2") as Image;

			valueImg.skin 	= cell.dataSource.pValue;
			typeImg1.skin 	= cell.dataSource.pType1;
			typeImg2.skin 	= cell.dataSource.pType2;
		}

		private function update():void
		{
			this.ownerSprite.array = this.dataArray;
			this.ownerSprite.visible = true;
		}

		private function sortAndUpdate():void
		{
			function compareObj(a:Object, b:Object):Number
			{
				if(a.value < b.value)
				{
					return 1;
				}
				return -1;
			}
			this.dataArray.sort(compareObj);
			this.update();
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
			NetAction.doSnatch(null);
		}
	}
}