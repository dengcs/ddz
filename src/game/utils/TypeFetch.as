package game.utils
{
	import common.GameConstants;
	import com.utils.Dictionary;

	/**
	 * ...
	 * @dengcs
	 */
	public class TypeFetch{
		public static function getCardVal(card:int):int
		{
			return Math.ceil(card/4);
		}

		public static function get_mode(cards:Vector.<int>):Dictionary
		{
			var len:int = cards.length - 1;
			var mode:Dictionary = new Dictionary();
			for(var i:int = len; i >= 0; i--)
			{
				var card:int = getCardVal(cards[i]);
				var data:Array = mode.get(card);
				if(data == null)
				{
					data = new Array();
					mode.set(card, data);
				}
				data.push(i);
			}
			return mode;
		}

		private static function loop_fetch(type:int, mode:Dictionary):Object
		{
			var retData:Object = null;

			switch(type)
			{
				case GameConstants.POKER_TYPE_3STRAIGHT2:
				{
					for(var i32:int=4; i32 >= 2; i32--)
					{
						retData = fetch_3straight2(mode, 0, i32);
						if(retData != null)
						{
							break;
						}
					}
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT1:
				{
					for(var i31:int=5; i31 >= 2; i31--)
					{
						retData = fetch_3straight1(mode, 0, i31);
						if(retData != null)
						{
							break;
						}
					}
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT:
				{
					for(var i3:int=6; i3 >= 2; i3--)
					{
						retData = fetch_3straight(mode, 0, i3);
						if(retData != null)
						{
							break;
						}
					}
					break;
				}
				case GameConstants.POKER_TYPE_2STRAIGHT:
				{
					for(var i2:int=10; i2 >= 3; i2--)
					{
						retData = fetch_2straight(mode, 0, i2);
						if(retData != null)
						{
							break;
						}
					}
					break;
				}
				case GameConstants.POKER_TYPE_1STRAIGHT:
				{
					for(var i:int=20; i >= 5; i--)
					{
						retData = fetch_1straight(mode, 0, i);
						if(retData != null)
						{
							break;
						}
					}
					break;
				}
			}

			return retData;
		}

		public static function auto_fetch(cards:Vector.<int>):Object
		{
			var retData:Object = null;
			var mode:Dictionary = get_mode(cards);

			var cardLen:int = cards.length;
			if(cardLen == 8)
			{
				retData = fetch_4with22(mode, 0);
			}else if(cardLen == 6)
			{
				retData = fetch_4with21(mode, 0);
			}else if(cardLen == 5)
			{
				retData = fetch_4with1(mode, 0);
			}else if(cardLen == 4)
			{
				retData = fetch_bomb(mode, 0);
			}else if(cardLen == 2)
			{
				retData = fetch_king(mode);
			}

			if(retData == null)
			{
				retData = loop_fetch(GameConstants.POKER_TYPE_3STRAIGHT2, mode);
				if(retData == null)
				{
					retData = loop_fetch(GameConstants.POKER_TYPE_3STRAIGHT1, mode);
					if(retData == null)
					{
						retData = loop_fetch(GameConstants.POKER_TYPE_3STRAIGHT, mode);
						if(retData == null)
						{
							retData = loop_fetch(GameConstants.POKER_TYPE_2STRAIGHT, mode);
							if(retData == null)
							{
								retData = loop_fetch(GameConstants.POKER_TYPE_1STRAIGHT, mode);
								if(retData == null)
								{
									retData = fetch_3with1(mode, 0);
									if(retData == null)
									{
										retData = fetch_3with2(mode, 0);
										if(retData == null)
										{
											retData = fetch_three(mode, 0);
											if(retData == null)
											{
												retData = fetch_two(mode, 0);
												if(retData == null)
												{
													retData = fetch_one(mode, cards, 0);
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}

			return retData;
		}

		public static function fetch_type(cards:Vector.<int>, type:int, value:int = 0, count:int = 0):Object
		{
			var retData:Object = null;

			var mode:Dictionary = get_mode(cards);
			switch(type)
			{
				case GameConstants.POKER_TYPE_ONE:
				{
					retData = fetch_one(mode, cards, value);
					break;
				}
				case GameConstants.POKER_TYPE_TWO:
				{
					retData = fetch_two(mode, value);
					break;
				}
				case GameConstants.POKER_TYPE_THREE:
				{
					retData = fetch_three(mode, value);
					break;
				}
				case GameConstants.POKER_TYPE_BOMB:
				{
					retData = fetch_bomb(mode, value);
					if(retData == null)
					{
						retData = fetch_king(mode);
					}
					return retData;
				}
				case GameConstants.POKER_TYPE_KING:
				{
					return null;
				}
				case GameConstants.POKER_TYPE_1STRAIGHT:
				{
					retData = fetch_1straight(mode, value, count);
					break;
				}
				case GameConstants.POKER_TYPE_2STRAIGHT:
				{
					retData = fetch_2straight(mode, value, count);
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT:
				{
					retData = fetch_3straight(mode, value, count);
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT1:
				{
					retData = fetch_3straight1(mode, value, count);
					break;
				}
				case GameConstants.POKER_TYPE_3STRAIGHT2:
				{
					retData = fetch_3straight2(mode, value, count);
					break;
				}
				case GameConstants.POKER_TYPE_3WITH1:
				{
					retData = fetch_3with1(mode, value);
					break;
				}
				case GameConstants.POKER_TYPE_3WITH2:
				{
					retData = fetch_3with2(mode, value);
					break;
				}
				case GameConstants.POKER_TYPE_4WITH1:
				{
					retData = fetch_4with1(mode, value);
					break;
				}
				case GameConstants.POKER_TYPE_4WITH21:
				{
					retData = fetch_4with21(mode, value);
					break;
				}
				case GameConstants.POKER_TYPE_4WITH22:
				{
					retData = fetch_4with22(mode, value);
					break;				
				}
			}

			if(retData == null)
			{
				retData = fetch_bomb(mode, 0);
			}
			if(retData == null)
			{
				retData = fetch_king(mode);
			}

			return retData;
		}

		public static function fetch_one(mode:Dictionary, cards:Vector.<int>, value:int):Object
		{
			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;

			var firstVal:int = 0;
			var secondVal:int = 0;
			var thirdVal:int = 0;
			for each(var card:int in mode.keys)
			{
				var modeVals:Array = mode.get(card);
				if(card > value)
				{
					if(modeVals.length == 1)
					{
						if(card < firstVal || firstVal == 0)
						{
							firstVal = card;
						}
					}else if(modeVals.length == 2)
					{
						if(card < secondVal || secondVal == 0)
						{
							secondVal = card;
						}
					}else if(modeVals.length == 3)
					{
						if(card < thirdVal || thirdVal == 0)
						{
							thirdVal = card;
						}
					}
				}else if(value == GameConstants.POKER_VALUE_JOKER)
				{
					// 类型判断时已经把大王的牌值加1了
					if(card == GameConstants.POKER_VALUE_JOKER)
					{
						firstVal = card;
					}
				}
			}

			if(firstVal > 0)
			{
				max_value = firstVal;
			}else if(secondVal > 0)
			{
				max_value = secondVal;
			}else if(thirdVal > 0)
			{
				max_value = thirdVal;
			}

			if(max_value > 0)
			{
				indexes.push(mode.get(max_value)[0])

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_two(mode:Dictionary, value:int):Object
		{
			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;

			var firstVal:int = 0;
			var secondVal:int = 0;

			for each(var card:int in mode.keys)
			{
				var modeVals:Array = mode.get(card);
				if(card > value)
				{
					if(modeVals.length == 2)
					{
						if((firstVal == 0 || card < firstVal) && card < GameConstants.POKER_VALUE_JOKER)
						{
							firstVal = card;
						}
					}else if(modeVals.length == 3)
					{
						if(card < secondVal || secondVal == 0)
						{
							secondVal = card;
						}
					}
				}
			}

			if(firstVal > 0)
			{
				max_value = firstVal;
			}else if(secondVal > 0)
			{
				max_value = secondVal;
			}

			if(max_value > 0)
			{
				indexes.push(mode.get(max_value)[0]);
				indexes.push(mode.get(max_value)[1]);

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_three(mode:Dictionary, value:int):Object
		{
			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;

			for each(var card:int in mode.keys)
			{
				var modeVals:Array = mode.get(card);
				if(card > value)
				{
					if(modeVals.length == 3)
					{
						if(card < max_value || max_value == 0)
						{
							max_value = card;
						}
					}
				}
			}

			if(max_value > 0)
			{
				indexes.push(mode.get(max_value)[0]);
				indexes.push(mode.get(max_value)[1]);
				indexes.push(mode.get(max_value)[2]);

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_bomb(mode:Dictionary, value:int):Object
		{
			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;

			for each(var card:int in mode.keys)
			{
				var modeVals:Array = mode.get(card);
				if(card > value)
				{
					if(modeVals.length == 4)
					{
						if(card < max_value || max_value == 0)
						{
							max_value = card;
						}
					}
				}
			}

			if(max_value > 0)
			{
				indexes.push(mode.get(max_value)[0]);
				indexes.push(mode.get(max_value)[1]);
				indexes.push(mode.get(max_value)[2]);
				indexes.push(mode.get(max_value)[3]);

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_king(mode:Dictionary):Object
		{
			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;

			for each(var card:int in mode.keys)
			{
				var modeVals:Array = mode.get(card);
				if(card == GameConstants.POKER_VALUE_JOKER)
				{
					if(modeVals.length == 2)
					{						
						max_value = card;
						break;
					}
				}
			}

			if(max_value > 0)
			{
				indexes.push(mode.get(max_value)[0]);
				indexes.push(mode.get(max_value)[1]);

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_1straight(mode:Dictionary, value:int, count:int):Object
		{
			if(count < 5)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			var straightCount:int = 0;
			var first_card:int = mode.keys[0];
			for(var i:int = 0; i < mode.keys.length; i++)
			{
				var card:int = mode.keys[i];
				if(card < GameConstants.POKER_VALUE_2)
				{
					if(first_card == card)
					{
						straightCount++;
					}else{
						straightCount = 1;
					}
					first_card = card + 1;

					if(straightCount >= count)
					{
						if(card > value)
						{						
							max_value = card;
							break;
						}
					}
				}
			}

			if(max_value > 0)
			{
				for(var k:int = count; k>0; k--)
				{
					indexes.push(mode.get(max_value - k + 1)[0])
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_2straight(mode:Dictionary, value:int, count:int):Object
		{
			if(count < 3)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			var straightCount:int = 0;
			var first_card:int = mode.keys[0];
			for(var i:int = 0; i < mode.keys.length; i++)
			{
				var card:int = mode.keys[i];

				if(card < GameConstants.POKER_VALUE_2)
				{
					var length:int = mode.get(card).length;
					if(length == 2)
					{
						if(first_card == card)
						{
							straightCount++;
						}else{
							straightCount = 1;
						}
						first_card = card + 1;

						if(straightCount >= count)
						{
							if(card > value)
							{						
								max_value = card;
								break;
							}
						}
					}
				}
			}

			if(max_value > 0)
			{
				var cardVal:int = 0;
				for(var k:int = count; k>0; k--)
				{
					cardVal = max_value - k + 1;
					indexes.push(mode.get(cardVal)[0]);
					indexes.push(mode.get(cardVal)[1]);
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_3straight(mode:Dictionary, value:int, count:int):Object
		{
			if(count < 2)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			var straightCount:int = 0;
			var first_card:int = mode.keys[0];
			for(var i:int = 0; i < mode.keys.length; i++)
			{
				var card:int = mode.keys[i];
				if(card < GameConstants.POKER_VALUE_2)
				{
					var length:int = mode.get(card).length;
					if(length == 3)
					{
						if(first_card == card)
						{
							straightCount++;
						}else{
							straightCount = 1;
						}
						first_card = card + 1;

						if(straightCount >= count)
						{
							if(card > value)
							{						
								max_value = card;
								break;
							}
						}
					}
				}
			}

			if(max_value > 0)
			{
				var cardVal:int = 0;
				for(var k:int = count; k>0; k--)
				{
					cardVal = max_value - k + 1;
					indexes.push(mode.get(cardVal)[0]);
					indexes.push(mode.get(cardVal)[1]);
					indexes.push(mode.get(cardVal)[2]);
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_3straight1(mode:Dictionary, value:int, count:int):Object
		{
			if(count < 2)
			{
				return null;
			}

			var attachMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 3)
				{
					targetNum++;
				}

				if(len < 3)
				{
					attachMap.set(m, mode.get(m));
					attachNum += len
				}
			}

			if(targetNum < count)
			{
				return null;
			}
			if(attachNum < count)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			var straightCount:int = 0;
			var first_card:int = mode.keys[0];
			for each(var card:int in mode.keys)
			{
				if(count == 1 || card < GameConstants.POKER_VALUE_2)
				{
					var length:int = mode.get(card).length;
					if(length == 3)
					{
						if(first_card == card)
						{
							straightCount++;
						}else{
							straightCount = 1;
						}
						first_card = card + 1;

						if(straightCount >= count)
						{
							if(card > value)
							{						
								max_value = card;
								break;
							}
						}
					}
				}
			}

			if(max_value > 0)
			{
				var cardVal:int = 0;
				for(var k:int = count; k>0; k--)
				{
					cardVal = max_value - k + 1;
					indexes.push(mode.get(cardVal)[0]);
					indexes.push(mode.get(cardVal)[1]);
					indexes.push(mode.get(cardVal)[2]);
				}

				var attachCount:int = 0;

				for(var n:int = 1; n < 3; n++)
				{
					for each(var a:int in attachMap.keys)
					{
						if(attachCount >= count)
						{
							break;
						}

						if(attachMap.get(a).length == n)
						{
							for each(var b:int in attachMap.get(a))
							{
								indexes.push(b);
								attachCount++;

								if(attachCount >= count)
								{
									break;
								}
							}
						}
					}
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_3straight2(mode:Dictionary, value:int, count:int):Object
		{
			if(count < 2)
			{
				return null;
			}

			var attachMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 3)
				{
					targetNum++;
				}

				if(len == 2 && m != GameConstants.POKER_VALUE_JOKER)
				{
					attachMap.set(m, mode.get(m));
					attachNum++;
				}
			}

			if(targetNum < count)
			{
				return null;
			}

			if(attachNum < count)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			var straightCount:int = 0;
			var first_card:int = mode.keys[0];
			for each(var card:int in mode.keys)
			{
				if(count == 1 || card < GameConstants.POKER_VALUE_2)
				{
					var length:int = mode.get(card).length;
					if(length == 3)
					{
						if(first_card == card)
						{
							straightCount++;
						}else{
							straightCount = 1;
						}
						first_card = card + 1;

						if(straightCount >= count)
						{
							if(card > value)
							{						
								max_value = card;
								break;
							}
						}
					}
				}
			}

			if(max_value > 0)
			{
				var cardVal:int = 0;
				for(var k:int = count; k>0; k--)
				{
					cardVal = max_value - k + 1;
					indexes.push(mode.get(cardVal)[0]);
					indexes.push(mode.get(cardVal)[1]);
					indexes.push(mode.get(cardVal)[2]);

					attachMap.remove(cardVal);
				}

				var attachCount:int = 0;
				for each(var a:int in attachMap.keys)
				{
					indexes.push(attachMap.get(a)[0]);
					indexes.push(attachMap.get(a)[1]);
					attachCount++;					
					if(attachCount >= count)
					{
						break;
					}
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_3with1(mode:Dictionary, value:int):Object
		{
			var attachMap:Dictionary = new Dictionary();
			var targetMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 3)
				{
					targetMap.set(m, mode.get(m));
					targetNum++;
				}else
				{
					attachMap.set(m, mode.get(m));
					attachNum += len;
				}
			}

			if(targetNum < 1)
			{
				return null;
			}
			if(attachNum < 1)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			for each(var card:int in targetMap.keys)
			{
				if(card > value)
				{
					max_value = card;
					break;
				}
			}

			if(max_value > 0)
			{
				indexes.push(targetMap.get(max_value)[0]);
				indexes.push(targetMap.get(max_value)[1]);
				indexes.push(targetMap.get(max_value)[2]);

				var attachCount:int = 0;

				for(var n:int = 1; n < 2; n++)
				{
					for each(var a:int in attachMap.keys)
					{
						if(attachCount > 0)
						{
							break;
						}

						if(attachMap.get(a).length == n)
						{
							for each(var b:int in attachMap.get(a))
							{
								indexes.push(b);
								attachCount++;
								break;
							}
						}
					}
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_3with2(mode:Dictionary, value:int):Object
		{
			var attachMap:Dictionary = new Dictionary();
			var targetMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 3)
				{
					targetMap.set(m, mode.get(m));
					targetNum++;
				}else if(len == 2)
				{
					attachMap.set(m, mode.get(m));
					attachNum += len;
				}
			}

			if(targetNum < 1)
			{
				return null;
			}
			if(attachNum < 1)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			for each(var card:int in targetMap.keys)
			{
				if(card > value)
				{
					max_value = card;
					break;
				}
			}

			if(max_value > 0)
			{
				indexes.push(targetMap.get(max_value)[0]);
				indexes.push(targetMap.get(max_value)[1]);
				indexes.push(targetMap.get(max_value)[2]);

				indexes.push(attachMap.values[0][0]);
				indexes.push(attachMap.values[0][1]);

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_4with1(mode:Dictionary, value:int):Object
		{
			var attachMap:Dictionary = new Dictionary();
			var targetMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 4)
				{
					targetMap.set(m, mode.get(m));
					targetNum++;
				}else
				{
					attachMap.set(m, mode.get(m));
					attachNum += len;
				}
			}

			if(targetNum < 1)
			{
				return null;
			}
			if(attachNum < 1)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			for each(var card:int in targetMap.keys)
			{
				if(card > value)
				{
					max_value = card;
					break;
				}
			}

			if(max_value > 0)
			{
				indexes.push(targetMap.get(max_value)[0]);
				indexes.push(targetMap.get(max_value)[1]);
				indexes.push(targetMap.get(max_value)[2]);
				indexes.push(targetMap.get(max_value)[3]);

				var attachCount:int = 0;

				for(var n:int = 1; n < 4; n++)
				{
					for each(var a:int in attachMap.keys)
					{
						if(attachCount > 0)
						{
							break;
						}

						if(attachMap.get(a).length == n)
						{
							for each(var b:int in attachMap.get(a))
							{
								indexes.push(b);
								attachCount++;
								break;
							}
						}
					}
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_4with21(mode:Dictionary, value:int):Object
		{
			var attachMap:Dictionary = new Dictionary();
			var targetMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 4)
				{
					targetMap.set(m, mode.get(m));
					targetNum++;
				}else
				{
					attachMap.set(m, mode.get(m));
					attachNum += len;
				}
			}

			if(targetNum < 1)
			{
				return null;
			}
			if(attachNum < 2)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			for each(var card:int in targetMap.keys)
			{				
				if(card > value)
				{
					max_value = card;
					break;
				}
			}

			if(max_value > 0)
			{
				indexes.push(targetMap.get(max_value)[0]);
				indexes.push(targetMap.get(max_value)[1]);
				indexes.push(targetMap.get(max_value)[2]);
				indexes.push(targetMap.get(max_value)[3]);

				var attachCount:int = 0;

				for(var n:int = 1; n < 4; n++)
				{
					for each(var a:int in attachMap.keys)
					{
						if(attachCount > 1)
						{
							break;
						}

						if(attachMap.get(a).length == n)
						{
							for each(var b:int in attachMap.get(a))
							{
								indexes.push(b);
								attachCount++;

								if(attachCount > 1)
								{
									break;
								}
							}
						}
					}
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}

		public static function fetch_4with22(mode:Dictionary, value:int):Object
		{
			var attachMap:Dictionary = new Dictionary();
			var targetMap:Dictionary = new Dictionary();
			var attachNum:int = 0;
			var targetNum:int = 0;
			for each(var m:int in mode.keys)
			{
				var len:int = mode.get(m).length;

				if(len == 4)
				{
					targetMap.set(m, mode.get(m));
					targetNum++;
				}else if(len > 1 && m != GameConstants.POKER_VALUE_JOKER)
				{
					attachMap.set(m, mode.get(m));
					attachNum++;
				}
			}

			if(targetNum < 1)
			{
				return null;
			}
			if(attachNum < 2)
			{
				return null;
			}

			var retData:Object = null;
			var indexes:Array = new Array();
			var max_value:int = 0;			

			for each(var card:int in targetMap.keys)
			{				
				if(card > value)
				{
					max_value = card;
					break;
				}
			}

			if(max_value > 0)
			{
				indexes.push(targetMap.get(max_value)[0]);
				indexes.push(targetMap.get(max_value)[1]);
				indexes.push(targetMap.get(max_value)[2]);
				indexes.push(targetMap.get(max_value)[3]);

				var attachCount:int = 0;

				for(var n:int = 2; n < 4; n++)
				{
					for each(var a:int in attachMap.keys)
					{
						if(attachCount > 1)
						{
							break;
						}

						if(attachMap.get(a).length == n)
						{							
							indexes.push(attachMap.get(a)[0]);
							indexes.push(attachMap.get(a)[1]);
							attachCount++;

							if(attachCount > 1)
							{
								break;
							}
						}
					}
				}

				retData = new Object();
				retData.indexes = indexes;
				retData.max_value = max_value;
			}

			return retData;
		}
	}

}