package game.proto {
import com.google.protobuf.*;

public class mail$member extends Message {
    public function mail$member() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
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

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
        }
        if (!(_nickname.length == 0)) {
            output.writeString(2, _nickname);
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
                    _pid = input.readString();
                    break;
                }
                case 18: {
                    _nickname = input.readString();
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
