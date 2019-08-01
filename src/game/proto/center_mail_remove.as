package game.proto {
import com.google.protobuf.*;

public class center_mail_remove extends Message {
    public function center_mail_remove() {
    }

    private var _ids:Vector.<String> = new Vector.<String>();
    public function get ids():Vector.<String> {
        return _ids;
    }
    public function set ids(value:Vector.<String>):void {
        _ids = value || new Vector.<String>();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (_ids.length > 0) {
            output.writeVector(_ids, 1, FieldDescriptorType.STRING);
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
                    _ids.push(input.readString());
                    break;
                }
            }
        }
    }

}
}
