package;
#if FEATURE_FILESYSTEM
import sys.FileSystem;
import sys.io.File;
#end
import openfl.display.BitmapData;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

using StringTools;

class OptionsHelpers
{
	public static var noteskinArray = ["Default", "Chip", "Future", "Grafex"];
        public static var IconsBopArray = ['Dave and Bambi Plus', 'Dave and Bambi', 'Golden Apple', 'Bambi Purgatory', 'Grafex', 'Old Psych', 'New Psych', 'VS Steve'];
        public static var TimeBarArray = ['Time Left', 'Time Elapsed', 'Disabled'];
        public static var SmoothHealthArray = ['Golden Apple 1.5', 'Indie Cross'];
        public static var ColorBlindArray = ['None', 'Deuteranopia', 'Protanopia', 'Tritanopia'];
        public static var AccuracyTypeArray = ['Grafex', 'Kade', 'Mania', 'Andromeda', 'Leather', 'Mic\'d Up', 'Project FNF (0.4a)', 'Forever', 'Cube', 'Furry', '0x9', 'Psych', 'Strident Crisis', 'Unknown', 'No Botplay Lag', 'Lore', 'Joalor64', 'Theoyeah', '900n1', 'Denpa', 'Blueberry', 'OS'];
//
	/*public static function getNoteskinByID(id:Int)
	{
		return noteskinArray[id];
	}
        static public function ChangeNoteSkin(id:Int)
        {
                FlxG.save.data.noteSkin = getNoteskinByID(id);
        }*/
//

        public static function getSmoothHealthByID(id:Int)
	{
		return SmoothHealthArray[id];
	}
        static public function ChangeSmoothHealth(id:Int)
        {
                FlxG.save.data.smoothHealthType = getSmoothHealthByID(id);
        }
//
        public static function getIconBopByID(id:Int)
	{
		return IconsBopArray[id];
	}
        static public function ChangeIconBop(id:Int)
        {
                FlxG.save.data.iconBounceType = getIconBopByID(id);
        }
//
        public static function getTimeBarByID(id:Int)
	{
		return TimeBarArray[id];
	}
        static public function ChangeTimeBar(id:Int)
        {
                FlxG.save.data.timeBarType = getTimeBarByID(id);
        }
//
        public static function getColorBlindByID(id:Int)
        {
                        return ColorBlindArray[id];
        }
        static public function ChangeColorBlind(id:Int)
        {
                FlxG.save.data.ColorBlindType = getColorBlindByID(id);
        }
//
        public static function getAccTypeID(id:Int)
        {
                        return AccuracyTypeArray[id];
        }
        static public function ChangeAccType(id:Int)
        {
                FlxG.save.data.ratingSystem = getAccTypeID(id);
        }

}