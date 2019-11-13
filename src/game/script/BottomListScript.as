package game.script {
	import laya.components.Script;
	import laya.ui.List;
	import common.GameEvent;
	import laya.utils.Handler;
	import laya.display.Sprite;
	import laya.ui.Image;
	import common.GameConstants;
	import laya.ui.Box;
	import laya.utils.Tween;
	import laya.utils.Ease;
	
	public class BottomListScript extends Script {

		private var ownerSprite:List = null;
		private var dataArray:Array = [];

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as List;			
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_BOTTOM, this, onBottom);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onEnable():void {
			this.ownerSprite.renderHandler = new Handler(this, onListRender);
		}

		private function onPrepare():void
		{
			this.dataArray = [];
			this.ownerSprite.array = [];
			this.ownerSprite.visible = false;
		}

		private function onListRender(cell:Box, index:int):void 
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

		private function onBottom(... data:Array):void
		{			
			for(var i:int = 0; i<data.length; i++)
			{
				var value:int = data[i];
				this.pickUp(value);
			}
			this.sortAndUpdate();
			this.tweenToTop();
		}

		private function tweenToTop():void
		{
			var centerCell:Box = this.ownerSprite.getCell(1);
			if(centerCell != null)
			{
				for(var i:int = 0; i < 3; i++)
				{
					var cell:Box = this.ownerSprite.getCell(i);
					if(cell != null)
					{
						var x:Number = centerCell.x + (i - 1)*110;
						var y:Number = -410;
						var scaleX:Number = 0.7;
						var scaleY:Number = 0.7;
						var delay:int = 300 + i*30;
						Tween.to(cell, {x:x,y:y,scaleX:scaleX,scaleY:scaleY}, 300, Ease.backIn, null, delay);
					}
				}
			}
		}
	}
}