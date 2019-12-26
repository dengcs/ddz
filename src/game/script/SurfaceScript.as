package game.script {
	import laya.components.Script;
	import laya.display.Sprite;
	import laya.ui.Label;
	import common.GameEvent;
	import common.GameFunctions;
	import laya.utils.Utils;
	import game.control.NetAction;
	import game.proto.*;
	import laya.ui.Image;
	import common.GameStatic;
	import game.proto.GameMember;
	import laya.events.Event;
	import game.manager.AudioManager;
	import common.GameConstants;
	
	public class SurfaceScript extends Script {

		private var counter:Sprite = null;
		private var leftLab:Label = null;
		private var rightLab:Label = null;

		private var mineHead:Sprite = null;
		private var leftHead:Sprite = null;
		private var rightHead:Sprite = null;

		private var mineHeadImg:Image = null;
		private var leftHeadImg:Image = null;
		private var rightHeadImg:Image = null;

		private var dzMarkImg:Image = null;

		override public function onAwake():void
		{
			this.mineHead = this.owner.getChildByName("mineHead") as Sprite;
			this.leftHead = this.owner.getChildByName("leftHead") as Sprite;
			this.rightHead = this.owner.getChildByName("rightHead") as Sprite;
			this.counter = this.owner.getChildByName("counter") as Sprite;
			this.dzMarkImg = this.owner.getChildByName("dzMark") as Image;

			this.mineHeadImg = this.mineHead.getChildAt(0) as Image;
			this.leftHeadImg = this.leftHead.getChildAt(0) as Image;
			this.rightHeadImg = this.rightHead.getChildAt(0) as Image;

			this.leftLab = this.counter.getChildAt(0).getChildAt(0) as Label;
			this.rightLab = this.counter.getChildAt(1).getChildAt(0) as Label;			

			GameFunctions.surface_updateCounter = Utils.bind(updateCounter, this);
		}

		override public function onEnable():void {
			this.mineHeadImg.on(Event.CLICK, this, onHeadClick, [0]);
			this.rightHeadImg.on(Event.CLICK, this, onHeadClick, [1]);
			this.leftHeadImg.on(Event.CLICK, this, onHeadClick, [2]);
		}

		override public function onStart():void
		{
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_START, this, onGameStart);
			this.owner.on(GameEvent.EVENT_BOTTOM_NOTIFY, this, onBottom);
		}
		
		override public function onDisable():void {
			this.owner.offAllCaller(this);
		}

		private function onGameStart(data:*):void
		{
			trace("onStartEvent--", data)
			var mineIdx:int = -1;
			var minePid:String = GameStatic.pid;
			var msgData:game_start_notify = data as game_start_notify;
			
			var len:int = msgData.members.length;
			for(var i:int = 0; i < len; i++)
			{
				if(minePid == msgData.members[i].pid)
				{
					mineIdx = i;
					break;
				}				
			}

			updateHead(mineIdx, msgData.members);
		}

		private function onPrepare():void
		{
			this.counter.visible = true;
			this.leftLab.tag = 0;
			this.rightLab.tag = 0;
			this.dzMarkImg.visible = false;
		}

		private function onBottom():void
		{
			var offsetX:int = 0;
			var offsetY:int = -135;
			if(NetAction.lordIsMine())
			{
				this.dzMarkImg.x = this.mineHead.x + offsetX;
				this.dzMarkImg.y = this.mineHead.y + offsetY;
			}else if(NetAction.lordIsRight())
			{
				this.dzMarkImg.x = this.rightHead.x + offsetX;
				this.dzMarkImg.y = this.rightHead.y + offsetY;
				this.updateCounter(1, 3);
			}else
			{
				this.dzMarkImg.x = this.leftHead.x + offsetX;
				this.dzMarkImg.y = this.leftHead.y + offsetY;
				this.updateCounter(2, 3);
			}
			this.dzMarkImg.visible = true;
		}

		private function onHeadClick(idx:int, e:Event):void
		{
			trace("onHeadClick", idx)
		}		

		private function updateHead(mineIdx:int, data:*):void
		{
			if(mineIdx >= 0)
			{
				var rightIdx:int = (mineIdx + 1) % 3;
				var members:Vector.<GameMember> = data as Vector.<GameMember>;

				var len:int = members.length;
				for(var i:int = 0; i < len; i++)
				{
					var member:GameMember = members[i];
					var headImg:Image = this.leftHeadImg;
					if(i == mineIdx)
					{
						headImg = this.mineHeadImg;
					}else if(i == rightIdx)
					{
						headImg = this.rightHeadImg;
					}

					headImg.tag = member;
					var boxImg:Image = headImg.getChildAt(0) as Image;
					if(member.portrait == "portrait")
					{
						headImg.skin = "icon/icon_head_g.jpg";
					}

					if(member.portraitBox == 0)
					{
						boxImg.skin = "icon/dw_s_2head_s.png";
					}
				}
			}
		}

		private function updateCounter(place:int, count:int):void
		{
			var left_num:int = 0;
			if(place == 1)
			{
				this.rightLab.tag += count;
				this.rightLab.text = this.rightLab.tag as String;
				left_num = this.rightLab.tag;
			}else
			{
				this.leftLab.tag += count;
				this.leftLab.text = this.leftLab.tag as String;
				left_num = this.leftLab.tag;
			}

			if(NetAction.state == GameConstants.PLAY_STATE_PLAY)
			{
				if(left_num == 2)
				{
					this.owner.timerOnce(400, this, leftCardSound, [GameConstants.SOUND_LEFT_TWO], false);
				}else if(left_num == 1)
				{
					this.owner.timerOnce(400, this, leftCardSound, [GameConstants.SOUND_LEFT_ONE], false);
				}
			}
		}

		private function leftCardSound(type:int):void
		{
			AudioManager.getInstance().playOther(type);
		}
	}
}