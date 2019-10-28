package game.control {
	
	import common.GameConstants;
	import laya.display.Scene;
	import laya.display.Node;
	import common.GameEvent;

	public class BaseAction {
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
	}
}