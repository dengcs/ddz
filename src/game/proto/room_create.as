package game.proto {
import com.google.protobuf.*;

public class room_create extends Message {
    public function room_create() {
    }

    private var _channel:int = 0;
    public function get channel():int {
        return _channel;
    }
    public function set channel(value:int):void {
        _channel = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_channel == 0)) {
            output.writeUInt32(1, _channel);
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
                    _channel = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
