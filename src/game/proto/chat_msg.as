package game.proto {
import com.google.protobuf.*;

public class chat_msg extends Message {
    public function chat_msg() {
    }

    private var _channel:int = 0;
    public function get channel():int {
        return _channel;
    }
    public function set channel(value:int):void {
        _channel = value;
    }

    private var _receivePid:String = "";
    public function get receivePid():String {
        return _receivePid;
    }
    public function set receivePid(value:String):void {
        _receivePid = value || "";
    }

    private var _content:String = "";
    public function get content():String {
        return _content;
    }
    public function set content(value:String):void {
        _content = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_channel == 0)) {
            output.writeUInt32(1, _channel);
        }
        if (!(_receivePid.length == 0)) {
            output.writeString(2, _receivePid);
        }
        if (!(_content.length == 0)) {
            output.writeString(3, _content);
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
                case 18: {
                    _receivePid = input.readString();
                    break;
                }
                case 26: {
                    _content = input.readString();
                    break;
                }
            }
        }
    }

}
}
