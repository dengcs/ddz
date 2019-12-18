package main.runtime
{
	import laya.ui.Button;
	import laya.events.Event;
	import laya.utils.Tween;

	/**
	 * ...
	 * @dengcs
	 */
	public class RoomBtnRunTime extends Button{
		public function RoomBtnRunTime(){
			this.on(Event.MOUSE_DOWN, this, on_mousedown);
			this.on(Event.MOUSE_OVER, this, on_mousedown);
			this.on(Event.MOUSE_UP, this, on_mouseup);			
			this.on(Event.MOUSE_OUT, this, on_mouseup);
		}

		private function on_mousedown():void
		{
			Tween.to(this, {scaleX:1.1,scaleY:1.1}, 100);		
		}

		private function on_mouseup():void
		{
			Tween.to(this, {scaleX:1,scaleY:1}, 100);
		}
	}

}