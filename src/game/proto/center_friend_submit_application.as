package game.proto {
import com.google.protobuf.*;

public class center_friend_submit_application extends Message {
    public function center_friend_submit_application() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    private var _msg:String = "";
    public function get msg():String {
        return _msg;
    }
    public function set msg(value:String):void {
        _msg = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
        }
        if (!(_msg.length == 0)) {
            output.writeString(2, _msg);
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
                    _msg = input.readString();
                    break;
                }
            }
        }
    }

}
}
