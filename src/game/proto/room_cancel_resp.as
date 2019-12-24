package game.proto {
import com.google.protobuf.*;

public class room_cancel_resp extends Message {
    public function room_cancel_resp() {
    }

    private var _ret:int = 0;
    public function get ret():int {
        return _ret;
    }
    public function set ret(value:int):void {
        _ret = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_ret == 0)) {
            output.writeUInt32(1, _ret);
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
            }
        }
    }

}
}
