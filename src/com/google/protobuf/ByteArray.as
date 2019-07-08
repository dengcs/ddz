package com.google.protobuf
{
	import laya.utils.Byte;

	/**
	 * ...
	 * @dengcs
	 */
	public class ByteArray extends Byte{
		public function ByteArray(data:* = null){
			super(data);
		}
		
		public function get position():int
		{
			return super.pos;
		}
		public function set position(value:int):void
		{
			super.pos = value;
		}
		
		public function writeBytes(arraybuffer:*, offset:uint = 0, length:uint = 0):void
		{
			super.writeArrayBuffer(arraybuffer.getUint8Array(offset,length), 0, length);
		}
		
		public function writeFloat(value:Number):void
		{
			super.writeFloat32(value);
		}
		
		public function writeDouble(value:Number):void
		{
			super.writeFloat64(value);
		}
		
		public function writeInt(value:int):void
		{
			super.writeInt32(value);
		}

		
		public function readInt():int
		{
			return super.getInt32();
		}
		
		public function readFloat():Number
		{
			return super.getFloat32();
		}
		
		public function readDouble():Number
		{
			return super.getFloat64();
		}
		
		public function readBytes(arraybuffer:*, offset:uint = 0, length:uint = 0):void
		{
			arraybuffer.writeArrayBuffer(super.getUint8Array(this.position,length), offset, length);
			arraybuffer.position = 0;
		}
	}

}