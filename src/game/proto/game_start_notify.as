package game.proto {
import com.google.protobuf.*;
import game.proto.GameMember;

public class game_start_notify extends Message {
    public function game_start_notify() {
    }

    private var _teamid:int = 0;
    public function get teamid():int {
        return _teamid;
    }
    public function set teamid(value:int):void {
        _teamid = value;
    }

    private var _channel:int = 0;
    public function get channel():int {
        return _channel;
    }
    public function set channel(value:int):void {
        _channel = value;
    }

    private var _owner:String = "";
    public function get owner():String {
        return _owner;
    }
    public function set owner(value:String):void {
        _owner = value || "";
    }

    private var _state:int = 0;
    public function get state():int {
        return _state;
    }
    public function set state(value:int):void {
        _state = value;
    }

    private var _members:Vector.<game.proto.GameMember> = new Vector.<game.proto.GameMember>();
    public function get members():Vector.<game.proto.GameMember> {
        return _members;
    }
    public function set members(value:Vector.<game.proto.GameMember>):void {
        _members = value || new Vector.<game.proto.GameMember>();
    }

    override public function writeTo(output:CodedOutputStream):void {
        if (!(_teamid == 0)) {
            output.writeUInt32(1, _teamid);
        }
        if (!(_channel == 0)) {
            output.writeUInt32(2, _channel);
        }
        if (!(_owner.length == 0)) {
            output.writeString(3, _owner);
        }
        if (!(_state == 0)) {
            output.writeUInt32(4, _state);
        }
        if (_members.length > 0) {
            output.writeVector(_members, 5, FieldDescriptorType.MESSAGE);
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
                    _teamid = input.readUInt32();
                    break;
                }
                case 16: {
                    _channel = input.readUInt32();
                    break;
                }
                case 26: {
                    _owner = input.readString();
                    break;
                }
                case 32: {
                    _state = input.readUInt32();
                    break;
                }
                case 42: {
                    _members.push(input.readMessage(new game.proto.GameMember()));
                    break;
                }
            }
        }
    }

}
}
