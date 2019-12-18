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
		public static const POKER_TYPE_3STRAIGHT1:int		= 14; // 3连1
		public static const POKER_TYPE_3STRAIGHT2:int		= 15; // 3连2
		public static const POKER_TYPE_3WITH1:int			= 16; // 3带1
		public static const POKER_TYPE_3WITH2:int			= 17; // 3带2
		public static const POKER_TYPE_4WITH1:int			= 18; // 4带1
		public static const POKER_TYPE_4WITH21:int			= 19; // 4带2(两单张)
		public static const POKER_TYPE_4WITH22:int			= 20; // 4带2(两对)

		public static const POKER_TYPE_NO:int				= 101; // 不要
		public static const POKER_TYPE_DEAL1:int			= 201; // 发牌1
		public static const POKER_TYPE_DEAL2:int			= 202; // 发牌2
		public static const POKER_TYPE_DEAL3:int			= 203; // 发牌3
		public static const POKER_TYPE_DEAL4:int			= 204; // 发牌4
		public static const POKER_TYPE_DEAL5:int			= 205; // 发牌5
		public static const POKER_TYPE_DEAL6:int			= 206; // 发牌5
		public static const POKER_TYPE_WIN:int				= 301; // 我赢了
		public static const POKER_TYPE_FAIL:int				= 302; // 我输了
		public static const POKER_TYPE_WIN1:int				= 303; // 我赢了
		public static const POKER_TYPE_FAIL1:int			= 304; // 我输了

		public static const SOUND_SNATCH_YES:int			= 1; // 叫地主
		public static const SOUND_SNATCH_NO:int				= 2; // 不叫地主
		public static const SOUND_SNATCH_YES1:int			= 3; // 抢地主
		public static const SOUND_SNATCH_YES2:int			= 4; // 抢地主
		public static const SOUND_SNATCH_NO1:int			= 5; // 不抢地主
		public static const SOUND_LEFT_ONE:int				= 11; // 就剩1张牌了
		public static const SOUND_LEFT_TWO:int				= 12; // 就剩2张牌了
		public static const SOUND_BE_FAST:int				= 21; // 倒计时
		public static const SOUND_BUTTON_DOWN:int			= 22; // 按钮

		public static const PLAY_STATE_PREPARE:int			= 1; // 预备
		public static const PLAY_STATE_DEAL:int				= 2; // 发牌
		public static const PLAY_STATE_SNATCH:int			= 3; // 抢地主
		public static const PLAY_STATE_PLAY:int				= 4; // 游戏
		public static const PLAY_STATE_OVER:int				= 5; // 结束
		public static const PLAY_NOTIFY_BOTTOM:int			= 21; // 底牌
		public static const PLAY_NOTIFY_OVER:int			= 22; // 结束剩余牌数据

		public static const gameScene:String				= "game.scene";
	}

}