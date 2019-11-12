package game.script {
	import laya.components.Script;
	import laya.ui.Image;
	import laya.display.Sprite;
	import common.GameEvent;
	import game.control.NetAction;
	
	public class MarkScript extends Script {
		private var buchuImg:Image = null;
		private var bujiaoImg:Image = null;
		private var jiaodizhuImg:Image = null;
		private var mineMarkVT:Vector.<Image> = new Vector.<Image>();
		private var rightMarkVT:Vector.<Image> = new Vector.<Image>();
		private var leftMarkVT:Vector.<Image> = new Vector.<Image>();

		private var turnCount:int = 0; // 轮空次数

		override public function onAwake():void
		{
			var mineMark:Sprite = this.owner.getChildAt(0) as Sprite;
			var rightMark:Sprite = this.owner.getChildAt(1) as Sprite;
			var leftMark:Sprite = this.owner.getChildAt(2) as Sprite;

			var mineBuChuImg:Image = mineMark.getChildAt(0) as Image;
			var mineBuJiaoImg:Image = mineMark.getChildAt(1) as Image;
			var mineJiaoDiZhuImg:Image = mineMark.getChildAt(2) as Image;
			var rightBuChuImg:Image = rightMark.getChildAt(0) as Image;
			var rightBuJiaoImg:Image = rightMark.getChildAt(1) as Image;
			var rightJiaoDiZhuImg:Image = rightMark.getChildAt(2) as Image;
			var leftBuChuImg:Image = leftMark.getChildAt(0) as Image;
			var leftBuJiaoImg:Image = leftMark.getChildAt(1) as Image;
			var leftJiaoDiZhuImg:Image = leftMark.getChildAt(2) as Image;
			
			this.mineMarkVT.push(mineBuChuImg);
			this.mineMarkVT.push(mineBuJiaoImg);
			this.mineMarkVT.push(mineJiaoDiZhuImg);
			this.rightMarkVT.push(rightBuChuImg);
			this.rightMarkVT.push(rightBuJiaoImg);
			this.rightMarkVT.push(rightJiaoDiZhuImg);
			this.leftMarkVT.push(leftBuChuImg);
			this.leftMarkVT.push(leftBuJiaoImg);
			this.leftMarkVT.push(leftJiaoDiZhuImg);
		}

		override public function onEnable():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_GAME_BOTTOM, this, onBottom);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);
		}

		override public function onDisable():void
		{
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			this.turnCount = 0;
			this.clearMark();
		}

		private function onSnatch(data:Object):void
		{
			var idx:int = data.idx;
			var isBuJiao:Boolean = data.msg == 0;
			if(NetAction.idxIsMine(idx))
			{
				if(isBuJiao)
				{
					this.mineMarkVT[1].visible = true;
				}else
				{
					this.mineMarkVT[2].visible = true;
				}
			}else if(NetAction.idxIsRight(idx))
			{
				if(isBuJiao)
				{
					this.rightMarkVT[1].visible = true;
				}else
				{
					this.rightMarkVT[2].visible = true;
				}
			}else
			{
				if(isBuJiao)
				{
					this.leftMarkVT[1].visible = true;
				}else
				{
					this.leftMarkVT[2].visible = true;
				}
			}
		}

		private function onBottom():void
		{
			Laya.timer.once(800, this, clearSnatchMark, null, false);
		}

		private function onPlay(msgData:Object):void
		{
			if(msgData)
			{				
				var idx:int = msgData.idx;
				var isTrue:Boolean = msgData.msg is int;
				if(NetAction.idxIsMine(idx))
				{
					if(isTrue) this.mineMarkVT[0].visible = true;
				}else if(NetAction.idxIsRight(idx))
				{
					if(isTrue) this.rightMarkVT[0].visible = true;
				}else
				{
					if(isTrue) this.leftMarkVT[0].visible = true;
				}

				if(isTrue)
				{
					this.turnCount += 1;
					if(this.turnCount > 1)
					{
						this.clearMark();
					}
				}else
				{
					this.turnCount = 0;
				}
			}
		}

		private function showMark(toward:int, idx:int):void
		{
			var targetVT:Vector.<Image> = this.leftMarkVT;
			if(toward == 1)
			{
				targetVT = this.mineMarkVT;
			}else if(toward == 2)
			{
				targetVT = this.rightMarkVT;
			}

			var markImg:Image = targetVT[idx];
			if(markImg != null)
			{
				markImg.visible = true;
			}
		}

		private function clearMark():void
		{
			for each(var mineImg:Image in this.mineMarkVT)
			{
				mineImg.visible = false;
			}

			for each(var rightImg:Image in this.rightMarkVT)
			{
				rightImg.visible = false;
			}

			for each(var leftImg:Image in this.leftMarkVT)
			{
				leftImg.visible = false;
			}
		}

		private function clearSnatchMark():void
		{
			for(var x:int =1; x < 3; x++)
			{
				this.mineMarkVT[x].visible = false;
			}

			for(var y:int =1; y < 3; y++)
			{
				this.rightMarkVT[y].visible = false;
			}

			for(var z:int =1; z < 3; z++)
			{
				this.leftMarkVT[z].visible = false;
			}
		}
	}
}