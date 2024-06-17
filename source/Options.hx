package;

import lime.app.Application;
import lime.system.DisplayMode;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;
import OptionsMenu;
import SaveDataHandler;
import flixel.input.gamepad.FlxGamepad;

class Option
{
	public function new()
	{
		display = updateDisplay();
	}

	var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

	private var description:String = "";

	private var display:String;
	private var acceptValues:Bool = false;

	public static var valuechanged:Bool = false;

	public var acceptType:Bool = false;

	public var waitingType:Bool = false;

	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	public function getValue():String
	{
		return updateDisplay();
	};

	public function onType(text:String)
	{
	}

	// Returns whether the label is to be updated.
	public function press():Bool
	{
		return true;
	}

	private function updateDisplay():String
	{
		return "";
	}

	public function left():Bool
	{
		return false;
	}

	public function right():Bool
	{
		return false;
	}
}

class LanguageOption extends Option
{
	public function new()
	{
		super();
	 
		description = "Change your Language";
	}

	public override function press():Bool
	{
		 
		FlxG.switchState(new ChangeLanguageState());
             		return true;
	}

	private override function updateDisplay():String
	{
		return "Change Language";
	}
}

class DFJKOption extends Option
{
	public function new()
	{
		super();
		description = "Edit your keybindings";
	}

	public override function press():Bool
	{
		FlxG.switchState(new ChangeKeybinds());
        return true;
	}

	private override function updateDisplay():String
	{
		return "Edit Keybindings";
	}
}

class UpKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gpupBind = text;
			else
				FlxG.save.data.upBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "UP: " + (waitingType ? "> " + FlxG.save.data.upBind + " <" : FlxG.save.data.upBind) + "";
	}
}

class DownKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gpdownBind = text;
			else
				FlxG.save.data.downBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "DOWN: " + (waitingType ? "> " + FlxG.save.data.downBind + " <" : FlxG.save.data.downBind) + "";
	}
}

class RightKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gprightBind = text;
			else
				FlxG.save.data.rightBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "RIGHT: " + (waitingType ? "> " + FlxG.save.data.rightBind + " <" : FlxG.save.data.rightBind) + "";
	}
}

class LeftKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gplefttBind = text;
			else
				FlxG.save.data.leftBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "LEFT: " + (waitingType ? "> " + FlxG.save.data.leftBind + " <" : FlxG.save.data.leftBind) + "";
	}
}

class PauseKeybind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gppauseBind = text;
			else
				FlxG.save.data.pauseBind = text;

			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "PAUSE: " + (waitingType ? "> " + FlxG.save.data.pauseBind + " <" : FlxG.save.data.pauseBind) + "";
	}
}

class ResetBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			if (gamepad != null)
				FlxG.save.data.gpresetBind = text;
			else
				FlxG.save.data.resetBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "RESET: " + (waitingType ? "> " + FlxG.save.data.resetBind + " <" : FlxG.save.data.resetBind) + "";
	}
}

class MuteBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.muteBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "VOLUME MUTE: " + (waitingType ? "> " + FlxG.save.data.muteBind + " <" : FlxG.save.data.muteBind) + "";
	}
}

class VolUpBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.volUpBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "VOLUME UP: " + (waitingType ? "> " + FlxG.save.data.volUpBind + " <" : FlxG.save.data.volUpBind) + "";
	}
}

class VolDownBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.volDownBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "VOLUME DOWN: " + (waitingType ? "> " + FlxG.save.data.volDownBind + " <" : FlxG.save.data.volDownBind) + "";
	}
}

class FullscreenBind extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptType = true;
	}

	public override function onType(text:String)
	{
		if (waitingType)
		{
			FlxG.save.data.fullscreenBind = text;
			waitingType = false;
		}
	}

	public override function press()
	{
		waitingType = !waitingType;

		return true;
	}

	private override function updateDisplay():String
	{
		return "FULLSCREEN:  " + (waitingType ? "> " + FlxG.save.data.fullscreenBind + " <" : FlxG.save.data.fullscreenBind) + "";
	}
}

class SickMSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptType = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.sickWindow--;
		if (FlxG.save.data.sickWindow < 0)
			FlxG.save.data.sickWindow = 0;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.sickWindow++;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.sickWindow = 45;
	}

	private override function updateDisplay():String
	{
		return "SICK: < " + FlxG.save.data.sickWindow + " ms >";
	}
}

class GoodMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptType = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.goodWindow--;
		if (FlxG.save.data.goodWindow < 0)
			FlxG.save.data.goodWindow = 0;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.goodWindow++;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.goodWindow = 90;
	}

	private override function updateDisplay():String
	{
		return "GOOD: < " + FlxG.save.data.goodWindow + " ms >";
	}
}

class BadMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptType = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.badWindow--;
		if (FlxG.save.data.badWindow < 0)
			FlxG.save.data.badWindow = 0;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.badWindow++;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.badWindow = 135;
	}

	private override function updateDisplay():String
	{
		return "BAD: < " + FlxG.save.data.badWindow + " ms >";
	}
}

class ShitMsOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc + " (Press R to reset)";
		acceptType = true;
	}

	public override function left():Bool
	{
		FlxG.save.data.shitMs--;
		if (FlxG.save.data.shitMs < 0)
			FlxG.save.data.shitMs = 0;
		display = updateDisplay();
		return true;
	}

	public override function onType(char:String)
	{
		if (char.toLowerCase() == "r")
			FlxG.save.data.shitMs = 160;
	}

	public override function right():Bool
	{
		FlxG.save.data.shitMs++;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "SHIT: < " + FlxG.save.data.shitMs + " ms >";
	}
}

/*class Shaders extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		 
		FlxG.save.data.shaders = !FlxG.save.data.shaders;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		 
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Note Splashes: < " + (!FlxG.save.data.shaders ? "off" : "on") + " >";
	}
}*/

class WavingBackgrounds extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.waving = !FlxG.save.data.waving;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{

		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Waving Backgrounds: < " + (!FlxG.save.data.waving ? "off" : "on") + " >";
	}
}

class GPURendering extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;

		#if html5
		description = "This option is handled automaticly by browser.";
		#end
	}

	public override function left():Bool
	{
		#if !html5

		FlxG.save.data.gpuRender = !FlxG.save.data.gpuRender;
		display = updateDisplay();
		return true;
		#else
		return false;
		#end
	}

	public override function right():Bool
	{
		#if !html5
		left();
		return true;
		#else
		return false;
		#end
	}

	private override function updateDisplay():String
	{
		#if !html5
		return "GPU Rendering: < " + (!FlxG.save.data.gpuRender ? "off" : "on") + " >";
		#else
		return "GPU Rendering: < " + "Auto" + " >";
		#end
	}
}

class RoundAccuracy extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.roundAccuracy = !FlxG.save.data.roundAccuracy;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Round Accuracy: < " + (FlxG.save.data.roundAccuracy ? "on" : "off") + " >";
	}
}

class CpuStrums extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.cpuStrums = !FlxG.save.data.cpuStrums;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "CPU Strums: < " + (FlxG.save.data.cpuStrums ? "Light up" : "Stay static") + " >";
	}
}

class GraphicLoading extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.cacheImages = !FlxG.save.data.cacheImages;

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "";
	}
}

class EditorRes extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.editorBG = !FlxG.save.data.editorBG;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Editor Grid: < " + (FlxG.save.data.editorBG ? "Shown" : "Hidden") + " >";
	}
}

class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Scroll: < " + (FlxG.save.data.downscroll ? "Downscroll" : "Upscroll") + " >";
	}
}

class GhostTapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.ghost = !FlxG.save.data.ghost;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Ghost Tapping: < " + (FlxG.save.data.ghost ? "Enabled" : "Disabled") + " >";
	}
}

class AccuracyOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy Display < " + (!FlxG.save.data.accuracyDisplay ? "off" : "on") + " >";
	}
}

class SongPositionOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	public override function getValue():String
	{
		return "Song Position Bar: < " + (!FlxG.save.data.songPosition ? "off" : "on") + " >";
	}
}

class DistractionsAndEffectsOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.distractions = !FlxG.save.data.distractions;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Distractions: < " + (!FlxG.save.data.distractions ? "off" : "on") + " >";
	}
}

