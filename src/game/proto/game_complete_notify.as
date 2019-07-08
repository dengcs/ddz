package game.proto {
import com.google.protobuf.*;

public class game_complete_notify extends Message {
    public function game_complete_notify() {
    }

    private var _score:int = 0;
    public function get score():int {
        return _score;
    }
    public function set score(value:int):void {
        _score = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_score == 0)) {
            output.writeUInt32(1, _score);
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
                    _score = input.readUInt32();
                    break;
                }
            }
        }
    }

}
}
