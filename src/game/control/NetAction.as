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

		public static function idxIsMine(idx:int):Boolean
		{
			return idx == _mineIdx;
		}

		public static function idxIsRight(idx:int):Boolean
		{
			return idx == _rightIdx;
		}

		public static function doPrepare(msg:*):void
		{			
			_mineIdx = msg.idx;
			_rightIdx = (_mineIdx % 3) + 1
			GameAction.init();
			BaseAction.event(["Deal"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Bottom","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Surface"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Mark"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","mineList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","leftList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","rightList"], GameEvent.EVENT_GAME_PREPARE);			
		}

		public static function doDeal(msg:*):void
		{
			BaseAction.event(["Deal"], GameEvent.EVENT_GAME_DEAL);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_DEAL, msg);
		}

		public static function doSnatch(data:* = null):void
		{
			if(data == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_SNATCH);
			}else
			{
				BaseAction.event(["Mark"], GameEvent.EVENT_GAME_SNATCH, data);
				if(data.msg == 1)
				{
					GameAction.ownerIdx = data.idx;
				}
			}
		}

		public static function doBottom(data:* = null):void
		{
			if(data)
			{
				var idx:int = data.idx;
				if(idxIsMine(idx))
				{
					BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_BOTTOM, data.msg);
				}
				BaseAction.event(["Deal"], GameEvent.EVENT_GAME_BOTTOM);
				BaseAction.event(["Mark"], GameEvent.EVENT_GAME_BOTTOM);
				BaseAction.event(["Bottom","myList"], GameEvent.EVENT_GAME_BOTTOM, data.msg);
			}
		}

		public static function doPlay(msg:* = null):void
		{
			BaseAction.event(["Mark"], GameEvent.EVENT_GAME_PLAY, msg);
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PLAY, msg);
		}

		public static function doOver(msg:* = null):void
		{
			BaseAction.event(["Surface"], GameEvent.EVENT_GAME_OVER);
			BaseAction.event(["Mark"], GameEvent.EVENT_GAME_OVER);
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