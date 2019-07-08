package game.proto {
import com.google.protobuf.*;

public class NetHeader extends Message {
    public function NetHeader() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    private var _errcode:int = 0;
    public function get errcode():int {
        return _errcode;
    }
    public function set errcode(value:int):void {
        _errcode = value;
    }

    private var _proto:String = "";
    public function get proto():String {
        return _proto;
    }
    public function set proto(value:String):void {
        _proto = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
        }
        if (!(_errcode == 0)) {
            output.writeUInt32(2, _errcode);
        }
        if (!(_proto.length == 0)) {
            output.writeString(3, _proto);
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
                    _pid = input.readString();
                    break;
                }
                case 16: {
                    _errcode = input.readUInt32();
                    break;
                }
                case 26: {
                    _proto = input.readString();
                    break;
                }
            }
        }
    }

}
}
