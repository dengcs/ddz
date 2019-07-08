package common
{
	import game.proto.game_update;
	import game.net.NetClient;

	/**
	 * ...
	 * @dengcs
	 */
	public class GameFunctions{
		public static function getCardVal(card:int):int
		{
			return Math.ceil(card/4);
		}

		public static function compareObjDes(a:Object, b:Object):Number
		{
			if(a.value < b.value)
			{
				return 1;
			}
			return -1;
		}

		public static function compareIntAsc(x:int, y:int):Number
		{
			if(x > y)
			{
				return 1;
			}
			return -1;
		}

		public static function notify_game_update(data:Object):void
		{
			var sendMsg:game_update = new game_update();
			sendMsg.data = JSON.stringify(data);
			NetClient.send("game_update", sendMsg);
		}

		public static function loadData(data:Array):Array
		{
			var retData:Array = new Array();

			for each(var card:int in data)
			{
				var value:int = Math.ceil(card/4);
				var color:int = ((card-1) % 4) + 1;

				var dataObj:Object = new Object();
				dataObj.value = card;

				if(card == GameConstants.JOKER_SMALL_VALUE)
				{
					dataObj.literal = "game/poker/joker_small.png";
					dataObj.scolor = "";
					dataObj.bcolor = "game/poker/big_small.png";
				}else if(card == GameConstants.JOKER_BIG_VALUE){
					dataObj.literal = "game/poker/joker_big.png";
					dataObj.scolor = "";
					dataObj.bcolor = "game/poker/big_joker.png";
				}else{
					var colorStr:String = "red";
					if(color%2 == 0)
					{
						colorStr = "black";
					}
					
					dataObj.literal = "game/poker/" + colorStr + "_" + value + ".png";
					dataObj.scolor = dataObj.bcolor = "game/poker/big_" + color + ".png";
				}
				retData.push(dataObj);
			}

			return retData;
		}
	}

}