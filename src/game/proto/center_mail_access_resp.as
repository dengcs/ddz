package game.proto {
import com.google.protobuf.*;
import game.proto.mail;

public class center_mail_access_resp extends Message {
    public function center_mail_access_resp() {
    }

    private var _mails:Vector.<game.proto.mail> = new Vector.<game.proto.mail>();
    public function get mails():Vector.<game.proto.mail> {
        return _mails;
    }
    public function set mails(value:Vector.<game.proto.mail>):void {
        _mails = value || new Vector.<game.proto.mail>();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (_mails.length > 0) {
            output.writeVector(_mails, 1, FieldDescriptorType.MESSAGE);
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
                    _mails.push(input.readMessage(new game.proto.mail()));
                    break;
                }
            }
        }
    }

}
}
