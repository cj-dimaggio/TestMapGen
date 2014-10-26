package com.ssawa.utils;

import openfl._v2.Lib;

class Window {

	private static var handle:Dynamic;
	public function new(stageHandle:Dynamic) 
	{
		handle = stageHandle;
	}
	
	public function resize(width:Int, height:Int):Void {
		lime_stage_resize_window(handle, width, height);
	}
	
	public function setResolution(width:Int, height:Int):Void {
		lime_stage_set_resolution(handle, width, height);
	}
	
	public function setFullscreen(full:Bool):Void {
		lime_stage_set_fullscreen(handle, full);
	}
	
	public function showMouse(cursor:Bool):Void {
		lime_stage_show_cursor(handle, cursor);
	}
	
	private static var lime_stage_resize_window = Lib.load("lime", "lime_stage_resize_window", 3);
	private static var lime_stage_set_resolution = Lib.load("lime", "lime_stage_set_resolution", 3);
	private static var lime_stage_set_fullscreen = Lib.load("lime", "lime_stage_set_fullscreen", 2);
	private static var lime_stage_show_cursor  = Lib.load("lime", "lime_stage_show_cursor", 2);
}