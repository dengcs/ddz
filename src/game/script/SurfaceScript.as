package game.script {
	import laya.components.Script;
	import laya.display.Sprite;
	import laya.ui.Label;
	import common.GameEvent;
	import common.GameFunctions;
	import laya.utils.Utils;
	
	public class SurfaceScript extends Script {

		private var counter:Sprite = null;
		private var leftLab:Label = null;
		private var rightLab:Label = null;

		override public function onAwake():void
		{
			this.counter = this.owner.getChildByName("counter") as Sprite;
			this.leftLab = this.counter.getChildAt(0).getChildAt(0) as Label;
			this.rightLab = this.counter.getChildAt(1).getChildAt(0) as Label;

			GameFunctions.surface_updateCounter = Utils.bind(updateCounter, this);
		}

		override public function onEnable():void {
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
			this.owner.on(GameEvent.EVENT_GAME_OVER, this, onOver);
		}
		
		override public function onDisable():void {
			this.owner.offAllCaller(this);
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