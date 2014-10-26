package com.ssawa;
import openfl.geom.Point;

class HexCord
{
	private var x:Int;
	private var y:Int;
	
	public function new(x1:Int, y1:Int) {
		x = x1; y = y1;
	}
	
	public function get(x1:Int, y1:Int):HexCord {
		x = x1;
		y = y1;
		return this;
	}
	
	public function hashCode():Int {
		//Szudzik's function, read more at http://stackoverflow.com/questions/919612/mapping-two-integers-to-one-in-a-unique-and-deterministic-way
		return( x >= y ? x * x + x + y : x + y * y);
	}
}