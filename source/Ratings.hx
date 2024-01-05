import flixel.FlxG;

class Ratings
{
	public static var timingWindows = [];

	public static function judgeNote(noteDiff:Float)
	{
		var diff = Math.abs(noteDiff);
		for (index in 0...timingWindows.length) // based on 4 timing windows, will break with anything else
		{
			var time = timingWindows[index];
			var nextTime = index + 1 > timingWindows.length - 1 ? 0 : timingWindows[index + 1];
			if (diff < time && diff >= nextTime)
			{
				switch (index)
				{
					case 0: // shit
						return "shit";
					case 1: // bad
						return "bad";
					case 2: // good
						return "good";
					case 3: // sick
						return "sick";
				}
			}
		}
		return "good";
	}
}