class Colour extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.colorBars = !FlxG.save.data.colorBars;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Colored HP Bars: < " + (FlxG.save.data.colorBars ? "off" : "on") + " >";
	}
}

class StepManiaOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.stepMania = !FlxG.save.data.stepMania;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Color Quantization: < " + (!FlxG.save.data.stepMania ? "off" : "on") + " >";
	}
}

class ResetButtonOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.resetButton = !FlxG.save.data.resetButton;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Reset Button: < " + (!FlxG.save.data.resetButton ? "off" : "on") + " >";
	}
}

class Shouldcameramove extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.noteCamera= !FlxG.save.data.noteCamera;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera: < " + (!FlxG.save.data.noteCamera ? "Static" : "Moving") + " >";
	}
}

class FlashingLightsOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.flashing = !FlxG.save.data.flashing;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Flashing Lights: < " + (!FlxG.save.data.flashing ? "off" : "on") + " >";
	}
}

class AntialiasingOption extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.globalAntialiasing = !FlxG.save.data.globalAntialiasing;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Antialiasing: < " + (!FlxG.save.data.globalAntialiasing ? "off" : "on") + " >";
	}
}

class MissSoundsOption extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.missSounds = !FlxG.save.data.missSounds;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Miss Sounds: < " + (!FlxG.save.data.missSounds ? "off" : "on") + " >";
	}
}

class ComboFlashModeOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.comboFlash = !FlxG.save.data.comboFlash;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Flash on Combo: < " + (!FlxG.save.data.comboFlash ? "off" : "on") + " >";
	}
}

class ComboSoundModeOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.comboSound = !FlxG.save.data.comboSound;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "GF Blup on Combo: < " + (!FlxG.save.data.comboSound ? "off" : "on") + " >";
	}
}

class SelfAwarenessOption extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.selfAwareness = !FlxG.save.data.selfAwareness;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Self Awareness: < " + (!FlxG.save.data.selfAwareness ? "Disabled" : "Enabled") + " >";
	}
}

class ShowInput extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.inputShow = !FlxG.save.data.inputShow;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Score Screen Debug: < " + (FlxG.save.data.inputShow ? "Enabled" : "Disabled") + " >";
	}
}

class Judgement extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		OptionsMenu.instance.selectedCatIndex = 6;
		OptionsMenu.instance.switchCat(OptionsMenu.instance.options[6], false);
		return true;
	}

	private override function updateDisplay():String
	{
		return "Edit Judgements";
	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast(Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Counter: < " + (!FlxG.save.data.disableFps ? "off" : "on") + " >";
	}
}

class CommunityGameMode extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.communityGameMode = !FlxG.save.data.communityGameMode;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Community Game: < " + (FlxG.save.data.communityGameMode ? "Enabled" : "Disabled") + " >";
	}
}

class ScoreScreen extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.scoreScreen = !FlxG.save.data.scoreScreen;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Score Screen: < " + (FlxG.save.data.scoreScreen ? "Enabled" : "Disabled") + " >";
	}
}

class BlurNotes extends Option
{
	public function new(desc:String)
	{
		super();
             
			description = desc;
	}

	public override function left():Bool
	{
           	 
		FlxG.save.data.blurNotes = !FlxG.save.data.blurNotes;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Notes: < " + (FlxG.save.data.blurNotes ? "Blured" : "UnBlured") + " >";
	}
}

class SmoothHealth extends Option
{
	public function new(desc:String)
	{
		super();
             
			description = desc;
	}

	public override function left():Bool
	{
           	 
		FlxG.save.data.smoothHealth = !FlxG.save.data.smoothHealth;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Health Tweening: < " + (FlxG.save.data.smoothHealth ? "Blured" : "UnBlured") + " >";
	}
}

class FPSCapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "FPS Cap: < " + FlxG.save.data.framerate + " >";
	}

	override function right():Bool
	{
		#if html5
		return false;
		#end
		if (FlxG.save.data.framerate >= 300)
		{
			FlxG.save.data.framerate = 300;
			(cast(Lib.current.getChildAt(0), Main)).setFPSCap(700);
		}
		else
			FlxG.save.data.framerate = FlxG.save.data.framerate + 10;
		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.framerate);

		return true;
	}

	override function left():Bool
	{
		#if html5
		return false;
		#end
		if (FlxG.save.data.framerate > 300)
			FlxG.save.data.framerate = 300;
		else if (FlxG.save.data.framerate < 60)
			FlxG.save.data.framerate = Application.current.window.displayMode.refreshRate;
		else
			FlxG.save.data.framerate = FlxG.save.data.framerate - 10;
				(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.framerate);
		return true;
	}

	override function getValue():String
	{
		return updateDisplay();
	}
}

class RainbowFPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.fpsRain = !FlxG.save.data.fpsRain;
		(cast (Lib.current.getChildAt(0), Main)).changeFPSColor(FlxColor.WHITE);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Rainbow: < " + (!FlxG.save.data.fpsRain ? "off" : "on") + " >";
	}
}

class NPSDisplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "NPS Display: < " + (!FlxG.save.data.npsDisplay ? "off" : "on") + " >";
	}
}

class AccTypeOption extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.ratingSystemNum--;
		if (FlxG.save.data.ratingSystemNum < 0)
		FlxG.save.data.ratingSystemNum = OptionsHelpers.AccuracyTypeArray.length - 6;
     OptionsHelpers.ChangeAccType(FlxG.save.data.ratingSystemNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.ratingSystemNum++;
		if (FlxG.save.data.ratingSystemNum > OptionsHelpers.AccuracyTypeArray.length - 1)
			FlxG.save.data.ratingSystemNum = OptionsHelpers.AccuracyTypeArray.length - 1;
                  OptionsHelpers.ChangeAccType(FlxG.save.data.ratingSystemNum);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Current Accuracy Type: < " + OptionsHelpers.getAccTypeID(FlxG.save.data.ratingSystemNum) + " >";
	}
}

class TimeBarType extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
 
		FlxG.save.data.timeBarTypeNum--;
		if (FlxG.save.data.timeBarTypeNum < 0)
		FlxG.save.data.timeBarTypeNum = OptionsHelpers.TimeBarArray.length - 3;
     OptionsHelpers.ChangeTimeBar(FlxG.save.data.timeBarTypeNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
 
		FlxG.save.data.timeBarTypeNum++;
		if (FlxG.save.data.timeBarTypeNum > OptionsHelpers.TimeBarArray.length - 1)
			FlxG.save.data.timeBarTypeNum = OptionsHelpers.TimeBarArray.length - 1;
                  OptionsHelpers.ChangeTimeBar(FlxG.save.data.timeBarTypeNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Time bar type: < " + OptionsHelpers.getTimeBarByID(FlxG.save.data.timeBarTypeNum) + " >";
	}
}

class BorderFps extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.fpsBorder = !FlxG.save.data.fpsBorder;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Border: < " + (!FlxG.save.data.fpsBorder ? "off" : "on") + " >";
	}
}

class DisplayMemory extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.memoryDisplay = !FlxG.save.data.memoryDisplay;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Memory Display: < " + (!FlxG.save.data.memoryDisplay ? "off" : "on") + " >";
	}
}

class BotPlay extends Option
{
	public function new(desc:String)
	{
		super();
		if (PlayState.isStoryMode)
			description = 'BOTPLAY is disabled on Story Mode.'
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (PlayState.isStoryMode)
			return false;
		FlxG.save.data.botplay = !FlxG.save.data.botplay;
		trace('BotPlay : ' + FlxG.save.data.botplay);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
		return "BotPlay: < " + (FlxG.save.data.botplay ? "on" : "off") + " >";
}

class  PMode extends Option
{
	public function new(desc:String)
	{
		super();
		if (PlayState.isStoryMode)
			description = 'Practice Mode is disabled on Story Mode.'
		else
			description = desc;
	}

