package game.manager {
	
	import common.GameConstants;
	import laya.media.webaudio.WebAudioSoundChannel;
	import laya.media.SoundManager;

	public final class AudioManager{
		private static var _instance:AudioManager = new AudioManager();

		private var resIsLoaded:Boolean = false;
		
		public function AudioManager(){
			if (_instance == null) {
				this.loadRes();
            }else{
                 throw new Error("只能用getInstance()来获取实例!");
			}
		}

		public static function getInstance():AudioManager
		{
            return _instance;
		}

		private function loadRes():void
		{
			SoundManager.addChannel(new WebAudioSoundChannel());
			SoundManager.addChannel(new WebAudioSoundChannel());
			SoundManager.addChannel(new WebAudioSoundChannel());
			SoundManager.playMusic("sound/music/background.mp3");
		}

		public function playGame(type:int, value:int = 0):void
		{
			var url:String = null;

			switch(type)
			{
				case GameConstants.POKER_TYPE_ONE:
				{
					url = "sound/effect/game/female_" + (value - 1) + ".mp3";
					break;
				}
				case GameConstants.POKER_TYPE_TWO:
				{
					url = "sound/effect/game/female_pair" + (value - 1) + ".mp3";
					break;
				}
				case GameConstants.POKER_TYPE_THREE:
				{
					url = "sound/effect/game/female_three_one.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_BOMB:
				{
					url = "sound/effect/game/female_bomb.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_KING:
				{
					url = "sound/effect/game/female_rocket.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_1STRAIGHT:
				{
					url = "sound/effect/game/female_shunzi.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_2STRAIGHT:
				{
					url = "sound/effect/game/female_continuous_pair.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT:
				{
					url = "sound/effect/game/female_airplane.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_3WITH1:
				{
					url = "sound/effect/game/female_airplane_with_wing.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_3WITH2:
				{
					url = "sound/effect/game/female_airplane_with_wing.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_4WITH21:
				{
					url = "sound/effect/game/female_four_with_two.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_4WITH22:
				{
					url = "sound/effect/game/female_four_with_two_pair.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_NO:
				{
					url = "sound/effect/game/female_no.mp3";
					break;
				}
			}

			if(url != null)
			{
				SoundManager.playSound(url, 1);
			}
		}
	}
}