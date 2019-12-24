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
	import laya.events.Event;
	import laya.utils.Utils;
	import common.GameFunctions;
	import game.control.GameAction;
	import game.utils.TypeFetch;
	import game.utils.TypeCheck;
	import game.manager.AudioManager;

	public class OwnerListScript extends Script {
		/** @prop {name:ownerX, tips:"初始x坐标值", type:Number, default:0}*/
		public var ownerX: Number = 0;
		private var ownerSprite:List = null;
		private var dzTipImg:Image = null;

		private var dataArray:Array = [];
		private var cellY:int = -30;

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as List;
			this.dzTipImg = this.owner.getChildByName("dzTip") as Image;
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_DEAL, this, onDeal);
			this.owner.on(GameEvent.EVENT_BOTTOM_NOTIFY, this, onBottom);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onEnable():void
		{
			this.ownerSprite.renderHandler = new Handler(this, onListRender);
			this.ownerSprite.mouseHandler = new Handler(this, onListMouse);
		}

		override public function onStart():void
		{
			GameFunctions.ownerList_play = Utils.bind(play, this);
			GameFunctions.ownerList_delCell = Utils.bind(delCell, this);
			GameFunctions.ownerList_prompt = Utils.bind(prompt, this);
			GameFunctions.ownerList_playPrompt = Utils.bind(playPrompt, this);
		}

		private function onPrepare():void
		{
			this.dataArray = [];
			this.ownerSprite.array = [];
			this.ownerSprite.visible = false;
			this.ownerSprite.x = this.ownerX + 60;
			this.dzTipImg.visible = false;
		}

		// 刷新x坐标
		private function refreshX():void
		{
			var subCount:int = 20 - this.dataArray.length;
			var subX:Number = (subCount*41)/2;
			this.ownerSprite.x = this.ownerX + subX;
		}

		private function refreshY():void
		{
			var len:int = this.dataArray.length;
			for(var i:int = 0; i < len; i++)
			{
				var cell:Box = this.ownerSprite.getCell(i);
				if(cell != null)
				{
					cell.y = 0;
				}
			}
		}

		private function refreshDZ():void
		{
			if(NetAction.ownerIsMine())
			{
				var len:int = this.dataArray.length;
				if(len == 0)
				{
					this.dzTipImg.visible = false;
				}else
				{
					this.dzTipImg.visible = true;
					this.dzTipImg.x = 150 + (len - 1)*41;

					var cell:Box = this.ownerSprite.getCell(len - 1);
					if(cell != null)
					{
						this.dzTipImg.y = cell.y;
					}
				}

			}
		}

		private function hasSelected():Boolean
		{
			var len:int = this.dataArray.length;
			for(var i:int = 0; i < len; i++)
			{
				var cell:Box = this.ownerSprite.getCell(i);
				if(cell != null && cell.y != 0)
				{
					return true;
				}
			}
			return false;
		}

		private function onDeal(... data:Array):void
		{			
			var interval:int = 600;
			var delay:int = 0;
			var len:int = data.length;
			for(var m:int = 0; m < 3; m++)
			{
				var batch:Array = new Array();
				for(var n:int = 0; n < 6; n++)
				{
					var i:int = m*6 + n;
					if(i < len)
					{
						batch.push(data[i]);
					}
				}
				delay = (2 + 3*m) * interval;
				this.owner.timerOnce(delay, this, onPickUp, batch, false);
			}
			delay += 3 * interval;
			this.owner.timerOnce(delay, this, tweenRotateIn, null, false);
		}

		private function onBottom(... data:Array):void
		{			
			for(var i:int = 0; i<data.length; i++)
			{
				var value:int = data[i];
				this.pickUp(value);
			}
			this.refreshX();
			this.sortAndUpdate();
			this.refreshY();
			
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
							cell.y = this.cellY;
							Tween.to(cell, {y : 0}, 300, Ease.quadIn, null, 500);
						}
					}
				}
			}
			this.owner.timerOnce(1000, this, refreshDZ, null, false);
		}

		private function pickUp(rValue:int):void
		{
			var value:int = Math.ceil(rValue/4);
			var color:int = ((rValue-1) % 4) + 1;

			var itemData:Object = new Object();
			itemData.value = rValue;

			if(rValue == GameConstants.JOKER_SMALL_VALUE)
			{
				itemData.pValue = "poker/joker_small.png";
				itemData.pType1 = "";
				itemData.pType2 = "poker/big_small.png";
			}else if(rValue == GameConstants.JOKER_BIG_VALUE){
				itemData.pValue = "poker/joker_big.png";
				itemData.pType1 = "";
				itemData.pType2 = "poker/big_joker.png";
			}else{
				var colorStr:String = "red";
				if(color%2 == 0)
				{
					colorStr = "black";
				}
				
				itemData.pValue = "poker/" + colorStr + "_" + value + ".png";
				itemData.pType1 = itemData.pType2 = "poker/big_" + color + ".png";
			}
			this.dataArray.push(itemData);
		}

		private function onPickUp(... data:Array):void
		{
			for each(var rValue:int in data)
			{
				this.pickUp(rValue);
			}
			this.update();
			this.refreshY();
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

		private function onListMouse(e:Event, index:int):void
		{
			// trace("onListMouse--", e, index);
			switch(e.type)
			{
				case Event.CLICK:
				case Event.MOUSE_OVER:
				{
					if(e.type == Event.MOUSE_OVER)
					{
						if(e.touchId == 0) break;						
					}

					if(e.currentTarget.y != this.cellY)
					{
						e.currentTarget.y = this.cellY;
					}else
					{
						e.currentTarget.y = 0;
					}

					this.refreshDZ();
					this.playMark();					
					break;
				}
				default:
					break;
			}
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
			GameFunctions.control_callLord.call();
			GameFunctions.clock_start.call();
		}

		// 获取要出的牌发送到服务端
		private function play():void
		{
			var playArray:Array = [];
			var len:int = this.dataArray.length;
			for(var i:int = 0; i<len; i++)
			{
				var cell:Box = this.ownerSprite.getCell(i);
				if(cell != null && cell.y == this.cellY)
				{
					playArray.push(cell.dataSource.value);
				}
			}
			GameFunctions.send_game_update(GameConstants.PLAY_STATE_PLAY, playArray);
		}

		// 服务端验证通过把要出的牌删掉
		private function delCell(data:Array):void
		{
			for each(var val:int in data)
			{
				var len:int = this.dataArray.length;
				for(var j:int = len - 1; j>=0; j--)
				{
					var itemData:Object = this.dataArray[j];
					if(itemData.value == val)
					{
						var cell:Box = this.ownerSprite.getCell(j);
						if(cell != null)
						{
							cell.y = 0;
							this.dataArray.splice(j, 1);
						}
					}
				}
			}
			this.update();
			this.refreshX();
			this.refreshY();
			this.refreshDZ();

			if(this.dataArray.length == 2)
			{
				this.owner.timerOnce(400, this, leftCardSound, [GameConstants.SOUND_LEFT_TWO], false);
			}else if(this.dataArray.length == 1)
			{
				this.owner.timerOnce(400, this, leftCardSound, [GameConstants.SOUND_LEFT_ONE], false);
			}
		}

		private function leftCardSound(type:int):void
		{
			AudioManager.getInstance().playOther(type);
		}

		// 出牌提示
		private function prompt():void
		{			
			var roundData:Object = GameAction.roundData;
			var cards:Vector.<int> = new Vector.<int>();
			var len:int = this.dataArray.length;
			for(var i:int = 0; i<len; i++)
			{
				cards.push(this.dataArray[i].value);
			}

			var retData:Object = null;

			if(this.hasSelected())
			{
				this.refreshY();
			}else
			{
				if(NetAction.idxIsMine(roundData.idx))
				{
					// 自动选择类型
					retData = TypeFetch.auto_fetch(cards);
				}else
				{
					retData = TypeFetch.fetch_type(cards, roundData.type, roundData.value, roundData.count);
				}

				if(retData == null) return
				
				for each(var idx:int in retData.indexes)
				{
					var cell:Box = this.ownerSprite.getCell(idx);
					if(cell != null)
					{
						cell.y = this.cellY;
					}
				}
			}

			this.refreshDZ();
			this.playMark();
		}

		// 按钮提示
		private function playPrompt():int
		{
			var ret:int = 1;

			var roundData:Object = GameAction.roundData;
			if(NetAction.idxIsMine(roundData.idx))
			{
				ret = 2;
			}else
			{
				var cards:Vector.<int> = new Vector.<int>();
				var len:int = this.dataArray.length;
				for(var i:int = 0; i<len; i++)
				{
					cards.push(this.dataArray[i].value);
				}

				var retData:Object = TypeFetch.fetch_type(cards, roundData.type, roundData.value, roundData.count);
				if(retData != null)
				{
					ret = 3;					
				}
			}

			if(ret > 1)
			{
				this.playMark();
			}
			return ret;
		}

		// 控制出牌按钮是否变灰
		private function playMark():void
		{
			var roundData:Object = GameAction.roundData;

			var cards:Vector.<int> = new Vector.<int>();
			var len:int = this.dataArray.length;
			for(var i:int = 0; i<len; i++)
			{
				var cell:Box = this.ownerSprite.getCell(i);
				if(cell != null && cell.y == this.cellY)
				{
					cards.push(this.dataArray[i].value);
				}
			}

			if(cards.length == 0)
			{
				GameFunctions.control_markPlay.call(null, true);				
			}else
			{
				var retData:Object = null;
				if(NetAction.idxIsMine(roundData.idx))
				{
					retData = TypeCheck.test_type(cards);
				}else
				{
					retData = TypeFetch.fetch_type(cards, roundData.type, roundData.value, roundData.count);
				}

				if(retData != null)
				{
					GameFunctions.control_markPlay.call(null, false);
				}else
				{
					GameFunctions.control_markPlay.call(null, true);
				}
			}

		}
	}
}