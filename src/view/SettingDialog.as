package view {

	import ui.dialog.SettingUI;

	public class SettingDialog extends SettingUI{
		override public function onClosed(type:String = null):void
		{
			trace("dcs----onClosed")
		}
    }
}