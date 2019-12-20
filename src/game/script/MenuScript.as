package game.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import game.control.NetAction;
	import laya.display.Scene;
	import laya.ui.Image;
	import laya.ui.Label;
	import common.UIFunctions;
	import common.UIFactory;
	
	public class MenuScript extends Script {
		private var backBtn:Button 		= null;
		private var settingBtn:Button 	= null;
		private var tipsImg:Image		= null;

		override public function onAwake():void
		{
			backBtn 	= this.owner.getChildByName("back") as Button;
			settingBtn 	= this.owner.getChildByName("setting") as Button;
			tipsImg		= this.owner.getChildByName("tips") as Image;
		}

		override public function onStart():void
		{
			backBtn.on(Event.CLICK, this, onBack);
			settingBtn.on(Event.CLICK, this, onSetting);
		}

		private function onBack():void
		{
			if(NetAction.gameIsOver())
			{
				GameConfig.startScene && Scene.open(GameConfig.startScene);
			}else
			{
				tipsImg.visible = true;
				this.owner.timerOnce(600, this, hideTips);
			}
		}

		private function onSetting():void
		{
			UIFunctions.showUI(UIFactory.SETTING);
		}

		private function hideTips():void
		{
			tipsImg.visible = false;
		}
	}
}