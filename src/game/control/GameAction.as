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

        public static function onPlayData(msgData:Object):void
        {
            var curIdx:int = msgData.idx;
            if(curIdx == NetAction.mineIdx)
            {
                BaseAction.event(["Layer3","rightList"], GameEvent.EVENT_GAME_TURN);
                if(msgData.msg is Array)
                {                                                            
                    BaseAction.event(["Layer3","mineList"], GameEvent.EVENT_GAME_PLAY, msgData.msg);
                }
            }else if(curIdx == NetAction.rightIdx)
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
	}
}