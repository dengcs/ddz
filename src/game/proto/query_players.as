package game.proto {
import com.google.protobuf.*;

public class query_players extends Message {
    public function query_players() {
    }

    private var _account:String = "";
    public function get account():String {
        return _account;
    }
    public function set account(value:String):void {
        _account = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_account.length == 0)) {
            output.writeString(1, _account);
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
                    _account = input.readString();
                    break;
                }
            }
        }
    }

}
}
