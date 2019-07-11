package game.script {
	import laya.components.Script;
	import laya.events.Event;
	import laya.display.Scene;
	import common.GameConstants;
	
	public class EnterScript extends Script {
		/** @prop {name:btnType, tips:"比赛类型", type:Int, default:0}*/
		public var btnType: int = 0;

		override public function onClick(e:Event):void
		{
			switch(btnType)
			{
				case 1:
				case 2:
				case 3:
				case 4:
					this.on_open_game();
					break;
				default:
					break;
			}
		}

		private function on_open_game():void
		{
			Scene.open(GameConstants.gameScene);
		}
	}
}