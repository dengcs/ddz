package game.control {
	
	import common.GameConstants;
	import common.GameEvent;
	import game.utils.TypeCheck;

	public class GameAction {
        private static var _ownerIdx:int = 0;
        private static var _roundData:Object = new Object();        

        public static function set ownerIdx(value:int):void
        {
        	_ownerIdx = value;
            _roundData.idx = value;
        }

        public static function haveOwner():Boolean
        {
            return _ownerIdx > 0;
        }

        public static function get roundData():Object
        {
        	return _roundData;
        }

        public static function init():void
        {
            _roundData.idx = 0;
            _roundData.type = 0;
            _roundData.value = 0;
            _roundData.count = 0;
        }

        private static function saveRoundData(data:Object):void
        {
            _roundData.idx = data.idx;
            var typeData:Object = TypeCheck.test_type(Vector.<int>(data.msg));
            if(typeData != null)
            {
                _roundData.type = typeData.type;
                _roundData.value = typeData.value;
                _roundData.count = typeData.count;
            }
        }

        // 收到服务器返回的出牌数据
        public static function onPlayData(msgData:Object):void
        {
            var curIdx:int = msgData.idx;
            if(NetAction.idxIsMine(curIdx))
            {
                BaseAction.event(["Layer3","rightList"], GameEvent.EVENT_GAME_TURN);
                if(msgData.msg is Array)
                {                                                            
                    BaseAction.event(["Layer3","mineList"], GameEvent.EVENT_GAME_PLAY, msgData.msg);
                }
            }else if(NetAction.idxIsRight(curIdx))
            {
                BaseAction.event(["Layer3","leftList"], GameEvent.EVENT_GAME_TURN);
                if(msgData.msg is Array)
                {
                    BaseAction.event(["Layer3","rightList"], GameEvent.EVENT_GAME_PLAY, msgData.msg);
                }
            }else
            {
                BaseAction.event(["Layer3","mineList"], GameEvent.EVENT_GAME_TURN);
                if(msgData.msg is Array)
                {
                    BaseAction.event(["Layer3","leftList"], GameEvent.EVENT_GAME_PLAY, msgData.msg);
                }
            }

            if(msgData.msg is Array)
            {
                saveRoundData(msgData);
            }
        }

        // 游戏开始接收服务器返回的玩家数据
        public static function onGameStart(msgData:*):void
        {
            BaseAction.event(["Surface"], GameEvent.EVENT_GAME_START, msgData);
        }
	}
}