package com.ssawa;

import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Lib.trace;
import openfl.events.MouseEvent;

class Hexagon extends Sprite {
	
	private var color:Int;
	public static var size:UInt = 10;
	private static var pointy:Bool = false;
	public var corners:Array<Point> = new Array<Point>();
	public var center:Point;

	public function new(centerX:Float, centerY:Float) 
	{
		super();
		var extraDegrees:Float = 0;
		if (pointy) {
			//Adds 30 degrees to radians if we want pointy hexagons
			extraDegrees = Math.PI / 180 * 30;
		}
		center = new Point(centerX, centerY);
		for (i in 0...6) {
			var angle:Float = 2 * Math.PI / 6 * i + extraDegrees;
			var corner:Point = new Point((center.x + size * Math.cos(angle)), (center.y + size * Math.sin(angle)));
			corners.push(corner);
		}
		//addEventListener(MouseEvent.MOUSE_OVER, mousedOver);
		//addEventListener(MouseEvent.MOUSE_OUT, mousedOut);
		addEventListener(MouseEvent.MOUSE_DOWN, click);
		draw(1, 0, 0xFFFFFF);
	}
	
	public function draw(lineWidth:Float, lineColor:Int, fillColor:Int):Void {
		color = fillColor;
		graphics.clear();
		graphics.lineStyle(lineWidth, lineColor);
		graphics.beginFill(fillColor, 1);
		for (i in 0...6) {
			if (i == 0) {
				graphics.moveTo(corners[i].x, corners[i].y);
			} else {
				graphics.lineTo(corners[i].x, corners[i].y);
			}
		}
		graphics.lineTo(corners[0].x, corners[0].y);
	}
	
	private function click(e:MouseEvent) {
		trace(StringTools.hex(color));
	}
	
	private function mousedOver(e:MouseEvent) {
		draw(1, 0, 0x229922);
	}
	private function mousedOut(e:MouseEvent) {
		draw(1, 0, 0xFFFFFF);
	}
}