package game.proto {
import com.google.protobuf.*;
import game.proto.NetHeader;

public class NetMessage extends Message {
    public function NetMessage() {
    }

    private var _header:game.proto.NetHeader = null;
    public function get header():game.proto.NetHeader {
        return _header;
    }
    public function set header(value:game.proto.NetHeader):void {
        _header = value;
    }

    private var _payload:ByteArray = new ByteArray();
    public function get payload():ByteArray {
        return _payload;
    }
    public function set payload(value:ByteArray):void {
        _payload = value || new ByteArray();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_header == null)) {
            output.writeMessage(1, _header);
        }
        if (!(_payload.length == 0)) {
            output.writeBytes(2, _payload);
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
                    _header = new game.proto.NetHeader();
                    input.readMessage(_header);
                    break;
                }
                case 18: {
                    _payload = input.readBytes();
                    break;
                }
            }
        }
    }

}
}
