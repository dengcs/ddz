package game.proto {
import com.google.protobuf.*;

public class mail_access extends Message {
    public function mail_access() {
    }

    override public function writeTo(output:CodedOutputStream):void {

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
            }
        }
    }

}
}
