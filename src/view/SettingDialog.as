package view {

	import ui.dialog.SettingUI;
	import laya.events.Event;
	import laya.media.SoundManager;

	public class SettingDialog extends SettingUI{

		override public function onAwake():void
		{
			this.cbSound.on(Event.CHANGE, this, onSoundChange);
			this.cbMusic.on(Event.CHANGE, this, onMusicChange);					
		}
		
		override public function onEnable():void
		{
			this.cbSound.selected = true;
			this.cbMusic.selected = true;
		}

		override public function onClosed(type:String = null):void
		{
			trace("SettingDialog----onClosed")
		}

		private function onSoundChange():void
		{
			if(this.cbSound.selected)
			{
				SoundManager.setSoundVolume(1);
			}else
			{
				SoundManager.setSoundVolume(0);
			}
		}

		private function onMusicChange():void
		{
			if(this.cbMusic.selected)
			{
				SoundManager.setMusicVolume(1);
			}else
			{
				SoundManager.setMusicVolume(0);
			}
		}
    }
}