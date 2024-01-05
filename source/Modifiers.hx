package;

import lime.app.Application;
import lime.system.DisplayMode;
import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;
import flixel.addons.ui.FlxUINumericStepper;
#if FEATURE_DISCORD
import Discord.DiscordClient;
#end

// Used Options.hx code template to make this. Go to FreeplaySubState.hx to see the menu code :D
class Modifier
{
	public function new()
	{
		display = updateDisplay();
	}

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

class Sustains extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.sustains = !FlxG.save.data.sustains;

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
		return "Hold Notes: < " + (FlxG.save.data.sustains ? "on" : "off") + " >";
	}
}

class PlaybackRate extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.randomspeed = !FlxG.save.data.randomspeed;

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
		return "Playback Rate: < " + (FlxG.save.data.randomspeed ? "on" : "off") + " >";
	}
}

class Modchart extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.modchart = !FlxG.save.data.modchart;

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
		return "Modchart: < " + (FlxG.save.data.modchart ? "off" : "on") + " >";
	}
}
class RandomScrollSpeed extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
		{
			FlxG.save.data.rns = !FlxG.save.data.rns;
	
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
		return "Unfairness Note Speed: < " + (!FlxG.save.data.rns ? "off" : "on") + " >";
	}
}
class OpponentMode extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.opponent = !FlxG.save.data.opponent;

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
		return "Opponent Mode: < " + (FlxG.save.data.opponent ? "on" : "off") + " >";
	}
}

class HealthDrain extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.hdrain = !FlxG.save.data.hdrain;

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
		return "Health Drain: < " + (FlxG.save.data.hdrain ? "on" : "off") + " >";
	}
}

class HealthGain extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function right():Bool
	{
		FlxG.save.data.hgain += 0.1;

		if (FlxG.save.data.hgain < 0)
			FlxG.save.data.hgain = 0;

		if (FlxG.save.data.hgain > 3)
			FlxG.save.data.hgain = 3;
		return true;
	}

	public override function left():Bool
	{
		FlxG.save.data.hgain -= 0.1;

		if (FlxG.save.data.hgain < 0)
			FlxG.save.data.hgain = 0;

		if (FlxG.save.data.hgain > 3)
			FlxG.save.data.hgain = 3;
		return true;
	}

	override function getValue():String
	{
		return "HP Gain Multiplier: < " + HelperFunctions.truncateFloat(FlxG.save.data.hgain, 1) + "x >";
	}

	private override function updateDisplay():String
	{
		return "HP Gain Multiplier: < " + HelperFunctions.truncateFloat(FlxG.save.data.hgain, 1) + "x >";
	}
}

class HealthLoss extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function right():Bool
	{
		FlxG.save.data.hloss += 0.1;

		if (FlxG.save.data.hloss < 0)
			FlxG.save.data.hloss = 0;

		if (FlxG.save.data.hloss > 3)
			FlxG.save.data.hloss = 3;
		return true;
	}

	public override function left():Bool
	{
		FlxG.save.data.hloss -= 0.1;

		if (FlxG.save.data.hloss < 0)
			FlxG.save.data.hloss = 0;

		if (FlxG.save.data.hloss > 3)
			FlxG.save.data.hloss = 3;
		return true;
	}

	override function getValue():String
	{
		return "HP Loss Multiplier: < " + HelperFunctions.truncateFloat(FlxG.save.data.hloss, 1) + "x >";
	}

	private override function updateDisplay():String
	{
		return "HP Loss Multiplier: < " + HelperFunctions.truncateFloat(FlxG.save.data.hloss, 1) + "x >";
	}
}

class Jacks extends Modifier
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
		return "Jack Amount: < " + HelperFunctions.truncateFloat(FlxG.save.data.jackingtime, 1) + " >";
	}

	override function right():Bool
	{
		FlxG.save.data.jackingtime += 1;

		if (FlxG.save.data.jackingtime < 0)
			FlxG.save.data.jackingtime = 0;

		if (FlxG.save.data.jackingtime > 20)
			FlxG.save.data.jackingtime = 20;
		return true;
	}

	override function getValue():String
	{
		return "Jack Amount: < " + HelperFunctions.truncateFloat(FlxG.save.data.jackingtime, 1) + " >";
	}

	override function left():Bool
	{
		FlxG.save.data.jackingtime -= 1;

		if (FlxG.save.data.jackingtime < 0)
			FlxG.save.data.jackingtime = 0;

		if (FlxG.save.data.jackingtime > 20)
			FlxG.save.data.jackingtime = 20;

		return true;
	}
}

class MainaNotes extends Modifier
{

	public function new(desc:String)
	{
		super();
		description = desc;

		acceptValues = true;
	}

	private override function updateDisplay():String
	{
		return "Added Mania Notes: < " + HelperFunctions.truncateFloat(FlxG.save.data.mainaNotesLoly, 1) + " >";
	}


	override function getValue():String
	{
		return "Added Mania Notes: < " + HelperFunctions.truncateFloat(FlxG.save.data.mainaNotesLoly, 1) + " >";
	}

	public override function press():Bool
		{
		//	trace('AHHHHHHH : ' + HelperFunctions.truncateFloat(FlxG.save.data.mainaNotesLoly, 1)); // why does this say zero multipe times
			FlxG.save.data.mainaNotesLoly += 1;
			if (FlxG.save.data.mainaNotesLoly > 5) 
				FlxG.save.data.mainaNotesLoly = 0;
			
			return true;
		}

		
} 

class Mirror extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.mirror = !FlxG.save.data.mirror;

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
		return "Mirror mode: < " + (FlxG.save.data.mirror ? "on" : "off") + " >";
	}
}

class Random extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.random = !FlxG.save.data.random;

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
		return "Randomly Charts mode: < " + (FlxG.save.data.random ? "on" : "off") + " >";
	}
}

class Stair extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.stair = !FlxG.save.data.stair;

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
		return "Stair mode: < " + (FlxG.save.data.stair ? "on" : "off") + " >";
	}
}

class OneArrow extends Modifier
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function left():Bool
	{
		FlxG.save.data.onearrow = !FlxG.save.data.onearrow;

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
		return "One Arrow mode: < " + (FlxG.save.data.onearrow ? "on" : "off") + " >";
	}
}
