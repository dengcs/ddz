package game.manager {
	
	import laya.display.Sprite;
	import laya.display.Node;
	import laya.display.Scene;
	import com.utils.Dictionary;
	import common.GameConstants;
	import laya.display.Animation;
	import laya.utils.Handler;
	import laya.net.Loader;

	public final class AnimationManager{
		private static var _instance:AnimationManager = new AnimationManager();

		private var gameAnimation:Sprite = null;
		private var cacheMap:Dictionary = new Dictionary();
		private var resIsLoaded:Boolean = false;
		private var imgIsLoaded:Boolean = false;
		
		public function AnimationManager(){
			if (_instance == null) {
				this.loadImg();
				this.loadRes();
            }else{
                 throw new Error("只能用getInstance()来获取实例!");
			}
		}

		public static function getInstance():AnimationManager
		{
            return _instance;
		}

		private function loadImg():void
		{
			Laya.loader.load("ani/plane/plane_body_blur.png", new Handler(this, onImgLoaded), null, Loader.IMAGE);
		}

		private function loadRes():void
		{			
			var atlasArray:Array = ["res/atlas/ani/bomb.atlas","res/atlas/ani/plane.atlas","res/atlas/ani/rocket.atlas","res/atlas/ani/shunzi.atlas"];
			Laya.loader.load(atlasArray, new Handler(this, onResLoaded), null, Loader.ATLAS);
		}

		private function onResLoaded():void
		{
			resIsLoaded = true;
		}

		private function onImgLoaded():void
		{
			imgIsLoaded = true;
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

			if(imgIsLoaded == false)
			{
				this.loadImg();
			}
		}

		public function playGame(type:int):void
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
						name = "ani/rocket.ani";
						break;
					}
					case GameConstants.POKER_TYPE_1STRAIGHT:
					{
						name = "ani/shunzi.ani";
						break;
					}
					case GameConstants.POKER_TYPE_3STRAIGHT1:
					case GameConstants.POKER_TYPE_3STRAIGHT2:
					{						
						name = "ani/plane.ani";
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
					AudioManager.getInstance().playAni(type);
				}
			}
		}
	}
}