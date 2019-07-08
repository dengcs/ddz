package game.base {
	import laya.display.Sprite;
	import com.utils.Dictionary;
	
	public class UIBase extends Sprite {
		private var _uiDic:Dictionary = new Dictionary();

		public function get uiDic():Dictionary
		{
			return _uiDic;
		}

		public function initUIs():void
		{

		}		

		public function addUI(ui:Sprite):void
		{
			uiDic.set(ui.name, ui);
		}

		public function removeUI(name:String):void
		{
			uiDic.remove(name);
		}
	}
}