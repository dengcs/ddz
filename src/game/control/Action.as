package game.control {
	
	import common.GameConstants;
	import laya.display.Scene;
	import laya.display.Node;
	import common.GameEvent;

	public class Action {
		public static function event(name:String, type:String, data:* = null):void
		{
			var gameNode:Node = Scene.root.getChildByName("gameScene");
			if(gameNode)
			{
				var childNode:Node = gameNode.getChildByName(name);
				if(childNode)
				{
					childNode.event(type, data);
				}
			}
		}

		public static function doPrepare(msg:*):void
		{			
			event("dealPoker", GameEvent.EVENT_GAME_PREPARE)
		}

		public static function doDeal(msg:*):void
		{
			event("dealPoker", GameEvent.EVENT_GAME_DEAL)
		}

		public static function doSnatch(msg:*):void
		{
			
		}

		public static function doBottom(msg:*):void
		{
			
		}

		public static function doDouble(msg:*):void
		{
			
		}

		public static function doPlay(msg:*):void
		{
			
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
					trace("prepare", uData.msg);
					doPrepare(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DEAL:
				{
					trace("deal", uData.msg);
					doDeal(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_SNATCH:
				{
					trace("snatch", uData.msg);
					doSnatch(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_BOTTOM:
				{
					trace("bottom", uData.msg);
					doBottom(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_DOUBLE:
				{
					trace("double", uData.msg);
					doDouble(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_PLAY:
				{
					trace("play", uData.msg);
					doPlay(uData.msg);
					break;
				}
				case GameConstants.PLAY_STATE_OVER:
				{
					trace("over", uData.msg);
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