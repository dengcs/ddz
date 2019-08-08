package game.proto {
import com.google.protobuf.*;

public class rank_access extends Message {
    public function rank_access() {
    }

    private var _alias:String = "";
    public function get alias():String {
        return _alias;
    }
    public function set alias(value:String):void {
        _alias = value || "";
    }

    private var _spoint:int = 0;
    public function get spoint():int {
        return _spoint;
    }
    public function set spoint(value:int):void {
        _spoint = value;
    }

    private var _epoint:int = 0;
    public function get epoint():int {
        return _epoint;
    }
    public function set epoint(value:int):void {
        _epoint = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_alias.length == 0)) {
            output.writeString(1, _alias);
        }
        if (!(_spoint == 0)) {
            output.writeUInt32(2, _spoint);
        }
        if (!(_epoint == 0)) {
            output.writeUInt32(3, _epoint);
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
                    _alias = input.readString();
                    break;
                }
                case 16: {
                    _spoint = input.readUInt32();
                    break;
                }
                case 24: {
                    _epoint = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
