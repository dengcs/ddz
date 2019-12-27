package main.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import common.UIFunctions;
	import common.UIFactory;
	
	public class Menu extends Script {

		private var settingBtn:Button 	= null;
		private var emailBtn:Button 	= null;

		override public function onAwake():void
		{
			settingBtn 	= this.owner.getChildByName("setting") as Button;
			emailBtn 	= this.owner.getChildByName("email") as Button;
		}

		override public function onStart():void
		{
			settingBtn.on(Event.CLICK, this, onSetting);
			emailBtn.on(Event.CLICK, this, onEmail);
		}

		private function onSetting():void
		{
			UIFunctions.popup(UIFactory.SETTING);
		}

		private function onEmail():void
		{
			UIFunctions.popup(UIFactory.EMAIL);
		}
	}
}