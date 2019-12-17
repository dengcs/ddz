package common {	
	import game.manager.AnimationManager;
	import game.manager.AudioManager;

	public final class GameManager {
		public static function init():void
		{
			AnimationManager.getInstance();
			AudioManager.getInstance();
		}

        public static function playGame(type:int, value:int, yasi:Boolean):void
		{
			AudioManager.getInstance().playGame(type, value, yasi);
        	AnimationManager.getInstance().playGame(type);
        }

		public static function playDeal(type:int):void
		{
			AudioManager.getInstance().playAni(type);
			AnimationManager.getInstance().playDeal(type);
		}
	}
}