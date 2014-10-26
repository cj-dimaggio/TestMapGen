package com.ssawa;
import com.ssawa.utils.SmoothNoise;
import com.ssawa.utils.Perlin;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Lib.trace;
import haxe.ds.HashMap;
import com.ssawa.HexCord;
import openfl.geom.Point;

class HexMap extends Sprite
{
	var hexagons:HashMap<HexCord, Hexagon> = new HashMap<HexCord, Hexagon>();
	var hexCord:HexCord = new HexCord(0, 0);

	public function new(width:Int, height:Int) {
		super();
		generateOffsetHexGrid(width, height);
	}
	
	private function generateOffsetHexGrid(width:Int, height:Int):Void {
		var hexWidth:Int = Hexagon.size * 2;
		var horiz:Float = hexWidth;
		var vert:Float = (Math.sqrt(3) / 2) * hexWidth;
		var columns:Int = Std.int(width / (horiz * .75));
		var rows:Int = Std.int(height / vert);
		
		// The difference in width is 1 third times the width (size * 2)
		// The difference in height is sqrt(3)/2 * size
		// For some reason there is a bit of a space between the hexagons without dividing x by 1.1
		var startX:Float = horiz / 2; var startY:Float = vert / 2;
		for (x in 0...columns) {
			for (y in 0...rows) {
				var upOrDown:Int = (x % 2 == 0) ? 0 : 1;
				hexagons.set(hexCord.get(x, y), new Hexagon(startX + (horiz * .75 * x)
									,(startY + (vert * y)) + vert / 2 * upOrDown));
			}
		}
		for (hex in hexagons) {
			addChild(hex);
		}
		perlinIslandGenerate();
	}
	
	private function perlinIslandGenerate() {
		var perlin:BitmapData = new BitmapData(256, 256);
		perlin.perlinNoise(64, 64, 8, 1, false, true);
		
		function islandOrWater(q:Point):Bool {
		  var c:Float = (perlin.getPixel(Std.int((q.x+1)*128), Std.int((q.y+1)*128)) & 0xff) / 255.0;
		  return c > (0.3+0.3*q.length*q.length);
		}
		for (hex in hexagons) {
			if (islandOrWater(hex.center)) {
				hex.draw(1, 0, 0x0000FF);
			} else {
				hex.draw(1, 0, 0x00FF00);
			}
		}
	}
}