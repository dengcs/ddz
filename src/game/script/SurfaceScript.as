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
	
	public class SurfaceScript extends Script {

		private var counter:Sprite = null;
		private var leftLab:Label = null;
		private var rightLab:Label = null;

		private var mineHead:Sprite = null;
		private var leftHead:Sprite = null;
		private var rightHead:Sprite = null;		

		override public function onAwake():void
		{
			this.mineHead = this.owner.getChildByName("mineHead") as Sprite;
			this.leftHead = this.owner.getChildByName("leftHead") as Sprite;
			this.rightHead = this.owner.getChildByName("rightHead") as Sprite;
			this.counter = this.owner.getChildByName("counter") as Sprite;
			this.leftLab = this.counter.getChildAt(0).getChildAt(0) as Label;
			this.rightLab = this.counter.getChildAt(1).getChildAt(0) as Label;

			GameFunctions.surface_updateCounter = Utils.bind(updateCounter, this);
		}

		override public function onEnable():void {
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_OVER, this, onOver);
			this.owner.on(GameEvent.EVENT_GAME_START, this, onStartEvent);
		}
		
		override public function onDisable():void {
			this.owner.offAllCaller(this);
		}

		private function onStartEvent(data:*):void
		{
			trace("onStartEvent--", data)
			var mineIdx:int = -1;
			var rightIdx:int = -1;
			var minePid:String = GameStatic.pid;
			var msgData:game_start_notify = data as game_start_notify;
			
			var len:int = msgData.members.length;
			for(var i:int = 0; i < len; i++)
			{
				if(minePid == msgData.members[i].pid)
				{
					mineIdx = i;
					rightIdx = (mineIdx + 1) % len;
					break;
				}				
			}

			for(var j:int = 0; j < len; j++)
			{
				var root:Sprite = null;
				if(j == mineIdx)
				{
					root = this.mineHead;
				}else if(j == rightIdx)
				{
					root = this.rightHead;
				}else
				{
					root = this.leftHead;
				}

				updateHead(root, msgData.members[i]);
			}
		}

		private function onPrepare():void
		{
			this.counter.visible = true;
			this.leftLab.tag = 0;
			this.rightLab.tag = 0;
		}

		private function onOver():void
		{
			this.counter.visible = false;
		}		

		private function updateHead(root:Sprite, data:*):void
		{
			if(root != null)
			{
				var member:GameMember = data as GameMember;
				var headImg:Image = root.getChildAt(0) as Image;
				var boxImg:Image = headImg.getChildAt(0) as Image;

				if(member.portrait == "portrait")
				{
					headImg.skin = "icon/icon_head_g.jpg";
				}

				if(member.portraitBoxId == 0)
				{
					boxImg.skin = "icon/dw_s_1head.png";
				}
			}
		}

		private function updateCounter(place:int, count:int):void
		{
			if(place == 1)
			{
				this.rightLab.tag += count;
				this.rightLab.text = this.rightLab.tag as String;
			}else
			{
				this.leftLab.tag += count;
				this.leftLab.text = this.leftLab.tag as String;
			}
		}
	}
}