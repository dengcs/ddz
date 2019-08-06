package game.proto {
import com.google.protobuf.*;

public class friend_search extends Message {
    public function friend_search() {
    }

    private var _name:String = "";
    public function get name():String {
        return _name;
    }
    public function set name(value:String):void {
        _name = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_name.length == 0)) {
            output.writeString(1, _name);
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
                    _name = input.readString();
                    break;
                }
            }
        }
    }

}
}
