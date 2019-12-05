package main.script {
	import laya.components.Script;
	import laya.ui.TextInput;
	import laya.ui.Button;
	import laya.events.Event;
	import game.proto.game_cmd_test;
	import game.net.NetClient;
	
	public class TestScript extends Script {
		private var txtCmd:TextInput;
		private var btnSubmit:Button;

		override public function onAwake():void
		{
			txtCmd 		= this.owner.getChildByName("txtCmd") as TextInput;
			btnSubmit	= this.owner.getChildByName("btnSubmit") as Button;
		}

		override public function onEnable():void {
			btnSubmit.on(Event.CLICK, this, onSubmit)
		}

		private function onSubmit():void
		{
			trace(txtCmd.text)

			var msg_data:game_cmd_test = new game_cmd_test();
				
			msg_data.cmdStr = txtCmd.text
			
			NetClient.send("game_cmd_test", msg_data);
		}
	}
}