	public override function left():Bool
	{
		if (PlayState.isStoryMode)
			return false;
		FlxG.save.data.pMode = !FlxG.save.data.pMode;
		trace('Practice Mode : ' + FlxG.save.data.pMode);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
		return "Practice Mode: < " + (FlxG.save.data.pMode ? "on" : "off") + " >";
}

class CompactNumbers extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.compactNumbers = !FlxG.save.data.compactNumbers;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
		return "Compact UI Numbers: < " + (!FlxG.save.data.compactNumbers ? "off" : "on") + " >";
}

class FreeplayCutscenesOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.freeplayCuts = !FlxG.save.data.freeplayCuts;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Freeplay Cutscene: < " + (!FlxG.save.data.freeplayCuts ? "off" : "on") + " >";
	}
}

class EyesoresOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.eyesores = !FlxG.save.data.eyesores;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Eyesores: < " + (!FlxG.save.data.eyesores ? "off" : "on") + " >";
	}
}

class DevMode extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
		{
			FlxG.save.data.devMode = !FlxG.save.data.devMode;
	
			display = updateDisplay();
			return true;
		}
	
		public override function right():Bool
		{
			left();
			return true;
		}

	private override function updateDisplay():String
	{
		return "Dev: < " + (!FlxG.save.data.devMode ? "off" : "on") + " >";
	}
}

class ColorQuantization extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
		{
			FlxG.save.data.colorQ = !FlxG.save.data.colorQ;
	
			display = updateDisplay();
			return true;
		}
	
		public override function right():Bool
		{
			left();
			return true;
		}

	private override function updateDisplay():String
	{
		return "Color Quantization: < " + (!FlxG.save.data.colorQ ? "off" : "on") + " >";
	}
}

class TransparentScore extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
		{
			FlxG.save.data.thebetterscore = !FlxG.save.data.thebetterscore;
	
			display = updateDisplay();
			return true;
		}
	
		public override function right():Bool
		{
			left();
			return true;
		}

	private override function updateDisplay():String
	{
		return "Transparent Score and Jud Counter: < " + (!FlxG.save.data.thebetterscore ? "off" : "on") + " >";
	}
}


class PlayerStrums extends Option
{
	public function new(desc:String)
		{
			super();
			description = desc;
		}
	
		public override function left():Bool
		{
			FlxG.save.data.PlayerStrums = !FlxG.save.data.PlayerStrums;
	
			display = updateDisplay();
			return true;
		}
	
		public override function right():Bool
		{
			left();
			return true;
		}
	
		private override function updateDisplay():String
		{
			return "Player Strums: < " + (!FlxG.save.data.PlayerStrums ? "Light up" : "Stay static") + " >";
		}
	}

class KadeInputOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.kadeInput = !FlxG.save.data.kadeInput;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Input System: < " + (!FlxG.save.data.kadeInput ? "VDAB Input" : "Kade Input") + " >";
	}
}

class CamZoomOption extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.camzoom = !FlxG.save.data.camzoom;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Camera Zoom: < " + (!FlxG.save.data.camzoom ? "off" : "on") + " >";
	}
}

class GreenScreenMode extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		 
		FlxG.save.data.greenscreenmode = !FlxG.save.data.greenscreenmode;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Green screen: < " + (!FlxG.save.data.greenscreenmode ? "off" : "on") + " >";
	}
}

class ScoreZoom extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.scoreZoom = !FlxG.save.data.scoreZoom;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Score zomming in beats: < " + (FlxG.save.data.scoreZoom ? "Enabled" : "Disabled") + " >";
	}
}

class HideHud extends Option
{
	public function new(desc:String)
	{
		super();
             
			description = desc;

	}

	public override function left():Bool
	{
              	 
		FlxG.save.data.hideHud = !FlxG.save.data.hideHud;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "HUD: < " + (FlxG.save.data.hideHud ? "Hided" : "Shown") + " >";
	}
}

