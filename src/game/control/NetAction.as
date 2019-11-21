package game.control {
	
	import common.GameConstants;
	import common.GameEvent;

	public class NetAction {
		// 地主索引
        private static var _ownerIdx:int = 0;        
		// 我的索引
		private static var _mineIdx:int = 0;
		// 右边索引
		private static var _rightIdx:int = 0;

		public static function set ownerIdx(idx:int):void
        {
        	_ownerIdx = idx;
			GameAction.setOwnerIdx(idx);
        }

        public static function haveOwner():Boolean
        {
            return _ownerIdx > 0;
        }

        public static function ownerIsMine():Boolean
        {
            return NetAction.idxIsMine(_ownerIdx);
        }

        public static function ownerIsRight():Boolean
        {
            return NetAction.idxIsRight(_ownerIdx);
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

		public static function doPrepare(data:*):void
		{			
			_mineIdx = data.idx;
			_rightIdx = (_mineIdx % 3) + 1;
			GameAction.gamePrepare();
			BaseAction.event(["Deal"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Bottom","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Surface"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Mark"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Mark", "clock"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","mineList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","leftList"], GameEvent.EVENT_GAME_PREPARE);
			BaseAction.event(["Layer3","rightList"], GameEvent.EVENT_GAME_PREPARE);			
		}

		public static function doDeal(data:*):void
		{
			BaseAction.event(["Deal"], GameEvent.EVENT_GAME_DEAL);
			BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_DEAL, data);
		}

		public static function doSnatch(data:* = null):void
		{
			if(data == null)
			{
				BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_SNATCH);
			}else
			{
				GameAction.incSnatchCount();
				BaseAction.event(["Mark"], GameEvent.EVENT_GAME_SNATCH, data);
				BaseAction.event(["Mark","clock"], GameEvent.EVENT_GAME_SNATCH, data);
				if(data.msg == 1)
				{
					ownerIdx = data.idx;
				}
			}
		}

		public static function doBottom(data:* = null):void
		{
			if(data != null)
			{
				var idx:int = data.idx;
				
				BaseAction.event(["Deal"], GameEvent.EVENT_GAME_BOTTOM);
				BaseAction.event(["Mark"], GameEvent.EVENT_GAME_BOTTOM);
				BaseAction.event(["Surface"], GameEvent.EVENT_GAME_BOTTOM);
				BaseAction.event(["Mark","clock"], GameEvent.EVENT_GAME_BOTTOM, idx);
				BaseAction.event(["Bottom","myList"], GameEvent.EVENT_GAME_BOTTOM, data.msg);
				if(idxIsMine(idx))
				{
					BaseAction.event(["Layer1","myList"], GameEvent.EVENT_GAME_BOTTOM, data.msg);
				}
			}
		}

		public static function doPlay(data:* = null):void
		{
			BaseAction.event(["Mark"], GameEvent.EVENT_GAME_PLAY, data);
			BaseAction.event(["Layer2"], GameEvent.EVENT_GAME_PLAY, data);
			BaseAction.event(["Mark", "clock"], GameEvent.EVENT_GAME_PLAY, data);
		}

		public static function doOver(data:* = null):void
		{
			BaseAction.event(["Surface"], GameEvent.EVENT_GAME_OVER);
			BaseAction.event(["Mark"], GameEvent.EVENT_GAME_OVER);
			BaseAction.event(["Mark","clock"], GameEvent.EVENT_GAME_OVER);
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