package game.script {
	import laya.components.Script;
	import laya.ui.TextInput;
	import laya.ui.Button;
	import laya.events.Event;
	
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
		}
	}
}