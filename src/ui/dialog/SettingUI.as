/**This class is automatically generated by LayaAirIDE, please do not make any modifications. */
package ui.dialog {
	import laya.ui.*;
	import laya.display.*;

	public class SettingUI extends Dialog {
		public var cbSound:CheckBox;
		public var cbMusic:CheckBox;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"Dialog","props":{"width":920,"height":438},"compId":2,"child":[{"type":"Image","props":{"y":219,"x":460,"skin":"setting/dialog.png","anchorY":0.5,"anchorX":0.5},"compId":3,"child":[{"type":"Image","props":{"y":45,"x":460,"skin":"setting/name.png","anchorY":0.5,"anchorX":0.5},"compId":4}]},{"type":"Sprite","props":{"y":119,"x":310,"width":300,"name":"content","height":200},"compId":5,"child":[{"type":"Sprite","props":{"width":300,"name":"sound"},"compId":7,"child":[{"type":"Label","props":{"y":5,"x":100,"valign":"middle","text":"音 效：","overflow":"hidden","fontSize":30,"font":"Microsoft YaHei","color":"#333333","anchorX":1,"align":"right"},"compId":8},{"type":"CheckBox","props":{"y":0,"x":164,"var":"cbSound","stateNum":3,"skin":"setting/btn_select.png"},"compId":9}]},{"type":"Sprite","props":{"y":80,"width":300,"name":"music"},"compId":10,"child":[{"type":"Label","props":{"y":5,"x":100,"valign":"middle","text":"背景音乐：","overflow":"hidden","fontSize":30,"font":"Microsoft YaHei","color":"#333333","anchorX":1,"align":"right"},"compId":11},{"type":"CheckBox","props":{"y":0,"x":164,"var":"cbMusic","skin":"setting/btn_select.png"},"compId":12}]}]},{"type":"Button","props":{"y":45,"x":870,"stateNum":2,"skin":"setting/btn_close.png","name":"close","anchorY":0.5,"anchorX":0.5},"compId":6}],"loadList":["setting/dialog.png","setting/name.png","setting/btn_select.png","setting/btn_close.png"],"loadList3D":[]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);

		}

	}
}