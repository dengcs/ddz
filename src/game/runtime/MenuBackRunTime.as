package game.runtime
{
	import laya.ui.Button;
	import laya.events.Event;
	import laya.utils.Tween;

	/**
	 * ...
	 * @dengcs
	 */
	public class MenuBackRunTime extends Button{
		public function MenuBackRunTime(){
			this.on(Event.MOUSE_DOWN, this, on_mousedown);
			this.on(Event.MOUSE_UP, this, on_mouseup);
			this.on(Event.MOUSE_OUT, this, on_mouseup);
		}

		private function on_mousedown():void
		{
			this.skin = "button/out_touched.png";
		}

		private function on_mouseup():void
		{
			this.skin = "button/out.png";
		}
	}

}