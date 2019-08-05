package game.proto {
import com.google.protobuf.*;

public class friend_state_notice extends Message {
    public function friend_state_notice() {
    }

    private var _pid:String = "";
    public function get pid():String {
        return _pid;
    }
    public function set pid(value:String):void {
        _pid = value || "";
    }

    private var _name:String = "";
    public function get name():String {
        return _name;
    }
    public function set name(value:String):void {
        _name = value || "";
    }

    private var _type:int = 0;
    public function get type():int {
        return _type;
    }
    public function set type(value:int):void {
        _type = value;
    }

    private var _value:String = "";
    public function get value():String {
        return _value;
    }
    public function set value(value:String):void {
        _value = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_pid.length == 0)) {
            output.writeString(1, _pid);
        }
        if (!(_name.length == 0)) {
            output.writeString(2, _name);
        }
        if (!(_type == 0)) {
            output.writeUInt32(3, _type);
        }
        if (!(_value.length == 0)) {
            output.writeString(4, _value);
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
                    _name = input.readString();
                    break;
                }
                case 24: {
                    _type = input.readUInt32();
                    break;
                }
                case 34: {
                    _value = input.readString();
                    break;
                }
            }
        }
    }

}
}
