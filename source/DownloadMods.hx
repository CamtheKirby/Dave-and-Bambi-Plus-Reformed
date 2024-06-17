/*package;
#if sys
import sys.io.File;
import sys.io.Process;
import sys.FileSystem;
#end
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUITooltip.FlxUITooltipStyle;
import openfl.net.FileReference;
import openfl.utils.ByteArray;
import flixel.addons.ui.FlxUIText;
import haxe.zip.Writer;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import flixel.FlxG;
import flixel.FlxState;
import lime.system.Clipboard;
import haxe.io.Path;


using StringTools;
/
  Something to auto download the song data and music lol
 
class DownloadMods extends FlxState 
{
	var bg:FlxSprite = new FlxSprite();
	var defColor:FlxColor;
	var _file:FileReference;
	var data:String = 'cuh';
	var location:FlxInputText;

	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		FlxG.mouse.visible = true;
		bg.loadGraphic(MainMenuState.randomizeBG());
		bg.color = 0xFF000034;
		defColor = bg.color;
		bg.scrollFactor.set();
		add(bg);

		var dData:FlxButton = new FlxButton(150, 340, "Get Song Data", function()
			{
				loadData();
			});
			add(dData);

		    location = new FlxUIInputText(150, 310, 70, 'DATADIRHERE', 8);
			add(location);
	  }

	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		data = location.text.replace('\\', '/');
		//trace(data);

		if (FlxG.keys.pressed.ESCAPE)
		{
			endIt();
		}
	}
	
	public function endIt() 
	{
		FlxG.mouse.visible = false;
        FlxG.switchState(new FreeplayState());
	}

	public function loadData() 
		{
		trace('wow it works and doesn\'t crash :))))');
		var inputString:String = "abc/def/g";
        var targetChar:String = "/"; // Use "/" as the target character

        var resultString:String = deleteCharactersAfter(inputString, targetChar);
        trace(resultString);


		   File.copy(data, 'assets/data/customCharts/what.json');
		}

		static function deleteCharactersAfter(input:String, target:String):String {
			var index:Int = input.indexOf(target);
	
			if (index != -1) {
				return input.substring(0, input.indexOf(target, index + 1)); // Include the last occurrence of the target character
			} else {
				// Character not found, return the original string
				return input;
			}
		}

} */