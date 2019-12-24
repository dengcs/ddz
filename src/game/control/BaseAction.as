package game.control {
	
	import common.GameConstants;
	import laya.display.Scene;
	import laya.display.Node;
	import common.GameEvent;

	public class BaseAction {
		public static function event(names:Array, type:String, data:* = null):void
		{
			var gameNode:Node = Scene.root.getChildByName("gameScene");
			if(gameNode != null)
			{
				var childNode:Node = null;
				var parentNode:Node = gameNode;
				for(var i:int = 0;i < names.length; i++)
				{
					childNode 	= parentNode.getChildByName(names[i]);
					parentNode 	= childNode;
				}
				if(childNode != null)
				{
					childNode.event(type, data);
				}
			}
		}

		// 广播事件到子节点
		public static function broadcastEvent(type:String, data:* = null):void
		{
			var gameNode:Node = Scene.root.getChildByName("gameScene");
			if(gameNode != null)
			{
				var count:int = gameNode.numChildren;
				for(var i:int = 0; i < count; i++)
				{
					var childNode:Node = gameNode.getChildAt(i);
					childNode.event(type, data);
				}
			}
		}

		// 某节点广播事件到子节点
		public static function broadcastEventToNode(name:String, type:String, data:* = null, exclude_self:Boolean = false):void
		{
			var gameNode:Node = Scene.root.getChildByName("gameScene");
			if(gameNode != null)
			{
				var parentNode:Node 	= gameNode.getChildByName(name);
				if(parentNode != null)
				{
					if(exclude_self == false)
					{
						parentNode.event(type, data);
					}
					var count:int = parentNode.numChildren;
					for(var i:int = 0; i < count; i++)
					{
						var childNode:Node = parentNode.getChildAt(i);
						childNode.event(type, data);
					}
				}
			}
		}
	}
}