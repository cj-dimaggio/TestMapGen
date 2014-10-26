package com.ssawa;

import openfl.display.Sprite;
import openfl.Lib.trace;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import com.ssawa.Hexagon;
import com.ssawa.HexCord;
import haxe.ds.HashMap;

class Main2 extends Sprite {
	
	public function new() 
	{
		super();
		var map:HexMap = new HexMap(stage.stageWidth, stage.stageHeight);
		addChild(map);
	}
}