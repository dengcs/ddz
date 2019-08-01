package game.proto {
import com.google.protobuf.*;
import game.proto.mail$attachment;

public class center_mail_receive_resp extends Message {
    public function center_mail_receive_resp() {
    }

    private var _ret:int = 0;
    public function get ret():int {
        return _ret;
    }
    public function set ret(value:int):void {
        _ret = value;
    }

    private var _ids:Vector.<String> = new Vector.<String>();
    public function get ids():Vector.<String> {
        return _ids;
    }
    public function set ids(value:Vector.<String>):void {
        _ids = value || new Vector.<String>();
    }

    private var _attachments:Vector.<game.proto.mail$attachment> = new Vector.<game.proto.mail$attachment>();
    public function get attachments():Vector.<game.proto.mail$attachment> {
        return _attachments;
    }
    public function set attachments(value:Vector.<game.proto.mail$attachment>):void {
        _attachments = value || new Vector.<game.proto.mail$attachment>();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_ret == 0)) {
            output.writeUInt32(1, _ret);
        }
        if (_ids.length > 0) {
            output.writeVector(_ids, 2, FieldDescriptorType.STRING);
        }
        if (_attachments.length > 0) {
            output.writeVector(_attachments, 3, FieldDescriptorType.MESSAGE);
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
                    _ids.push(input.readString());
                    break;
                }
                case 26: {
                    _attachments.push(input.readMessage(new game.proto.mail$attachment()));
                    break;
                }
            }
        }
    }

}
}