class SSmoothHealthArray extends Option
{
	public function new(desc:String)
	{
		super();
             
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.smoothHealthTypeNum--;
		if (FlxG.save.data.smoothHealthTypeNum < 0)
		FlxG.save.data.smoothHealthTypeNum = OptionsHelpers.SmoothHealthArray.length - 1;
     OptionsHelpers.ChangeSmoothHealth(FlxG.save.data.smoothHealthTypeNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.smoothHealthTypeNum++;
		if (FlxG.save.data.smoothHealthTypeNum > OptionsHelpers.SmoothHealthArray.length - 1)
			FlxG.save.data.smoothHealthTypeNum = OptionsHelpers.SmoothHealthArray.length - 1;
                  OptionsHelpers.ChangeSmoothHealth(FlxG.save.data.smoothHealthTypeNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Health Tween Type: < " + OptionsHelpers.getSmoothHealthByID(FlxG.save.data.smoothHealthTypeNum) + " >";
	}
}

class IconBop extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.hliconbopNum--;
		if (FlxG.save.data.hliconbopNum < 0)
		FlxG.save.data.hliconbopNum = OptionsHelpers.IconsBopArray.length - 1;
     OptionsHelpers.ChangeIconBop(FlxG.save.data.hliconbopNum);
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.hliconbopNum++;
		if (FlxG.save.data.hliconbopNum > OptionsHelpers.IconsBopArray.length - 1)
			FlxG.save.data.hliconbopNum = OptionsHelpers.IconsBopArray.length - 1;
                  OptionsHelpers.ChangeIconBop(FlxG.save.data.hliconbopNum);
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Icon bopping type: < " + OptionsHelpers.getIconBopByID(FlxG.save.data.hliconbopNum) + " >";
	}
}

class InstaRestart extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.instaRestart = !FlxG.save.data.instaRestart;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Instant Respawn: < " + (FlxG.save.data.instaRestart ? "On" : "Off") + " >";
	}
}

class GhostDouble extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.doubleGhost = !FlxG.save.data.doubleGhost;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Combo Sprite: < " + (FlxG.save.data.doubleGhost ? "On" : "Off") + " >";
	}
}

class ShowCombo extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.showCombo = !FlxG.save.data.showCombo;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Combo Sprite: < " + (FlxG.save.data.showCombo ? "Shown" : "Hided") + " >";
	}
}

class JudgementCounter extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.judgementCounter = !FlxG.save.data.judgementCounter;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Judgement Counter: < " + (FlxG.save.data.judgementCounter ? "Enabled" : "Disabled") + " >";
	}
}

class MoreMaxHP extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.moreMaxHP = !FlxG.save.data.moreMaxHP;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "More Max Health: < " + (FlxG.save.data.moreMaxHP ? "Enabled" : "Disabled") + " >";
	}
}

class MiddleScrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.middleScroll = !FlxG.save.data.middleScroll;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Middle Scroll: < " + (FlxG.save.data.middleScroll ? "Enabled" : "Disabled") + " >";
	}
}

class NoteClickOppoOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.donoteclickoppo = !FlxG.save.data.donoteclickoppo;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Note Click Opponent: < " + (!FlxG.save.data.donoteclickoppo ? "Enabled" : "Disabled") + " >";
	}
}

class HitSoundOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.hitSound--;
		if (FlxG.save.data.hitSound < 0)
			FlxG.save.data.hitSound = HitSounds.getSound().length - 1;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.hitSound++;
		if (FlxG.save.data.hitSound > HitSounds.getSound().length - 1)
			FlxG.save.data.hitSound = 0;
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Hitsound Style: < " + HitSounds.getSoundByID(FlxG.save.data.hitSound) + " >";
	}
}

class HitSoundVolume extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;

		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Hitsound Volume: < " + HelperFunctions.truncateFloat(FlxG.save.data.hitVolume, 1) + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.hitVolume += 0.1;

		if (FlxG.save.data.hitVolume < 0)
			FlxG.save.data.hitVolume = 0;

		if (FlxG.save.data.hitVolume > 1)
			FlxG.save.data.hitVolume = 1;
		return true;
	}

	override function getValue():String
	{
		return "Hitsound Volume: < " + HelperFunctions.truncateFloat(FlxG.save.data.hitVolume, 1) + " >";
	}

	override function left():Bool
	{
		FlxG.save.data.hitVolume -= 0.1;

		if (FlxG.save.data.hitVolume < 0)
			FlxG.save.data.hitVolume = 0;

		if (FlxG.save.data.hitVolume > 1)
			FlxG.save.data.hitVolume = 1;

		return true;
	}
}

