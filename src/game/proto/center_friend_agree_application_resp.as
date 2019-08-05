package game.proto {
import com.google.protobuf.*;

public class center_friend_agree_application_resp extends Message {
    public function center_friend_agree_application_resp() {
    }

    private var _ret:int = 0;
    public function get ret():int {
        return _ret;
    }
    public function set ret(value:int):void {
        _ret = value;
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_ret == 0)) {
            output.writeUInt32(1, _ret);
        }
        if (!(_pid.length == 0)) {
            output.writeString(2, _pid);
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
                case 18: {
                    _pid = input.readString();
                    break;
                }
            }
        }
    }

}
}
