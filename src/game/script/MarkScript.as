package game.script {
	import laya.components.Script;
	import laya.ui.Image;
	import laya.display.Sprite;
	import common.GameEvent;
	import game.control.NetAction;
	import game.control.GameAction;
	
	public class MarkScript extends Script {
		private var mineMarkImg:Image = null;
		private var rightMarkImg:Image = null;
		private var leftMarkImg:Image = null;

		private var markSkinVT:Vector.<String> = new Vector.<String>();

		private var turnCount:int = 0; // 轮空次数

		override public function onAwake():void
		{
			this.mineMarkImg = this.owner.getChildAt(0) as Image;
			this.rightMarkImg = this.owner.getChildAt(1) as Image;
			this.leftMarkImg = this.owner.getChildAt(2) as Image;

			this.markSkinVT.push("mark/jiaodizhu.png");
			this.markSkinVT.push("mark/nocall.png");
			this.markSkinVT.push("mark/qiangdizhu.png");
			this.markSkinVT.push("mark/buqiang.png");
			this.markSkinVT.push("mark/buchu.png");
		}

		override public function onEnable():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_SNATCH, this, onSnatch);
			this.owner.on(GameEvent.EVENT_GAME_BOTTOM, this, onBottom);
			this.owner.on(GameEvent.EVENT_GAME_PLAY, this, onPlay);
			this.owner.on(GameEvent.EVENT_GAME_OVER, this, onOver);
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
			var toward:int = 3;
			var idx:int = data.idx;
			var isNocall:Boolean = data.msg == 0;
			if(NetAction.idxIsMine(idx))
			{
				toward = 1;
			}else if(NetAction.idxIsRight(idx))
			{
				toward = 2;
			}

			if(GameAction.haveOwner())
			{
				if(isNocall)
				{
					this.showMark(toward, 3);
				}else
				{
					this.showMark(toward, 2);
				}
			}else
			{
				if(isNocall)
				{
					this.showMark(toward, 1);
				}else
				{
					this.showMark(toward, 0);
				}
			}
		}

		private function onBottom():void
		{
			this.owner.timerOnce(800, this, clearMark, null, false);
		}

		private function onPlay(msgData:Object):void
		{
			if(msgData)
			{
				var markSkin:String = this.markSkinVT[4];
				var idx:int = msgData.idx;
				var isTrue:Boolean = msgData.msg is int;
				if(NetAction.idxIsMine(idx))
				{
					if(isTrue)
					{
						this.mineMarkImg.skin = markSkin;
						this.mineMarkImg.visible = true;
					}
					this.rightMarkImg.visible = false;
				}else if(NetAction.idxIsRight(idx))
				{
					if(isTrue)
					{
						this.rightMarkImg.skin = markSkin;
						this.rightMarkImg.visible = true;
					}
					this.leftMarkImg.visible = false;
				}else
				{
					if(isTrue)
					{
						this.leftMarkImg.skin = markSkin;
						this.leftMarkImg.visible = true;
					}
					this.mineMarkImg.visible = false;
				}

				if(isTrue)
				{
					this.turnCount += 1;					
				}else
				{
					if(this.turnCount > 2)
					{
						this.turnCount = 0;
						this.clearMark();
					}
				}
			}else
			{
				this.mineMarkImg.visible = false;
			}
		}

		private function onOver():void
		{
			this.clearMark();
		}

		private function showMark(toward:int, idx:int):void
		{
			var targetImg:Image = this.leftMarkImg;
			if(toward == 1)
			{
				targetImg = this.mineMarkImg;
			}else if(toward == 2)
			{
				targetImg = this.rightMarkImg;
			}

			if(idx < this.markSkinVT.length)
			{
				var markSkin:String = this.markSkinVT[idx];
				targetImg.skin = this.markSkinVT[idx];
				targetImg.visible = true;
			}
		}

		private function clearMark():void
		{
			this.mineMarkImg.visible = false;
			this.rightMarkImg.visible = false;
			this.leftMarkImg.visible = false;
		}
	}
}