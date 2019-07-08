package game.proto {
import com.google.protobuf.*;

public class register_resp extends Message {
    public function register_resp() {
    }

    private var _token:int = 0;
    public function get token():int {
        return _token;
    }
    public function set token(value:int):void {
        _token = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_token == 0)) {
            output.writeUInt32(1, _token);
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
                    _token = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
