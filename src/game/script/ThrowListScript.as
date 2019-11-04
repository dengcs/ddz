package game.script {
	import laya.components.Script;
	import laya.ui.List;
	import common.GameEvent;
	import laya.utils.Handler;
	import laya.ui.Box;
	import laya.display.Sprite;
	import laya.ui.Image;
	import laya.utils.Tween;
	import laya.utils.Ease;
	import common.GameConstants;
	import common.GameFunctions;
	import com.utils.Dictionary;
	
	public class ThrowListScript extends Script {
		/** @prop {name:place, tips:"0:自己;1:右边;2:左边", type:Int, default:0}*/
		public var place: int = 0;
		/** @prop {name:target, tips:"出牌目标位置", type:Number, default:0}*/
		public var target: Number = 0;
		/** @prop {name:source, tips:"出牌初始位置", type:Number, default:0}*/
		public var source: Number = 0;

		private var ownerSprite:List = null;

		private var dataArray:Array = [];

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as List;
			this.ownerSprite.visible = false;
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onThrow);
			this.owner.on(GameEvent.EVENT_GAME_TURN, this, onRecoverState);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onEnable():void
		{
			this.ownerSprite.renderHandler = new Handler(this, onListRender);
		}

		private function onPrepare():void
		{
			this.dataArray = [];
			this.ownerSprite.array = [];
			this.ownerSprite.alpha = 0;
			this.ownerSprite.visible = true;
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

		// 排序
		private function sort(data:Array):Array
		{
			data.sort(GameFunctions.compareDes);
			var retData:Array = new Array();

			var mode:Dictionary = new Dictionary();
			for(var i:int = 0; i < data.length; i++)
			{
				var card:int = Math.ceil(data[i]/4);
				var values:Array = mode.get(card);
				if(values == null)
				{
					values = new Array();
					mode.set(card, values);
				}
				values.push(data[i]);
			}

			for(var m:int = 4; m > 0; m--)
			{
				for(var k:int = 0; k < mode.keys.length; k++)
				{
					var kVal:int = mode.keys[k];
					var cValues:Array = mode.get(kVal);
					if(m == cValues.length)
					{
						retData = retData.concat(cValues);
					}
				}
			}

			return retData;
		}

		private function onThrow(... data:Array):void
		{
			var sortData:Array = this.sort(data);
			for(var i:int = 0; i<sortData.length; i++)
			{
				var value:int = sortData[i];
				this.pickUp(value);
			}
			this.ownerSprite.width = 151 + this.dataArray.length * 41;
			this.ownerSprite.array = this.dataArray;
			this.ownerSprite.scale(0.8, 0.8);
			if(this.place == 0)
			{
				GameFunctions.ownerList_delCell.call(null, sortData);
				Tween.to(this.ownerSprite, {y:target,scaleX:0.5,scaleY:0.5,alpha:1}, 300, Ease.quadInOut);
			}else
			{
				Tween.to(this.ownerSprite, {x:target,scaleX:0.5,scaleY:0.5,alpha:1}, 300, Ease.quadInOut);
			}
		}

		// 还原初始状态
		private function onRecoverState():void
		{
			this.dataArray = [];
			this.ownerSprite.alpha = 0;
			if(this.place == 0)
			{
				this.ownerSprite.y = this.source;
			}else
			{
				this.ownerSprite.x = this.source;
			}
		}
	}
}