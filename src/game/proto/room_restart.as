package game.proto {
import com.google.protobuf.*;

public class room_restart extends Message {
    public function room_restart() {
    }

    private var _channel:int = 0;
    public function get channel():int {
        return _channel;
    }
    public function set channel(value:int):void {
        _channel = value;
    }

    private var _tid:int = 0;
    public function get tid():int {
        return _tid;
    }
    public function set tid(value:int):void {
        _tid = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_channel == 0)) {
            output.writeUInt32(1, _channel);
        }
        if (!(_tid == 0)) {
            output.writeUInt32(2, _tid);
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
                case 16: {
                    _tid = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
