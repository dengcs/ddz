package game.script {
	import laya.components.Script;
	import laya.display.Sprite;
	import common.GameEvent;
	
	public class ClockScript extends Script {
		private var ownerSprite:Sprite = null;

		private var leftPos:int 		= 1;
		private var rightPos:int		= 2;
		private var mineOnePos:int 		= 3;
		private var mineTwoPos:int 		= 4;
		private var mineThreePos:int 	= 5;

		private var posArray:Array = null;
		override public function onAwake():void
		{
			this.ownerSprite = this.owner as Sprite;
			this.posArray = [0,0];
		}

		override public function onEnable():void {
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
		}
		
		override public function onDisable():void {
			this.owner.offAllCaller(this);
		}

		private function onPrepare():void
		{
			this.ownerSprite.visible = false;
		}

		private function getPosition(type:int):Array
		{
			if(type == this.leftPos)
			{
				this.posArray[0] = -240;
				this.posArray[1] = -120;
			}else if(type == this.rightPos)
			{
				this.posArray[0] = 240;
				this.posArray[1] = -120;
			}else if(type == this.mineOnePos)
			{
				this.posArray[0] = 0;
				this.posArray[1] = 0;
			}else if(type == this.mineTwoPos)
			{
				this.posArray[0] = 0;
				this.posArray[1] = 0;
			}else
			{
				this.posArray[0] = 0;
				this.posArray[1] = 0;
			}
			return this.posArray;
		}

		private function startTick():void
		{

		}

		private function toTick(toward:int):void
		{
			
		}
	}
}