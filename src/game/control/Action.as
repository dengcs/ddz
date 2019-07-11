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
					trace("prepare", uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DEAL:
				{
					trace("deal", uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_SNATCH:
				{
					trace("snatch", uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_BOTTOM:
				{
					trace("bottom", uData.msg);					
					break;
				}
				case GameConstants.PLAY_STATE_DOUBLE:
				{
					trace("double", uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_PLAY:
				{
					trace("play", uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_OVER:
				{
					trace("over", uData.msg);
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