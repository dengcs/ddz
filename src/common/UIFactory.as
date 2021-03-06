package common {
	import view.SettingDialog;
	import laya.ui.Dialog;
	import view.EMailDialog;
	import view.SettleDialog;

	public final class UIFactory {
		private static var inited:Boolean				= false;
		private static var dialogArray:Array			= new Array();

		public 	static var SETTING:int					= 0;
		public 	static var EMAIL:int					= 1;
		public 	static var SETTLE:int					= 2;

		private static function init():void
		{
			inited = true;
			dialogArray.push(new SettingDialog());
			dialogArray.push(new EMailDialog());
			dialogArray.push(new SettleDialog());
		}

		public static function getDialog(index:int):Dialog
		{
			if(inited == false)
			{
				init();
			}

			if(index < dialogArray.length)
			{
				return dialogArray[index];
			}
			return null;
		}
	}
}