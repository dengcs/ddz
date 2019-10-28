package game.control {
	
	import common.GameConstants;
	import laya.display.Scene;
	import laya.display.Node;
	import common.GameEvent;

	public class NetAction {
		public static function doPrepare(msg:*):void
		{			
			BaseAction.event(["dealPosition"], GameEvent.EVENT_GAME_PREPARE, msg);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_PREPARE, msg);
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PREPARE, msg);
		}

		public static function doDeal(msg:*):void
		{
			BaseAction.event(["dealPosition"], GameEvent.EVENT_GAME_DEAL);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_DEAL, msg);
		}

		public static function doSnatch(msg:*):void
		{
			if(msg == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_SNATCH);
			}
		}

		public static function doBottom(data:*):void
		{
			if(data)
			{
				BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_BOTTOM, data.msg);
			}
		}

		public static function doDouble(msg:*):void
		{
			if(msg == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_DOUBLE);
			}
		}

		public static function doPlay(msg:*):void
		{
			if(msg == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PLAY);
			}
		}

		public static function doOver(msg:*):void
		{
			
		}

		public static function update(data:String):void
		{
			var uData:Object = JSON.parse(data);
			var cmd:int	= uData.cmd;
			
			switch(cmd)
			{
				case GameConstants.PLAY_STATE_PREPARE:
				{
					trace("action---prepare", uData.msg);
					doPrepare(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DEAL:
				{
					trace("action---deal", uData.msg);
					doDeal(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_SNATCH:
				{
					trace("action---snatch", uData.msg);
					doSnatch(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_BOTTOM:
				{
					trace("action---bottom", uData.msg);
					doBottom(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DOUBLE:
				{
					trace("action---double", uData.msg);
					doDouble(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_PLAY:
				{
					trace("action---play", uData.msg);
					doPlay(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_OVER:
				{
					trace("action---over", uData.msg);
					doOver(uData.msg);
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