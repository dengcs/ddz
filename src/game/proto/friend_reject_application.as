package game.proto {
import com.google.protobuf.*;

public class friend_reject_application extends Message {
    public function friend_reject_application() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
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
            }
        }
    }

}
}
