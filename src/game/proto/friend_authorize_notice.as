package game.proto {
import com.google.protobuf.*;
import game.proto.friend;

public class friend_authorize_notice extends Message {
    public function friend_authorize_notice() {
    }

    private var _data:game.proto.friend = null;
    public function get data():game.proto.friend {
        return _data;
    }
    public function set data(value:game.proto.friend):void {
        _data = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_data == null)) {
            output.writeMessage(1, _data);
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
                case 10: {
                    _data = new game.proto.friend();
                    input.readMessage(_data);
                    break;
                }
            }
        }
    }

}
}
