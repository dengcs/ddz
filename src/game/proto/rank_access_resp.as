package game.proto {
import com.google.protobuf.*;
import game.proto.rank;

public class rank_access_resp extends Message {
    public function rank_access_resp() {
    }

    private var _alias:String = "";
    public function get alias():String {
        return _alias;
    }
    public function set alias(value:String):void {
        _alias = value || "";
    }

    private var _ranks:Vector.<game.proto.rank> = new Vector.<game.proto.rank>();
    public function get ranks():Vector.<game.proto.rank> {
        return _ranks;
    }
    public function set ranks(value:Vector.<game.proto.rank>):void {
        _ranks = value || new Vector.<game.proto.rank>();
    }

    private var _myrank:game.proto.rank = null;
    public function get myrank():game.proto.rank {
        return _myrank;
    }
    public function set myrank(value:game.proto.rank):void {
        _myrank = value;
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_alias.length == 0)) {
            output.writeString(1, _alias);
        }
        if (_ranks.length > 0) {
            output.writeVector(_ranks, 2, FieldDescriptorType.MESSAGE);
        }
        if (!(_myrank == null)) {
            output.writeMessage(3, _myrank);
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
                    _alias = input.readString();
                    break;
                }
                case 18: {
                    _ranks.push(input.readMessage(new game.proto.rank()));
                    break;
                }
                case 26: {
                    _myrank = new game.proto.rank();
                    input.readMessage(_myrank);
                    break;
                }
            }
        }
    }

}
}
