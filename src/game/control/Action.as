package game.control {
	
	import common.GameConstants;
	import laya.display.Scene;
	import laya.display.Node;
	import common.GameEvent;

	public class Action {
		public static function event(names:Array, type:String, data:* = null):void
		{
			var gameNode:Node = Scene.root.getChildByName("gameScene");
			if(gameNode)
			{
				var childNode:Node = null;
				var parentNode:Node = gameNode;
				for(var i:int = 0;i < names.length; i++)
				{
					childNode 	= parentNode.getChildByName(names[i]);
					parentNode 	= childNode;
				}
				if(childNode)
				{
					childNode.event(type, data);
				}
			}
		}

		public static function doPrepare(msg:*):void
		{			
			event(["dealPosition"], GameEvent.EVENT_GAME_PREPARE)
			event(["Layer1","myList"], GameEvent.EVENT_GAME_PREPARE)
			event(["Layer2"], GameEvent.EVENT_GAME_PREPARE)
		}

		public static function doDeal(msg:*):void
		{
			event(["dealPosition"], GameEvent.EVENT_GAME_DEAL)
			event(["Layer1","myList"], GameEvent.EVENT_GAME_DEAL, msg)
		}

		public static function doSnatch(msg:*):void
		{
			event(["Layer2"], GameEvent.EVENT_GAME_SNATCH)			
		}

		public static function doBottom(msg:*):void
		{
			
		}

		public static function doDouble(msg:*):void
		{
			event(["Layer2"], GameEvent.EVENT_GAME_DOUBLE)
		}

		public static function doPlay(msg:*):void
		{
			event(["Layer2"], GameEvent.EVENT_GAME_PLAY)
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