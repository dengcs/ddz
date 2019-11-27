package common {	
	import game.manager.AnimationManager;
	import game.manager.AudioManager;

	public final class GameManager {
		public static function init():void
		{
			AnimationManager.getInstance();
			AudioManager.getInstance();
		}

        public static function playGame(roundData:Object):void
		{
			var type:int 	= roundData.type;
			var value:int 	= roundData.value;

        	AnimationManager.getInstance().playGame(type);
			AudioManager.getInstance().playGame(type, value);
        }
	}
}