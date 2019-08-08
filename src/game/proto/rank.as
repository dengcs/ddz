package game.proto {
import com.google.protobuf.*;

public class rank extends Message {
    public function rank() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    private var _sex:int = 0;
    public function get sex():int {
        return _sex;
    }
    public function set sex(value:int):void {
        _sex = value;
    }

    private var _nickname:String = "";
    public function get nickname():String {
        return _nickname;
    }
    public function set nickname(value:String):void {
        _nickname = value || "";
    }

    private var _portrait:String = "";
    public function get portrait():String {
        return _portrait;
    }
    public function set portrait(value:String):void {
        _portrait = value || "";
    }

    private var _value:int = 0;
    public function get value():int {
        return _value;
    }
    public function set value(value:int):void {
        _value = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
        }
        if (!(_sex == 0)) {
            output.writeUInt32(2, _sex);
        }
        if (!(_nickname.length == 0)) {
            output.writeString(3, _nickname);
        }
        if (!(_portrait.length == 0)) {
            output.writeString(4, _portrait);
        }
        if (!(_value == 0)) {
            output.writeUInt32(5, _value);
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
                    _sex = input.readUInt32();
                    break;
                }
                case 26: {
                    _nickname = input.readString();
                    break;
                }
                case 34: {
                    _portrait = input.readString();
                    break;
                }
                case 40: {
                    _value = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
