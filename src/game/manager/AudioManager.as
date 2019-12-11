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
			SoundManager.autoReleaseSound = false;
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
				case GameConstants.POKER_TYPE_3STRAIGHT1:
				{
					url = "sound/effect/game/female_airplane_with_wing.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT2:
				{
					url = "sound/effect/game/female_airplane_with_wing.mp3";
					break;
				}
				
				case GameConstants.POKER_TYPE_3WITH1:
				{
					url = "sound/effect/game/female_three_with_one.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_3WITH2:
				{
					url = "sound/effect/game/female_three_with_one_pair.mp3";
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

		public function playAni(type:int):void
		{
			var url:String = null;

			switch(type)
			{				
				case GameConstants.POKER_TYPE_BOMB:
				{
					url = "sound/effect/game/ani_boom.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_KING:
				{
					url = "sound/effect/game/ani_rocket.mp3";
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT1:
				case GameConstants.POKER_TYPE_3STRAIGHT2:
				{						
					url = "sound/effect/game/ani_plane.mp3";
					break;
				}
			}

			if(url != null)
			{
				SoundManager.playSound(url, 1);
			}
		}

		public function playOther(type:int):void
		{
			var url:String = null;

			switch(type)
			{				
				case GameConstants.SOUND_SNATCH_YES:
				{
					url = "sound/effect/game/female_callLord.mp3";
					break;
				}
				case GameConstants.SOUND_SNATCH_NO:
				{
					url = "sound/effect/game/female_callNo.mp3";
					break;
				}
				case GameConstants.SOUND_SNATCH_YES1:
				{
					url = "sound/effect/game/female_grabLord.mp3";
					break;
				}
				case GameConstants.SOUND_SNATCH_NO1:
				{						
					url = "sound/effect/game/female_grabNo.mp3";
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