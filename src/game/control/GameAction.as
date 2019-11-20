package game.control {
	
	import common.GameConstants;
	import common.GameEvent;
	import game.utils.TypeCheck;

	public class GameAction {
        // 轮转时数据
        private static var _roundData:Object = new Object();
        // 抢地主数据
        private static var _snatchData:Object = new Object();

        public static function setOwnerIdx(idx:int):void
        {
            _roundData.idx = idx;
            if(idx <= 3)
            {
                _snatchData.mask[idx - 1] = 1;
            }
        }

        public static function incSnatchCount():void
        {
            _snatchData.count++;
        }

        public static function nextCanSnatch(idx:int):Boolean
        {
            var next_idx:int = idx % 3;
            if(_snatchData.count > 1 && _snatchData.mask[next_idx] == 0)
            {
                return false;
            }
            return true;
        }

        public static function get roundData():Object
        {
        	return _roundData;
        }

        public static function gamePrepare():void
        {
            _roundData.idx = 0;
            _roundData.type = 0;
            _roundData.value = 0;
            _roundData.count = 0;

            _snatchData.count = 0;
            _snatchData.mask = [0,0,0];
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