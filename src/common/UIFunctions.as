package common
{
	import laya.display.Sprite;
	import game.manager.UIManager;
	import com.utils.Dictionary;
	import laya.ui.Dialog;

	/**
	 * ...
	 * @dengcs
	 */
	public class UIFunctions{
		public static function show(index:int, closeOther:Boolean = false, showEffect:Boolean = true):void
		{
			var openDialog:Dialog = UIFactory.getDialog(index);
			if(openDialog != null)
			{
				openDialog.show(closeOther, showEffect);
			}
		}

		public static function popup(index:int, closeOther:Boolean = false, showEffect:Boolean = true):void
		{
			var openDialog:Dialog = UIFactory.getDialog(index);
			if(openDialog != null)
			{
				openDialog.popup(closeOther, showEffect);
			}
		}

		public static function open(index:int, closeOther:Boolean = true, params:* = null):void
		{
			var openDialog:Dialog = UIFactory.getDialog(index);
			if(openDialog != null)
			{
				openDialog.open(closeOther, params);
			}
		}
	}

}