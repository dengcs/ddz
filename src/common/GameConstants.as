package common
{
	/**
	 * 常量定义
	 * @dengcs
	 */
	public class GameConstants{
		public static const JOKER_SMALL_VALUE:int 		= 53; 	// 小王
		public static const JOKER_BIG_VALUE:int 		= 54; 	// 大王

		public static const GLOBAL_DEAL_NUM:int 		= 51; 	// 发牌数量
		public static const GLOBAL_POKER_NUM:int 		= 54; 	// 扑克数量
		public static const GLOBAL_PLAYER_NUM:int		= 3;	// 玩家数量
		public static const GLOBAL_PLAYER_POKER:int		= 17;	// 玩家扑克数量

		public static const POKER_VALUE_2:int			= 13;	// 2的扑克值
		public static const POKER_VALUE_JOKER:int 		= 14; 	// 王的扑克值

		public static const POKER_TYPE_ONE:int 				= 1; // 单张
		public static const POKER_TYPE_TWO:int 				= 2; // 对子
		public static const POKER_TYPE_THREE:int 			= 3; // 3张
		public static const POKER_TYPE_BOMB:int 			= 4;  // 炸弹
		public static const POKER_TYPE_KING:int				= 5;  // 王炸
		public static const POKER_TYPE_1STRAIGHT:int		= 11; // 顺子
		public static const POKER_TYPE_2STRAIGHT:int		= 12; // 2连对
		public static const POKER_TYPE_3STRAIGHT:int		= 13; // 3连对
		public static const POKER_TYPE_3WITH1:int			= 14; // 3带1
		public static const POKER_TYPE_3WITH2:int			= 15; // 3带2
		public static const POKER_TYPE_4WITH1:int			= 16; // 4带1
		public static const POKER_TYPE_4WITH21:int			= 17; // 4带2(两单张)
		public static const POKER_TYPE_4WITH22:int			= 18; // 4带2(两对)

		public static const PLAY_STATE_PREPARE:int			= 1; // 预备
		public static const PLAY_STATE_DEAL:int				= 2; // 发牌
		public static const PLAY_STATE_SNATCH:int			= 3; // 抢地主
		public static const PLAY_STATE_DOUBLE:int			= 4; // 加倍
		public static const PLAY_STATE_PLAY:int				= 5; // 游戏
		public static const PLAY_STATE_OVER:int				= 6; // 结束
		public static const PLAY_STATE_BOTTOM:int			= 11; // 底牌

		public static const gameAccount:String				= "dcs1001";
		public static const gameScene:String				= "game.scene";
	}

}