package com.google.protobuf {

public class Message {
    public function Message() {
    }

    public function writeTo(output:CodedOutputStream):void {
    }

    public function readFrom(input:CodedInputStream):void {
    }

    public static function toByteArray(message:Message):ByteArray {
        var bytes:ByteArray = new ByteArray();
        message.writeTo(new CodedOutputStream(bytes));
        return bytes;
    }
}
}
