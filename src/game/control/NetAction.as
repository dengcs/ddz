package game.control {
	
	import common.GameConstants;
	import common.GameEvent;

	public class NetAction {
		// 地主索引
        private static var _lordIdx:int = 0;        
		// 我的索引
		private static var _mineIdx:int = 0;
		// 右边索引
		private static var _rightIdx:int = 0;
		// 当前状态
		private static var _state:int = 0;

		public static function get state():int
		{
			return _state;
		}

		private static function set lordIdx(idx:int):void
        {
        	_lordIdx = idx;
			GameAction.setLordIdx(idx);
        }

        public static function haveLord():Boolean
        {
            return _lordIdx > 0;
        }

        public static function lordIsMine():Boolean
        {
            return idxIsMine(_lordIdx);
        }

        public static function lordIsRight():Boolean
        {
            return idxIsRight(_lordIdx);
        }

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

		public static function idxIsOwner(idx:int):Boolean
		{
			return idx == _lordIdx;
		}

		public static function gameIsOver():Boolean
		{
			return _state == GameConstants.PLAY_STATE_OVER || _state == 0;
		}

		public static function doPrepare(data:*):void
		{			
			_mineIdx = data.idx;
			_rightIdx = (_mineIdx % 3) + 1;
			GameAction.prepare();
			BaseAction.broadcastEvent(GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Mark", "clock"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Bottom","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["MyCard","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.broadcastEventToNode("ThrowCard", GameEvent.EVENT_GAME_PREPARE);
		}

		public static function doDeal(data:*):void
		{
			BaseAction.event(["Deal"], GameEvent.EVENT_GAME_DEAL);
			BaseAction.event(["MyCard","myList"], GameEvent.EVENT_GAME_DEAL, data);
		}

		public static function doSnatch(data:* = null):void
		{
			if(data == null)
			{
				BaseAction.event(["Control"], GameEvent.EVENT_GAME_SNATCH);
			}else
			{
				GameAction.incSnatchCount(data.msg);
				BaseAction.broadcastEventToNode("Mark", GameEvent.EVENT_GAME_SNATCH, data);
				if(data.msg == 1)
				{
					lordIdx = data.idx;
				}
			}
		}		

		public static function doPlay(data:* = null):void
		{
			BaseAction.broadcastEventToNode("Mark", GameEvent.EVENT_GAME_PLAY, data);
			BaseAction.event(["Control"], GameEvent.EVENT_GAME_PLAY, data);
			BaseAction.event(["MyCard","myList"], GameEvent.EVENT_GAME_PLAY, data);
		}

		public static function doOver(data:* = null):void
		{
			BaseAction.broadcastEventToNode("Mark", GameEvent.EVENT_GAME_OVER, data);
		}

		public static function doBottomNotify(data:* = null):void
		{
			if(data != null)
			{
				var idx:int = data.idx;
				
				BaseAction.broadcastEvent(GameEvent.EVENT_BOTTOM_NOTIFY);
				BaseAction.event(["Mark","clock"], GameEvent.EVENT_BOTTOM_NOTIFY, idx);
				BaseAction.event(["Bottom","myList"], GameEvent.EVENT_BOTTOM_NOTIFY, data.msg);
				if(idxIsMine(idx))
				{
					BaseAction.event(["MyCard","myList"], GameEvent.EVENT_BOTTOM_NOTIFY, data.msg);
				}
			}
		}

		public static function doOverNotify(data:* = null):void
		{
			if(data is Array)
			{
				BaseAction.broadcastEventToNode("ThrowCard", GameEvent.EVENT_OVER_NOTIFY, data);
			}
		}

		public static function doDoubleNotify(data:* = null):void
		{
			if(data != null)
			{
				BaseAction.broadcastEvent(GameEvent.EVENT_DOUBLE_NOTIFY, data);
			}
		}

		public static function update(data:String):void
		{
			var uData:Object = JSON.parse(data);
			var cmd:int	= uData.cmd;
			
			switch(cmd)
			{
				case GameConstants.PLAY_STATE_PREPARE:
				{
					_state = GameConstants.PLAY_STATE_PREPARE;
					trace("NetAction---prepare", uData.msg);
					doPrepare(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DEAL:
				{
					_state = GameConstants.PLAY_STATE_DEAL;
					trace("NetAction---deal", uData.msg);
					doDeal(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_SNATCH:
				{
					_state = GameConstants.PLAY_STATE_SNATCH;
					trace("NetAction---snatch", uData.msg);
					doSnatch(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_PLAY:
				{
					_state = GameConstants.PLAY_STATE_PLAY;
					trace("NetAction---play", uData.msg);
					doPlay(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_OVER:
				{
					_state = GameConstants.PLAY_STATE_OVER;
					trace("NetAction---over", uData.msg);
					doOver(uData.msg);
					break;
				}				
				case GameConstants.PLAY_NOTIFY_BOTTOM:
				{
					trace("NetAction---bottomNotify", uData.msg);
					doBottomNotify(uData.msg);
					break;
				}				
				case GameConstants.PLAY_NOTIFY_OVER:
				{
					trace("NetAction---overNotify", uData.msg);
					doOverNotify(uData.msg);
					break;
				}
				case GameConstants.PLAY_NOTIFY_DOUBLE:
				{
					trace("NetAction---doubleNotify", uData.msg);
					doDoubleNotify(uData.msg);
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