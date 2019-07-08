package game.proto {
import com.google.protobuf.*;

public class kick_notify extends Message {
    public function kick_notify() {
    }

    private var _reason:int = 0;
    public function get reason():int {
        return _reason;
    }
    public function set reason(value:int):void {
        _reason = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_reason == 0)) {
            output.writeUInt32(1, _reason);
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
                    _reason = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
