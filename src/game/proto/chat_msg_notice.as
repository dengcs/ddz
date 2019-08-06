package game.proto {
import com.google.protobuf.*;

public class chat_msg_notice extends Message {
    public function chat_msg_notice() {
    }

    private var _channel:int = 0;
    public function get channel():int {
        return _channel;
    }
    public function set channel(value:int):void {
        _channel = value;
    }

    private var _sendPid:String = "";
    public function get sendPid():String {
        return _sendPid;
    }
    public function set sendPid(value:String):void {
        _sendPid = value || "";
    }

    private var _sendName:String = "";
    public function get sendName():String {
        return _sendName;
    }
    public function set sendName(value:String):void {
        _sendName = value || "";
    }

    private var _sendLevel:int = 0;
    public function get sendLevel():int {
        return _sendLevel;
    }
    public function set sendLevel(value:int):void {
        _sendLevel = value;
    }

    private var _sendPortrait:int = 0;
    public function get sendPortrait():int {
        return _sendPortrait;
    }
    public function set sendPortrait(value:int):void {
        _sendPortrait = value;
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

    private var _sendTime:int = 0;
    public function get sendTime():int {
        return _sendTime;
    }
    public function set sendTime(value:int):void {
        _sendTime = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_channel == 0)) {
            output.writeUInt32(1, _channel);
        }
        if (!(_sendPid.length == 0)) {
            output.writeString(2, _sendPid);
        }
        if (!(_sendName.length == 0)) {
            output.writeString(3, _sendName);
        }
        if (!(_sendLevel == 0)) {
            output.writeUInt32(4, _sendLevel);
        }
        if (!(_sendPortrait == 0)) {
            output.writeUInt32(5, _sendPortrait);
        }
        if (!(_receivePid.length == 0)) {
            output.writeString(6, _receivePid);
        }
        if (!(_content.length == 0)) {
            output.writeString(7, _content);
        }
        if (!(_sendTime == 0)) {
            output.writeUInt32(8, _sendTime);
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
                    _sendPid = input.readString();
                    break;
                }
                case 26: {
                    _sendName = input.readString();
                    break;
                }
                case 32: {
                    _sendLevel = input.readUInt32();
                    break;
                }
                case 40: {
                    _sendPortrait = input.readUInt32();
                    break;
                }
                case 50: {
                    _receivePid = input.readString();
                    break;
                }
                case 58: {
                    _content = input.readString();
                    break;
                }
                case 64: {
                    _sendTime = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
