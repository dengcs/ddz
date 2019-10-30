package game.control {
	
	import common.GameConstants;
	import common.GameEvent;

	public class NetAction {
		private static var _mineIdx:int = 0;
		private static var _rightIdx:int = 0;

		public static function get rightIdx():int
		{
			return _rightIdx;
		}

		public static function get mineIdx():int
		{
			return _mineIdx;
		}

		public static function doPrepare(msg:*):void
		{			
			_mineIdx = msg.idx;
			_rightIdx = (_mineIdx % 3) + 1
			BaseAction.event(["dealPosition"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","mineList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","leftList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","rightList"], GameEvent.EVENT_GAME_PREPARE);
		}

		public static function doDeal(msg:*):void
		{
			BaseAction.event(["dealPosition"], GameEvent.EVENT_GAME_DEAL);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_DEAL, msg);
		}

		public static function doSnatch(msg:* = null):void
		{
			if(msg == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_SNATCH);
			}
		}

		public static function doBottom(data:* = null):void
		{
			if(data)
			{
				BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_BOTTOM, data.msg);
			}
		}

		public static function doDouble(msg:* = null):void
		{
			if(msg == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_DOUBLE);
			}
		}

		public static function doPlay(msg:* = null):void
		{
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PLAY, msg);
		}

		public static function doOver(msg:* = null):void
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
					trace("NetAction---prepare", uData.msg);
					doPrepare(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DEAL:
				{
					trace("NetAction---deal", uData.msg);
					doDeal(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_SNATCH:
				{
					trace("NetAction---snatch", uData.msg);
					doSnatch(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_BOTTOM:
				{
					trace("NetAction---bottom", uData.msg);
					doBottom(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DOUBLE:
				{
					trace("NetAction---double", uData.msg);
					doDouble(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_PLAY:
				{
					trace("NetAction---play", uData.msg);
					doPlay(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_OVER:
				{
					trace("NetAction---over", uData.msg);
					doOver(uData.msg);
					break;
				}				
				default:
				{
					trace("NetAction-----------error=", cmd)
					break;
				}
			}
		}
	}
}