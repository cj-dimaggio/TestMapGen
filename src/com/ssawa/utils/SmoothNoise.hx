package com.ssawa.utils;
import haxe.io.BytesOutput;
import openfl.display.BitmapData;
import com.ssawa.utils.PRNG;

class SmoothNoise
{
	static private var random:PRNG = new PRNG(1);
	static private var mapArray:Array<Array<Float>>;
	static private var width:Int;
	static private var height:Int;
	
	static public var scale:Int = 20;
	
	static public function generateSmoothNoise(bitmapData:BitmapData) {
		width = bitmapData.width;
		height = bitmapData.height;
		mapArray = [for (x in 0...width) [for (y in 0...height) 0]];
		
		whiteNoise();
		
		bitmapData.lock();
		for (x in 0...width) {
			for (y in 0...height) {
				bitmapData.setPixel(x, y, toColor(Std.int(turbulance(x, y, scale))));
			}
		}
		bitmapData.unlock();
	}
	
	static public function toColor(value:UInt):UInt {
		value = value & 0xFF;
		return ((value << 16) | (value << 8)) | value;
	}
	
	static private function whiteNoise():Void {
		for (x in 0...width) {
			for (y in 0...height) {
				mapArray[x][y] = random.nextFloat();
			}
		}
	}
	
	static private function smoothNoise(x:Float, y:Float):Float {
		//Get fractional part of x and y
		var fractX:Float = x - Std.int(x);
		var fractY:Float = y - Std.int(y);
		
		//Wrap around
		var x1:Int = (Std.int(x) + width) % width;
		var y1:Int = (Std.int(y) + height) % height;
		
		//neighbor values
		var x2:Int = (x1 + width - 1) % width;
		var y2:Int = (y1 + height - 1) % height;
		
		//Smooth the noise with bilinear interpolation
		var value:Float = 0.0;
		value += fractX * fractY * mapArray[x1][y1];
		value += fractX * (1-fractY) * mapArray[x1][y2];
		value += (1-fractX) * fractY * mapArray[x2][y1];
		value += (1-fractX) * (1-fractY) * mapArray[x2][y2];

		return value;
	}
	
	static private function turbulance(x:Float, y:Float, size:Float):Float {
		var value:Float = 0.0;
		var initialSize:Float = size;

		while(size >= 1)
		{
			value += smoothNoise(x / size, y / size) * size;
			size /= 2.0;
		}

		return (128.0 * value / initialSize);
	}
}