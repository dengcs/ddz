package main.script {
	import laya.components.Script;
	import laya.ui.Button;
	import laya.events.Event;
	import view.SettingDialog;
	
	public class Menu extends Script {

		private var settingBtn:Button 	= null;

		override public function onAwake():void
		{
			settingBtn 	= this.owner.getChildByName("setting") as Button;
		}

		override public function onStart():void
		{
			settingBtn.on(Event.CLICK, this, onSetting);
		}

		private function onSetting():void
		{
			new SettingDialog().popup();
		}
	}
}