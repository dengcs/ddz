package game.proto {
import com.google.protobuf.*;

public class register extends Message {
    public function register() {
    }

    private var _account:String = "";
    public function get account():String {
        return _account;
    }
    public function set account(value:String):void {
        _account = value || "";
    }

    private var _passwd:String = "";
    public function get passwd():String {
        return _passwd;
    }
    public function set passwd(value:String):void {
        _passwd = value || "";
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_account.length == 0)) {
            output.writeString(1, _account);
        }
        if (!(_passwd.length == 0)) {
            output.writeString(2, _passwd);
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
                case 18: {
                    _passwd = input.readString();
                    break;
                }
            }
        }
    }

}
}
