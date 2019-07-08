package game.base {	
	import com.utils.Dictionary;

	public class HandlerBase {
		private var _dataDic:Dictionary = new Dictionary();

		public function get dataDic():Dictionary
		{
			return _dataDic;
		}

		public function get(key:*):* 
		{
			return dataDic.get(key);
		}

		public function set(key:*, value:*):void 
		{
			dataDic.set(key, value)
		}

		public function remove(key:*):Boolean
		{
			return dataDic.remove(key);
		}
	}
}