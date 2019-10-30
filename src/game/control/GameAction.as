package game.control {
	
	import common.GameConstants;
	import common.GameEvent;

	public class GameAction {
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
        }
	}
}