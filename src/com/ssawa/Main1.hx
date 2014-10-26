package com.ssawa;

#if neko
import com.ssawa.utils.Window;
import neko.vm.*;
#elseif cpp
import com.ssawa.utils.Window;
import cpp.vm.*;
#end
import com.ssawa.utils.Perlin;
import com.ssawa.utils.SmoothNoise;
import haxe.Timer;
import openfl.display.Shape;
import openfl.display.*;
import openfl.Lib.trace;
import openfl.events.*;

class Main1 extends Sprite {
	public static var window:Window;
	var bitmap:Bitmap;
	var bitmapData:BitmapData;
	var perlin:Perlin;
	var mutex:Mutex;
	
	public function new() 
	{
		super();
		mutex = new Mutex();
		window = new Window(stage.__handle);
		bitmapData = new BitmapData(256, 256);
		perlin = new Perlin(1234, 4, .5);
		var thread = Thread.create(threadOne);
		thread.sendMessage(Thread.current());
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		bitmap = new Bitmap(bitmapData);
		bitmap.x = (stage.stageWidth - bitmap.width) / 2;
		bitmap.y = (stage.stageHeight - bitmap.height) / 2;
		addChild(bitmap);
	}
	
	private function threadOne() {
		var main:Thread = Thread.readMessage(true);
		//perlin.fill(bitmapData, 0, 0, 0);
		bitmapData.perlinNoise(64, 64, 8, 1, false, true);
		bitmapData.draw(bitmap);
		main.sendMessage("Done");
		
	}
	
	private function this_onEnterFrame (event:Event):Void {
		
		var message = Thread.readMessage (false);
		
		if (message == "Done") {
			trace (message);
			removeEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		}		
	}

}

/*bitmapData.lock();
for (x in 0...bitmapData.width) {
	for (y in 0...bitmapData.height) {
		if (Std.random(2) == 1) {
			bitmapData.setPixel(x, y, 0xFF336699);
		} else {
			bitmapData.setPixel(x, y, 0xFFFFFFFF);
		}
	}
}
bitmapData.unlock();*/