package game.proto {
import com.google.protobuf.*;
import game.proto.mail$attachment;
import game.proto.mail$member;

public class mail extends Message {
    public function mail() {
    }

    private var _mid:String = "";
    public function get mid():String {
        return _mid;
    }
    public function set mid(value:String):void {
        _mid = value || "";
    }

    private var _category:int = 0;
    public function get category():int {
        return _category;
    }
    public function set category(value:int):void {
        _category = value;
    }

    private var _source:game.proto.mail$member = null;
    public function get source():game.proto.mail$member {
        return _source;
    }
    public function set source(value:game.proto.mail$member):void {
        _source = value;
    }

    private var _status:int = 0;
    public function get status():int {
        return _status;
    }
    public function set status(value:int):void {
        _status = value;
    }

    private var _subject:String = "";
    public function get subject():String {
        return _subject;
    }
    public function set subject(value:String):void {
        _subject = value || "";
    }

    private var _content:String = "";
    public function get content():String {
        return _content;
    }
    public function set content(value:String):void {
        _content = value || "";
    }

    private var _ctime:int = 0;
    public function get ctime():int {
        return _ctime;
    }
    public function set ctime(value:int):void {
        _ctime = value;
    }

    private var _deadline:int = 0;
    public function get deadline():int {
        return _deadline;
    }
    public function set deadline(value:int):void {
        _deadline = value;
    }

    private var _attachments:Vector.<game.proto.mail$attachment> = new Vector.<game.proto.mail$attachment>();
    public function get attachments():Vector.<game.proto.mail$attachment> {
        return _attachments;
    }
    public function set attachments(value:Vector.<game.proto.mail$attachment>):void {
        _attachments = value || new Vector.<game.proto.mail$attachment>();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_mid.length == 0)) {
            output.writeString(1, _mid);
        }
        if (!(_category == 0)) {
            output.writeUInt32(2, _category);
        }
        if (!(_source == null)) {
            output.writeMessage(3, _source);
        }
        if (!(_status == 0)) {
            output.writeUInt32(4, _status);
        }
        if (!(_subject.length == 0)) {
            output.writeString(5, _subject);
        }
        if (!(_content.length == 0)) {
            output.writeString(6, _content);
        }
        if (!(_ctime == 0)) {
            output.writeUInt32(7, _ctime);
        }
        if (!(_deadline == 0)) {
            output.writeUInt32(8, _deadline);
        }
        if (_attachments.length > 0) {
            output.writeVector(_attachments, 9, FieldDescriptorType.MESSAGE);
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
                    _mid = input.readString();
                    break;
                }
                case 16: {
                    _category = input.readUInt32();
                    break;
                }
                case 26: {
                    _source = new game.proto.mail$member();
                    input.readMessage(_source);
                    break;
                }
                case 32: {
                    _status = input.readUInt32();
                    break;
                }
                case 42: {
                    _subject = input.readString();
                    break;
                }
                case 50: {
                    _content = input.readString();
                    break;
                }
                case 56: {
                    _ctime = input.readUInt32();
                    break;
                }
                case 64: {
                    _deadline = input.readUInt32();
                    break;
                }
                case 74: {
                    _attachments.push(input.readMessage(new game.proto.mail$attachment()));
                    break;
                }
            }
        }
    }

}
}
