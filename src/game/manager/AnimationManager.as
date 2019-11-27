package game.manager {
	
	import laya.display.Sprite;
	import laya.display.Node;
	import laya.display.Scene;
	import com.utils.Dictionary;
	import common.GameConstants;
	import laya.display.Animation;
	import laya.utils.Handler;

	public final class AnimationManager{
		private static var _instance:AnimationManager = new AnimationManager();

		private var gameAnimation:Sprite = null;
		private var cacheMap:Dictionary = new Dictionary();
		private var resIsLoaded:Boolean = false;
		
		public function AnimationManager(){
			if (_instance == null) {
				this.loadRes();
            }else{
                 throw new Error("只能用getInstance()来获取实例!");
			}
		}

		public static function getInstance():AnimationManager
		{
            return _instance;
		}

		public static function init():AnimationManager
		{
			return _instance;
		}

		private function loadRes():void
		{
			Laya.loader.load("res/atlas/ani.atlas", new Handler(this, onLoaded));
		}

		private function onLoaded():void
		{
			resIsLoaded = true;
		}

		private function extractMount():void
		{
			if(gameAnimation == null)
			{
				var gameNode:Node = Scene.root.getChildByName("gameScene");
				if(gameNode != null)
				{
					gameAnimation = gameNode.getChildByName("Animation") as Sprite;
				}
			}
		}

		private function checkRes():void
		{
			if(resIsLoaded)
			{
				this.extractMount();
			}else
			{
				this.loadRes();
			}
		}

		public function gamePlay(type:int, count:int):void
		{
			this.checkRes();
			if(this.gameAnimation)
			{
				var name:String = null;
				var playName:String = "";

				switch(type)
				{
					case GameConstants.POKER_TYPE_BOMB:
					{
						name = "ani/bomb.ani";
						break;
					}
					case GameConstants.POKER_TYPE_KING:
					{
						name = "ani/roket.ani";
						break;
					}
					case GameConstants.POKER_TYPE_2STRAIGHT:
					{
						name = "ani/plane.ani";
						playName = "liandui";
						break;
					}
					case GameConstants.POKER_TYPE_3WITH1:
					case GameConstants.POKER_TYPE_3WITH2:
					{
						if(count > 1)
						{
							name = "ani/plane.ani";
							playName = "fiji";
						}
						break;
					}
				}

				if(name != null)
				{
					var ti:Animation = this.cacheMap.get(name);
					if(ti == null)
					{
						ti = new Animation();
						ti.loadAnimation(name);
						this.gameAnimation.addChild(ti);
						this.cacheMap.set(name, ti);
					}
					
					ti.play(0, false, playName);
				}
			}
		}
	}
}