/**This class is automatically generated by LayaAirIDE, please do not make any modifications. */
package {
	import laya.utils.ClassUtils;
	import laya.ui.View;
	import laya.webgl.WebGL;
	import game.script.DealScript;
	import game.script.PickUpScript;
	import common.ButtonRunTime;
	import game.script.EnterScript;
	import game.script.TestScript;
	/**
	 * 游戏初始化配置
	 */
	public class GameConfig {
		public static var width:int = 1140;
		public static var height:int = 855;
		public static var scaleMode:String = "showall";
		public static var screenMode:String = "horizontal";
		public static var alignV:String = "top";
		public static var alignH:String = "center";
		public static var startScene:* = "test.scene";
		public static var sceneRoot:String = "";
		public static var debug:Boolean = false;
		public static var stat:Boolean = false;
		public static var physicsDebug:Boolean = false;
		public static var exportSceneToJson:Boolean = true;
		
		public static function init():void {
			//注册Script或者Runtime引用
			var reg:Function = ClassUtils.regClass;
			reg("game.script.DealScript",DealScript);
			reg("game.script.PickUpScript",PickUpScript);
			reg("common.ButtonRunTime",ButtonRunTime);
			reg("game.script.EnterScript",EnterScript);
			reg("game.script.TestScript",TestScript);
		}
		GameConfig.init();
	}
}