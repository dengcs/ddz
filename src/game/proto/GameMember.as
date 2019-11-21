package game.proto {
import com.google.protobuf.*;

public class GameMember extends Message {
    public function GameMember() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    private var _place:int = 0;
    public function get place():int {
        return _place;
    }
    public function set place(value:int):void {
        _place = value;
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

    private var _portraitBox:int = 0;
    public function get portraitBox():int {
        return _portraitBox;
    }
    public function set portraitBox(value:int):void {
        _portraitBox = value;
    }

    private var _state:int = 0;
    public function get state():int {
        return _state;
    }
    public function set state(value:int):void {
        _state = value;
    }

    private var _ulevel:int = 0;
    public function get ulevel():int {
        return _ulevel;
    }
    public function set ulevel(value:int):void {
        _ulevel = value;
    }

    private var _vlevel:int = 0;
    public function get vlevel():int {
        return _vlevel;
    }
    public function set vlevel(value:int):void {
        _vlevel = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
        }
        if (!(_place == 0)) {
            output.writeUInt32(2, _place);
        }
        if (!(_sex == 0)) {
            output.writeUInt32(3, _sex);
        }
        if (!(_nickname.length == 0)) {
            output.writeString(4, _nickname);
        }
        if (!(_portrait.length == 0)) {
            output.writeString(5, _portrait);
        }
        if (!(_portraitBox == 0)) {
            output.writeUInt32(6, _portraitBox);
        }
        if (!(_state == 0)) {
            output.writeUInt32(7, _state);
        }
        if (!(_ulevel == 0)) {
            output.writeUInt32(8, _ulevel);
        }
        if (!(_vlevel == 0)) {
            output.writeUInt32(9, _vlevel);
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
                    _place = input.readUInt32();
                    break;
                }
                case 24: {
                    _sex = input.readUInt32();
                    break;
                }
                case 34: {
                    _nickname = input.readString();
                    break;
                }
                case 42: {
                    _portrait = input.readString();
                    break;
                }
                case 48: {
                    _portraitBox = input.readUInt32();
                    break;
                }
                case 56: {
                    _state = input.readUInt32();
                    break;
                }
                case 64: {
                    _ulevel = input.readUInt32();
                    break;
                }
                case 72: {
                    _vlevel = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
