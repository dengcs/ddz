package game.manager {
	
	import laya.display.Sprite;
	import laya.display.Node;
	import laya.display.Scene;
	import com.utils.Dictionary;
	import common.GameConstants;
	import laya.display.Animation;
	import laya.utils.Handler;
	import laya.net.Loader;
	import laya.events.Event;
	import common.GameFunctions;

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
				this.loadAni();
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
			var imgArray:Array = [];
			imgArray.push("ani/plane/plane_body_blur.png");
			Laya.loader.load(imgArray, new Handler(this, onImgLoaded), null, Loader.IMAGE);			
		}

		private function loadRes():void
		{			
			var atlasArray:Array = [];
			atlasArray.push("res/atlas/ani/bomb.atlas");
			atlasArray.push("res/atlas/ani/plane.atlas");
			atlasArray.push("res/atlas/ani/rocket.atlas");
			atlasArray.push("res/atlas/ani/shunzi.atlas");
			atlasArray.push("res/atlas/ani/settle.atlas");
			Laya.loader.load(atlasArray, new Handler(this, onResLoaded), null, Loader.ATLAS);
		}

		private function loadAni():void
		{
			// Animation.createFrames(["poker/poker_bg.png"], "ani/deal.ani#ani1");
			// Animation.createFrames(["poker/poker_bg.png"], "ani/deal.ani#ani2");
			// Animation.createFrames(["poker/poker_bg.png"], "ani/deal.ani#ani3");
			// Animation.createFrames(["poker/poker_bg.png"], "ani/deal.ani#ani4");
			// Animation.createFrames(["poker/poker_bg.png"], "ani/deal.ani#ani5");
			// Animation.createFrames(["poker/poker_bg.png"], "ani/deal.ani#ani6");
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

		private function onLabel(lab:String = null):void
		{
			if(lab != null)
			{
				if(lab == "bomb")
				{
					AudioManager.getInstance().playAni(GameConstants.POKER_TYPE_BOMB);
				}else if(lab == "rocket")
				{
					AudioManager.getInstance().playAni(GameConstants.POKER_TYPE_KING);
				}else if(lab == "shunzi")
				{
					AudioManager.getInstance().playAni(GameConstants.POKER_TYPE_1STRAIGHT);
				}else if(lab == "plane")
				{
					AudioManager.getInstance().playAni(GameConstants.POKER_TYPE_3STRAIGHT);
				}else if(lab == "win")
				{
					AudioManager.getInstance().playAni(GameConstants.POKER_TYPE_WIN);
				}else if(lab == "fail")
				{
					AudioManager.getInstance().playAni(GameConstants.POKER_TYPE_FAIL);
				}else if(lab == "settle")
				{
					GameFunctions.control_markStart.call(null, true);
				}
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
					case GameConstants.POKER_TYPE_3STRAIGHT:
					case GameConstants.POKER_TYPE_3STRAIGHT1:
					case GameConstants.POKER_TYPE_3STRAIGHT2:
					{						
						name = "ani/plane.ani";
						break;
					}
					case GameConstants.POKER_TYPE_WIN:
					{
						name = "ani/win.ani";
						// playName = "ani1";
						break;
					}
					case GameConstants.POKER_TYPE_WIN1:
					{
						name = "ani/win.ani";
						playName = "ani2";
						break;
					}
					case GameConstants.POKER_TYPE_FAIL:
					{
						name = "ani/fail.ani";
						// playName = "ani1";
						break;
					}
					case GameConstants.POKER_TYPE_FAIL1:
					{
						name = "ani/fail.ani";
						playName = "ani2";
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
						ti.on(Event.LABEL, this, onLabel);
						this.gameAnimation.addChild(ti);
						this.cacheMap.set(name, ti);
					}
					
					ti.play(0, false, playName);					
				}
			}
		}

		public function playDeal(type:int):void
		{
			this.checkRes();
			if(this.gameAnimation)
			{
				var name:String = null;
				var playName:String = "";

				switch(type)
				{
					case GameConstants.POKER_TYPE_DEAL1:
					{
						name = "ani/deal.ani";
						playName = "ani1";
						break;
					}
					case GameConstants.POKER_TYPE_DEAL2:
					{
						name = "ani/deal.ani";
						playName = "ani2";
						break;
					}
					case GameConstants.POKER_TYPE_DEAL3:
					{
						name = "ani/deal.ani";
						playName = "ani3";
						break;
					}
					case GameConstants.POKER_TYPE_DEAL4:
					{
						name = "ani/deal.ani";
						playName = "ani4";
						break;
					}
					case GameConstants.POKER_TYPE_DEAL5:
					{
						name = "ani/deal.ani";
						playName = "ani5";
						break;
					}
					case GameConstants.POKER_TYPE_DEAL6:
					{
						name = "ani/deal.ani";
						playName = "ani6";
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