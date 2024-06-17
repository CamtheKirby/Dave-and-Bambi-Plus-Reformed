package;

import openfl.text.TextFormat;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import flixel.system.FlxSound;
import flixel.FlxG;
import flixel.util.FlxColor;


class Main extends Sprite
{
	var gameWidth:Int = 1280; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var gameHeight:Int = 720; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
	var initialState:Class<FlxState> = StartStateSelector; // The FlxState the game starts with.
	var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
	var framerate:Int = 140; // How many frames per second the game should run at.
	var skipSplash:Bool = false; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	public static var keyAmmo:Array<Int> = [4, 5, 6, 7, 9, 12];
	public static var dataJump:Array<Int> = [8, 10, 12, 14, 18, 24];

	public static var fps:FpsDisplay;

	public static var applicationName:String = "Friday Night Funkin' | VS. Dave and Bambi 3.0b | Extra Keys Addon 2.0.2 | Plus Beta 1.0 | Plus Reformed 1.0.0 FINAL?";

	// You can pretty much ignore everything from here on - your code should go in your states.

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();

		if (stage != null)
			init();
		else
			addEventListener(Event.ADDED_TO_STAGE, init);
	}

	private function init(?E:Event):Void
	{
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	public function toggleFPS(fpsEnabled:Bool):Void
		{
		}

	public static function toggleFuckedFPS(toggle:Bool)
	{
		fps.fuckFps = toggle;
	}

	public function changeFPSColor(color:FlxColor)
	{
		fps.textColor = color;
	}

	public function setFPSCap(cap:Float)
	{
		openfl.Lib.current.stage.frameRate = cap;
	}

	public function getFPSCap():Float
	{
		return openfl.Lib.current.stage.frameRate;
	}
	
	private function setupGame():Void
	{
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (zoom == -1)
		{
			var ratioX:Float = stageWidth / gameWidth;
			var ratioY:Float = stageHeight / gameHeight;
			zoom = Math.min(ratioX, ratioY);
			gameWidth = Math.ceil(stageWidth / zoom);
			gameHeight = Math.ceil(stageHeight / zoom);
		}

		#if !cpp
		framerate = 60;
		#end

		initialState = StartStateSelector;
		#if (flixel < "5.0.0")
addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, skipSplash, startFullscreen));
#else
addChild(new FlxGame(gameWidth, gameHeight, initialState, framerate, framerate, skipSplash, startFullscreen));
#end

		#if !mobile
		fps = new FpsDisplay(10, 3, 0xFFFFFF);
		var fpsFormat = new TextFormat("Comic Sans MS Bold", 15, 0xFFFFFF, true);
		fps.defaultTextFormat = fpsFormat;
		addChild(fps);
		toggleFPS(FlxG.save.data.fps);
		#end
	}
}