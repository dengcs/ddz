package game.proto {
import com.google.protobuf.*;
import game.proto.friend;

public class friend_append_enemy_resp extends Message {
    public function friend_append_enemy_resp() {
    }

    private var _ret:int = 0;
    public function get ret():int {
        return _ret;
    }
    public function set ret(value:int):void {
        _ret = value;
    }

    private var _data:game.proto.friend = null;
    public function get data():game.proto.friend {
        return _data;
    }
    public function set data(value:game.proto.friend):void {
        _data = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_ret == 0)) {
            output.writeUInt32(1, _ret);
        }
        if (!(_data == null)) {
            output.writeMessage(2, _data);
        }

        super.writeTo(output);
    }

    override public function readFrom(input:CodedInputStream):void {
        while(true) {
            var tag:int = input.readTag();
            switch(tag) {
                case 0: {
                    return;
                }
                default: {
                    if (!input.skipField(tag)) {
                        return;
                    }
                    break;
                }
                case 8: {
                    _ret = input.readUInt32();
                    break;
                }
                case 18: {
                    _data = new game.proto.friend();
                    input.readMessage(_data);
                    break;
                }
            }
        }
    }

}
}
