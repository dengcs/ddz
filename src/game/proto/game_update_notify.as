package game.proto {
import com.google.protobuf.*;

public class game_update_notify extends Message {
    public function game_update_notify() {
    }

    private var _data:String = "";
    public function get data():String {
        return _data;
    }
    public function set data(value:String):void {
        _data = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_data.length == 0)) {
            output.writeString(1, _data);
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
                    _data = input.readString();
                    break;
                }
            }
        }
    }

}
}
