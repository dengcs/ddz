package view {
	import ui.dialog.SettleUI;
	import laya.ui.Box;
	import laya.utils.Handler;
	import common.GameGlobal;
	import laya.ui.Image;
	import laya.ui.Label;
	import game.handler.GameHandler;
	import game.proto.GameMember;
	import game.proto.game_start_notify;
	import laya.events.Event;
	import game.proto.room_synchronize_notify;
	import game.handler.RoomHandler;
	import game.proto.room_restart;
	import game.net.NetClient;

	public class SettleDialog extends SettleUI{
		override public function onAwake():void
		{
			this.settleList.array = [];
			this.btnRestart.on(Event.CLICK, this, onRestart);
			this.settleList.renderHandler = new Handler(this, onListRender);
		}		

		override public function onOpened(param:*):void
		{
			if(GameGlobal.overData != null)
			{
				var idx:int 		= GameGlobal.overData.idx;
				var lord:int 		= GameGlobal.overData.lord;
				var double:int		= GameGlobal.overData.double;
				var game_data:game_start_notify = GameHandler.getInstance().get("start");
				if(game_data != null)
				{
					var channel:int	= game_data.channel;
					var settleArray:Array = [];
					for each(var member:GameMember in game_data.members)
					{
						var settleData:Object = new Object();
						settleData.nickname = member.nickname;
						settleData.double	= double;
						if(member.place == lord)
						{
							if(member.place == idx)
							{
								settleData.score = double * channel;
							}else
							{
								settleData.score = -(double * channel);
							}
						}else
						{
							if(idx == lord)
							{
								settleData.score = -(double * channel);
							}else
							{
								settleData.score = double * channel;
							}
						}
						settleArray.push(settleData);
					}
					this.settleList.array = settleArray;
				}
			}
		}

		private function onRestart():void
		{
			var synchronize:room_synchronize_notify = RoomHandler.getInstance().get("synchronize");
			if(synchronize != null)
			{
				var msg_data:room_restart = new room_restart();
				msg_data.channel = synchronize.channel;
				msg_data.tid = synchronize.teamid;
				NetClient.send("room_restart", msg_data);
			}
		}

		private function onListRender(cell:Box, index:int):void 
		{
			var settleData:Object = this.settleList.array[index];
			var diban:Image = cell.getChildAt(0) as Image;
			var nameLab:Label	= diban.getChildAt(0) as Label;
			var doubleLab:Label	= diban.getChildAt(1) as Label;
			var scoreLab:Label	= diban.getChildAt(2) as Label;

			nameLab.text 	= settleData.nickname;
			doubleLab.text	= settleData.double;
			scoreLab.text	= settleData.score;
		}
    }
}