class SafeFrames extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;

		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Safe Frames: < " + FlxG.save.data.safeFrames + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.safeFrames += 1;

		if (FlxG.save.data.safeFrames < 2)
			FlxG.save.data.safeFrames = 2;

		if (FlxG.save.data.safeFrames > 10)
			FlxG.save.data.safeFrames = 10;
		return true;
	}

	override function getValue():String
	{
		return "Safe Frames: < " + FlxG.save.data.safeFrames + " >";
	}

	override function left():Bool
	{
		FlxG.save.data.safeFrames -= 1;

		if (FlxG.save.data.safeFrames < 2)
			FlxG.save.data.safeFrames = 2;

		if (FlxG.save.data.hitVolume > 10)
			FlxG.save.data.safeFrames = 10;

		return true;
	}
}

class Background extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.background = !FlxG.save.data.background;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Background Stage: < " + (FlxG.save.data.background ? "Enabled" : "Disabled") + " >";
	}
}

class OptimizeOption extends Option
{
	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function left():Bool
	{
		 
		FlxG.save.data.optimize = !FlxG.save.data.optimize;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Optimization: < " + (FlxG.save.data.optimize ? "Enabled" : "Disabled") + " >";
	}
}

class RotateSpritesOption extends Option
{
	public function new(desc:String)
	{
		super();
		 
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.rotateSprites = !FlxG.save.data.rotateSprites;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Rotate Sprites: < " + (FlxG.save.data.rotateSprites ? "Enabled" : "Disabled") + " >";
	}
}

class LaneUnderlayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	private override function updateDisplay():String
	{
		return "Lane Transparceny: < " + HelperFunctions.truncateFloat(FlxG.save.data.laneTransparency, 1) + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.laneTransparency += 0.1;

		if (FlxG.save.data.laneTransparency > 1)
			FlxG.save.data.laneTransparency = 1;
		return true;
	}

	override function left():Bool
	{
		FlxG.save.data.laneTransparency -= 0.1;

		if (FlxG.save.data.laneTransparency < 0)
			FlxG.save.data.laneTransparency = 0;

		return true;
	}
}

class MicedUpSusOption extends Option
{
	public function new(desc:String)
	{
		super();
             
			description = desc;

	}

	public override function left():Bool
	{
              	 
		FlxG.save.data.micedUpSus = !FlxG.save.data.micedUpSus;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "MicedUp Sustains Filter: < " + (FlxG.save.data.micedUpSus ? "Enabled" : "Disabled") + " >";
	}
}

class Shaders extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		 

		FlxG.save.data.shaders = !FlxG.save.data.shaders;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Shaders: < " + (FlxG.save.data.shaders ? "On" : "Off") + " >";
	}
}

class CompatMode extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		 

		FlxG.save.data.compatMode = !FlxG.save.data.compatMode;

		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "compat Mode: < " + (FlxG.save.data.compatMode ? "On" : "Off") + " >";
	}
}

class DebugMode extends Option
{
	public function new(desc:String)
	{
		description = desc;
		super();
	}

	public override function press():Bool
	{
		FlxG.switchState(new AnimationDebug());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Animation Debug";
	}
}

class LockWeeksOption extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function press():Bool
	{
		 
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.weekUnlocked = 1;
		StoryMenuState.weekUnlocked = [true, true];
		confirm = false;
		trace('Weeks Locked');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Story Reset" : "Reset Story Progress";
	}
}

/*class ResetModifiersOption extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function press():Bool
	{
		 
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}

		SaveDataHandler.resetModifiers();
		confirm = false;
		trace('Modifiers went brrrr');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Modifiers reset" : "Reset Modifiers";
	}
}

class ResetScoreOption extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function press():Bool
	{
		 
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.songScores = null;
		for (key in Highscore.songScores.keys())
		{
			Highscore.songScores[key] = 0;
		}
		FlxG.save.data.songCombos = null;
		for (key in Highscore.songCombos.keys())
		{
			Highscore.songCombos[key] = '';
		}
		FlxG.save.data.songAcc = null;
		for (key in Highscore.songAcc.keys())
		{
			Highscore.songAcc[key] = 0.00;
		}
		confirm = false;
		trace('Highscores Wiped');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Score Reset" : "Reset Score";
	}
}*/

class QualityLow extends Option
{
	public function new(desc:String)
	{
		super();
             
			description = desc;
	}

