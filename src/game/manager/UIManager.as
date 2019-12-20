package game.manager {

	import laya.ui.DialogManager;
	import laya.ui.Dialog;

	public final class UIManager extends DialogManager{
		public static function init():void
		{
			Dialog.manager = new UIManager();
		}

		override public function open(dialog:Dialog, closeOther:Boolean = null, showEffect:Boolean = null):void
		{
			trace("dcs----uimanager---open")
			dialog.removeSelf();
			super.open(dialog, closeOther, showEffect);
		}

		override public function doClose(dialog:Dialog):void
		{
			trace("dcs----uimanager---doClose", dialog.isModal)
			if(dialog.isModal)
			{
				this.maskLayer.removeSelf();
			}
		}
	}
}