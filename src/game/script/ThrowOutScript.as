package game.script {
	import laya.components.Script;
	import laya.ui.List;
	import common.GameEvent;
	import laya.utils.Handler;
	import laya.ui.Box;
	import laya.display.Sprite;
	import laya.ui.Image;
	import laya.utils.Tween;
	import laya.utils.Ease;
	
	public class ThrowOutScript extends Script {
		/** @prop {name:place, tips:"0:自己;1:右边;2:左边", type:Int, default:0}*/
		public var place: int = 0;
		/** @prop {name:target, tips:"出牌目标位置", type:Number, default:0}*/
		public var target: Number = 0;
		/** @prop {name:target, tips:"出牌初始位置", type:Number, default:0}*/
		public var source: Number = 0;

		private var ownerSprite:List = null;

		private var dataArray:Array = [];

		override public function onAwake():void
		{
			this.ownerSprite = this.owner as List;			
			this.owner.on(GameEvent.EVENT_GAME_PREPARE, this, onPrepare);
		}

		override public function onDestroy():void
		{
			this.owner.offAllCaller(this);
		}

		override public function onEnable():void
		{
			this.ownerSprite.renderHandler = new Handler(this, onListRender);
		}

		private function onPrepare():void
		{
			this.dataArray = [];
			this.ownerSprite.array = [];
			this.ownerSprite.alpha = 0;
		}

		private function onListRender(cell:Box, index:int): void 
		{
			var parent:Sprite = cell.getChildAt(0) as Sprite;

			var valueImg:Image = parent.getChildByName("value") as Image;
			var typeImg1:Image = valueImg.getChildByName("type1") as Image;
			var typeImg2:Image = parent.getChildByName("type2") as Image;

			valueImg.skin 	= cell.dataSource.pValue;
			typeImg1.skin 	= cell.dataSource.pType1;
			typeImg2.skin 	= cell.dataSource.pType2;
		}

		private function onThrow(data:Array):void
		{			
			this.ownerSprite.scale(0.3, 0.3);
			this.ownerSprite.array = data;
			if(place == 0)
			{
				Tween.to(this.ownerSprite, {y:target,scaleX:0.6,scaleY:0.6,alpha:1}, 300, Ease.quadInOut);
			}else
			{
				Tween.to(this.ownerSprite, {x:target,scaleX:0.6,scaleY:0.6,alpha:1}, 300, Ease.quadInOut);
			}
		}

		private function recoverState():void
		{
			this.ownerSprite.alpha = 0;
			if(place == 0)
			{
				this.ownerSprite.y = source;
			}else
			{
				this.ownerSprite.x = source;
			}
		}
	}
}