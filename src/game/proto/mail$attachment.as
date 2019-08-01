package game.proto {
import com.google.protobuf.*;

public class mail$attachment extends Message {
    public function mail$attachment() {
    }

    private var _id:int = 0;
    public function get id():int {
        return _id;
    }
    public function set id(value:int):void {
        _id = value;
    }

    private var _count:int = 0;
    public function get count():int {
        return _count;
    }
    public function set count(value:int):void {
        _count = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_id == 0)) {
            output.writeUInt32(1, _id);
        }
        if (!(_count == 0)) {
            output.writeUInt32(2, _count);
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
                    _id = input.readUInt32();
                    break;
                }
                case 16: {
                    _count = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
