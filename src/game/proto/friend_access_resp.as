package game.proto {
import com.google.protobuf.*;
import game.proto.friend;

public class friend_access_resp extends Message {
    public function friend_access_resp() {
    }

    private var _friendList:Vector.<game.proto.friend> = new Vector.<game.proto.friend>();
    public function get friendList():Vector.<game.proto.friend> {
        return _friendList;
    }
    public function set friendList(value:Vector.<game.proto.friend>):void {
        _friendList = value || new Vector.<game.proto.friend>();
    }

    private var _blackList:Vector.<game.proto.friend> = new Vector.<game.proto.friend>();
    public function get blackList():Vector.<game.proto.friend> {
        return _blackList;
    }
    public function set blackList(value:Vector.<game.proto.friend>):void {
        _blackList = value || new Vector.<game.proto.friend>();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (_friendList.length > 0) {
            output.writeVector(_friendList, 1, FieldDescriptorType.MESSAGE);
        }
        if (_blackList.length > 0) {
            output.writeVector(_blackList, 2, FieldDescriptorType.MESSAGE);
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
                    _friendList.push(input.readMessage(new game.proto.friend()));
                    break;
                }
                case 18: {
                    _blackList.push(input.readMessage(new game.proto.friend()));
                    break;
                }
            }
        }
    }

}
}
