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
			var count:int	= roundData.count;
			var value:int 	= roundData.value;

        	AnimationManager.getInstance().playGame(type, count);
			AudioManager.getInstance().playGame(type, count, value);
        }
	}
}