package game.proto {
import com.google.protobuf.*;

public class create_player extends Message {
    public function create_player() {
    }

    private var _nickname:String = "";
    public function get nickname():String {
        return _nickname;
    }
    public function set nickname(value:String):void {
        _nickname = value || "";
    }

    private var _sex:int = 0;
    public function get sex():int {
        return _sex;
    }
    public function set sex(value:int):void {
        _sex = value;
    }

    private var _portrait:String = "";
    public function get portrait():String {
        return _portrait;
    }
    public function set portrait(value:String):void {
        _portrait = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_nickname.length == 0)) {
            output.writeString(1, _nickname);
        }
        if (!(_sex == 0)) {
            output.writeUInt32(2, _sex);
        }
        if (!(_portrait.length == 0)) {
            output.writeString(3, _portrait);
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
                    _nickname = input.readString();
                    break;
                }
                case 16: {
                    _sex = input.readUInt32();
                    break;
                }
                case 26: {
                    _portrait = input.readString();
                    break;
                }
            }
        }
    }

}
}