	public override function left():Bool
	{
             		 
		FlxG.save.data.lowQuality = !FlxG.save.data.lowQuality;
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		left();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Low Quality: < " + (!FlxG.save.data.lowQuality ? "off" : "on") + " >";
	} 
}

class ColorBlindOption extends Option
{
	public function new(desc:String)
	{
		super();
			description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.ColorBlindTypeNum--;
		if (FlxG.save.data.ColorBlindTypeNum < 0)
		FlxG.save.data.ColorBlindTypeNum = OptionsHelpers.ColorBlindArray.length - 1;
        OptionsHelpers.ChangeColorBlind(FlxG.save.data.ColorBlindTypeNum);
		ColorblindFilters.applyFiltersOnGame();
		display = updateDisplay();
		return true;
	}

	public override function right():Bool
	{
		FlxG.save.data.ColorBlindTypeNum++;
		if (FlxG.save.data.ColorBlindTypeNum > OptionsHelpers.ColorBlindArray.length - 1)
			FlxG.save.data.ColorBlindTypeNum = OptionsHelpers.ColorBlindArray.length - 4;
                  OptionsHelpers.ChangeColorBlind(FlxG.save.data.ColorBlindTypeNum);
				  ColorblindFilters.applyFiltersOnGame();
		display = updateDisplay();
		return true;
	}

	public override function getValue():String
	{
		return "Color Blindness Type: < " + OptionsHelpers.getColorBlindByID(FlxG.save.data.ColorBlindTypeNum) + " >";
	}
}

class ResetSettings extends Option
{
	var confirm:Bool = false;

	public function new(desc:String)
	{
		super();
	 
			description = desc;
	}

	public override function press():Bool
	{
		 
		if (!confirm)
		{
			confirm = true;
			display = updateDisplay();
			return true;
		}
		FlxG.save.data.weekUnlocked = null;
		FlxG.save.data.background = null;
		FlxG.save.data.newInput = null;
		FlxG.save.data.downscroll = null;
		FlxG.save.data.antialiasing = null;
		FlxG.save.data.missSounds = null;
		FlxG.save.data.dfjk = null;
		FlxG.save.data.accuracyDisplay = null;
		FlxG.save.data.offset = null;
		FlxG.save.data.songPosition = null;
		FlxG.save.data.fps = null;
		FlxG.save.data.changedHit = null;
		FlxG.save.data.fpsRain = null;
		FlxG.save.data.framerate = null;
		FlxG.save.data.npsDisplay = null;
		FlxG.save.data.frames = null;
		FlxG.save.data.accuracyMod = null;
		FlxG.save.data.watermark = null;
		FlxG.save.data.ghost = null;
		FlxG.save.data.distractions = null;
		FlxG.save.data.colorBars = null;
		FlxG.save.data.stepMania = null;
		FlxG.save.data.flashing = null;
		FlxG.save.data.resetButton = null;
		FlxG.save.data.botplay = null;
		FlxG.save.data.roundAccuracy = null;
		FlxG.save.data.cpuStrums = null;
		FlxG.save.data.strumline = null;
		FlxG.save.data.customStrumLine = null;
		FlxG.save.data.camzoom = null;
		FlxG.save.data.scoreScreen = null;
		FlxG.save.data.inputShow = null;
		FlxG.save.data.optimize = null;
		FlxG.save.data.cacheImages = null;
		FlxG.save.data.editor = null;
		FlxG.save.data.laneTransparency = 0;
		FlxG.save.data.middleScroll = null;
		FlxG.save.data.instantRespawn = null;
		FlxG.save.data.memoryDisplay = null;
		FlxG.save.data.noteskin = null;
		FlxG.save.data.lerpScore = null;
		FlxG.save.data.hitSound = null;
		FlxG.save.data.hitVolume = null;
		FlxG.save.data.volume = null;
		FlxG.save.data.mute = null;
		FlxG.save.data.showCombo = null;
		FlxG.save.data.showComboNum = null;

		SaveDataHandler.initSave();
		confirm = false;
		trace('All settings have been reset');
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return confirm ? "Confirm Settings Reset" : "Reset Settings";
	}
}
