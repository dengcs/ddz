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
		public static function showUI(index:int, isModal:Boolean = true):void
		{
			var openDialog:Dialog = UIFactory.getDialog(index);
			if(openDialog != null)
			{
				if(isModal)
				{
					openDialog.popup();
				}else
				{
					openDialog.show();
				}
			}
		}
	}

}