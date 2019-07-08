package common
{
	/**
	 * ...
	 * @author
	 */
	public final class GameEvent{
		public static const OPEN_MAIN_VIEW:String = "OPEN_MAIN_VIEW";
		public static const OPEN_GAME_VIEW:String = "OPEN_GAME_VIEW";

		public static const EVENT_TO_TABLE:String 	= "EVENT_TO_TABLE"; //
		public static const EVENT_TO_POKER:String 	= "EVENT_TO_POKER"; //

		public static const GAME_PREPARE_ALL:String 	= "GAME_PREPARE_ALL"; //

		public static const GAME_DEAL_POKER:String 	= "GAME_DEAL_POKER"; // 接收发牌
		public static const GAME_CARDS_POKER:String = "GAME_CARDS_POKER"; // 获得底牌
		public static const GAME_PLAY_POKER:String 	= "GAME_PLAY_POKER"; // 出牌

		public static const GAME_DEAL_TABLE:String 		= "GAME_DEAL_TABLE"; //
		public static const GAME_SNATCH_TABLE:String 	= "GAME_SNATCH_TABLE"; //
		public static const GAME_DOUBLE_TABLE:String 	= "GAME_DOUBLE_TABLE"; //
		public static const GAME_PLAY_TABLE:String 		= "GAME_PLAY_TABLE"; //
		public static const GAME_POST_CARDS:String 		= "GAME_POST_CARDS"; //
	}

}