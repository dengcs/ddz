package main.script {
	import laya.components.Script;
	import laya.events.Event;
	import game.manager.AudioManager;
	import common.GameConstants;
	import common.GameGlobal;
	import laya.display.Scene;
	
	public class Room extends Script {
		/** @prop {name:btnType, tips:"比赛类型", type:Int, default:0}*/
		public var btnType: int = 0;

		override public function onClick(e:Event):void
		{
			GameGlobal.roomType	= btnType;
			Scene.open(GameConstants.gameScene);
			AudioManager.getInstance().playOther(GameConstants.SOUND_BUTTON_DOWN);			
		}
	}
}