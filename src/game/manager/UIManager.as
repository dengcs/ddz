package game.manager {
	
	import laya.display.Sprite;
	import laya.events.Event;
	import game.base.UIBase;
	import common.UIEvent;

	public final class UIManager extends UIBase{
		private static var _instance:UIManager = new UIManager();
		
		private var zIndex:Number = 1;

		public function UIManager(){
			if (_instance == null) {
				this.on(Event.ADDED, this, onAddedToStage);
            }else{
                 throw new Error("只能用getInstance()来获取实例!");
			}
		}

		public static function getInstance():UIManager
		{
            return _instance;
		}

		private function onAddedToStage(event:Event):void
		{
			this.off(Event.ADDED, this, onAddedToStage);
			
			// Initialize views.
			super.initUIs();
		}

		public function getUI(name:String):Sprite
		{
			return uiDic.get(name);
		}

		// 是否已经添加到列表
		public function added(name:String):Boolean
		{
			return uiDic.get(name) != null;
		}

		// 是否已经显示到舞台
		public function showed(name:String):Boolean
		{
			var child:Sprite = this.getChildByName(name) as Sprite;

			if(child)
			{
				return child.visible == true
			}

			return false
		}

		public function showUI(name:String, params:* = null):void
		{
			var ui:Sprite = uiDic.get(name);
			if(ui)
			{
				ui.event(UIEvent.UI_EVENT_SHOW, params);
				if(this.getChildByName(name) == null)
				{
					this.addChild(ui);
				}
				ui.visible = true;
				ui.zOrder = zIndex++;
				this.updateZOrder()
			}
		}

		public function hideUI(name:String, params:* = null):void
		{
			var ui:Sprite = uiDic.get(name);
			if(ui)
			{
				ui.event(UIEvent.UI_EVENT_HIDE, params);
				ui.visible = false;
			}
		}

		public function destroyUI(name:String, params:* = null, destroyChild:Boolean = true):void
		{
			var ui:Sprite = uiDic.get(name);
			if(ui)
			{
				ui.event(UIEvent.UI_EVENT_DESTROY, params);
				ui.destroy(destroyChild);
			}
		}

		public function eventUI(name:String, type:String, params:* = null):void
		{
			var ui:Sprite = uiDic.get(name);
			if(ui)
			{
				ui.event(type, params);
			}
		}
	}
}