package game.proto {
import com.google.protobuf.*;

public class cmd_test extends Message {
    public function cmd_test() {
    }

    private var _cmdStr:String = "";
    public function get cmdStr():String {
        return _cmdStr;
    }
    public function set cmdStr(value:String):void {
        _cmdStr = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_cmdStr.length == 0)) {
            output.writeString(1, _cmdStr);
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
                    _cmdStr = input.readString();
                    break;
                }
            }
        }
    }

}
}
