package game.control {
	
	import common.GameConstants;

	public class Action {
		public static function update(data:String):void
		{
			var uData:Object = JSON.parse(data);
			var cmd:int	= uData.cmd;
			
			switch(cmd)
			{
				case GameConstants.PLAY_STATE_PREPARE:
				{
					trace(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DEAL:
				{
					trace(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_SNATCH:
				{
					trace(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_CARDS:
				{
					trace(uData.msg);					
					break;
				}
				case GameConstants.PLAY_STATE_DOUBLE:
				{
					trace(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_PLAY:
				{
					trace(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_OVER:
				{
					trace(uData.msg);
					break;
				}				
				default:
				{
					trace("error-----------error")
					break;
				}
			}
		}
	}
}