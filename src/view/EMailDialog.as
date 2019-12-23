package view {

	import ui.dialog.EMailUI;
	import laya.ui.TextInput;
	import laya.ui.Button;
	import laya.events.Event;
	import game.proto.game_cmd_test;
	import game.net.NetClient;

	public class EMailDialog extends EMailUI{
		override public function onAwake():void
		{
		}

		override public function onEnable():void
		{
			btnExe.on(Event.CLICK, this, onExe);
		}

		private function onExe():void
		{
			trace(txtCmd.text)

			var msg_data:game_cmd_test = new game_cmd_test();
				
			msg_data.cmdStr = txtCmd.text
			
			NetClient.send("game_cmd_test", msg_data);
		}
    }
}