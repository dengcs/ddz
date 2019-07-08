package common
{
	import laya.display.Sprite;
	import game.manager.UIManager;

	/**
	 * ...
	 * @dengcs
	 */
	public class UIFunctions{
		// 获取ui精灵
		public static function getUI(name:String):Sprite
		{
			return UIManager.getInstance().getUI(name);
		}
		// 判断ui是否添加到列表
		public static function added(name:String):Boolean
		{
			return UIManager.getInstance().added(name);
		}
		// 判断ui是否添加到舞台
		public static function showed(name:String):Boolean
		{
			return UIManager.getInstance().showed(name);
		}
		// 显示ui
		public static function showUI(name:String, params:* = null):void
		{
			UIManager.getInstance().showUI(name, params);
		}
		// 隐藏ui
		public static function hideUI(name:String, params:* = null):void
		{
			UIManager.getInstance().hideUI(name, params);
		}
		// 销毁ui
		public static function destroyUI(name:String, params:* = null, destroyChild:Boolean = true):void
		{
			UIManager.getInstance().destroyUI(name, params, destroyChild);
		}
		// 派发UI事件
		public static function eventUI(name:String, type:String, params:* = null):void
		{
			UIManager.getInstance().eventUI(name, type, params);
		}
	}

}