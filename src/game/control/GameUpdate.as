package game.control {
	
	public class GameUpdate {
		public static function update(data:String):void
		{
			var uData:Object = JSON.parse(data);
			var cmd:int	= uData.cmd;
			
		}
	}
}