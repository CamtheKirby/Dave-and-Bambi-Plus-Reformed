package;

import flixel.group.FlxGroup;
import flixel.FlxG;
import openfl.utils.AssetCache;
import flixel.math.FlxRandom;
import flixel.math.FlxMath;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

class CoolUtil
{
	public static var difficultyArray:Array<String> = new Array<String>();
	public static var exploitationDifficulties:Array<String> = ["YOU'RE FUCKED", 'HAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHAHA', "YOU CAN'T ESCAPE FROM THE FUN ALREADY", 
	"EXPUNGED'S REIGN IS HERE, YOU'RE FUCKED", "YOU HAVE REACHED THE END OF THE RABBIT HOLE", "YOU'RE WORTHLESS YOU'RE WORTHLESS YOU'RE WORTHLESS YOU'RE WORTHLESS YOU'RE WORTHLESS", ];
	public static var CurSongDiffs:Array<String> = ["NORMAL"];

	public static function init()
	{
		difficultyArray = new Array<String>();
		difficultyArray.push(LanguageManager.getTextString('play_easy'));
		difficultyArray.push(LanguageManager.getTextString('play_normal'));
		difficultyArray.push('Mania');
	}
	public static function difficultyString2():String
		{
			return CurSongDiffs[PlayState.storyDifficulty];
		}

	public static function difficultyString():String
	{
		switch (PlayState.storyWeek)
		{
			case 3:
				return 'FINALE';
			case 16:
				return exploitationDifficulties[new FlxRandom().int(0, exploitationDifficulties.length - 1)];
			default:
				if (PlayState.shaggyVoice && PlayState.storyDifficulty == 0) return 'Canon';
				return difficultyArray[PlayState.storyDifficulty];

		}
	}

	public static function coolTextFile(path:String):Array<String>
	{
		#if sys
		var daList:Array<String> = File.getContent(path).trim().split('\n');
		#else
		var daList:Array<String> = Assets.getText(path).trim().split('\n');
		#end

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}
		return daList;
	}

/*	public static function plainTextFile(path:String)
		{
			#if sys
			var daText:String = File.getContent(path).trim();
			#else
			var daText:String = Assets.getText(path).trim();
			#end

			return daText;
		} */


	/*public static function getSongFromJsons(jsonInput:String, diff:Int)
		{
		var rawJson = "";
		rawJson = Assets.getText(Paths.chartCustom(jsonInput.toLowerCase())).trim();
		var	path = "";
		path = "assets/data/customCharts/" + rawJson; 
		#if sys
		var diffs:Array<String> = [''];
		var sortedDiffs:Array<String> = ['']; 
		var textDiffs:Array<String> = [];
		var outputDiffs:Array<String> = [];
		if (FileSystem.exists(rawJson))
			{
			    diffs = FileSystem.readDirectory(rawJson);
				var normal:String = "";
				
				for (file in diffs)
					{
						if (file.endsWith(".json")) 
						{
							if (!file.endsWith(".json")) //get rid of non json files
								diffs.remove(file);
							else if (file.endsWith(rawJson + ".json")) //add normal
								{
									normal = file;
								}
						}
						
						if (normal != "")
							{
								sortedDiffs.push(normal);
								textDiffs.push("Normal");
							}
							
			for (file in sortedDiffs)
			{
				var noJson = StringTools.replace(file,".json", "");
				var noSongName = StringTools.replace(noJson,jsonInput.toLowerCase(), "");
				outputDiffs.push(noSongName); //gets just the difficulty on the end of the file
			}
			CurSongDiffs = textDiffs;
			if (diff > outputDiffs.length)
				diff = outputDiffs.length;

			}
	}
	return rawJson + outputDiffs[diff];
	#else

	#end
} */
	
	public static function coolStringFile(path:String):Array<String>
		{
			var daList:Array<String> = path.trim().split('\n');
	
			for (i in 0...daList.length)
			{
				daList[i] = daList[i].trim();
			}
	
			return daList;
		}

	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
	public static function formatString(string:String, separator:String):String
	{
		var split:Array<String> = string.split(separator);
		var formattedString:String = '';
		for (i in 0...split.length)
		{
			var piece:String = split[i];
			var allSplit = piece.split('');
			var firstLetterUpperCased = allSplit[0].toUpperCase();
			var substring = piece.substr(1, piece.length - 1);
			var newPiece = firstLetterUpperCased + substring;
			if (i != split.length - 1)
			{
				newPiece += " ";
			}
			formattedString += newPiece;
		}
		return formattedString;
	}
	public static function getMinAndMax(value1:Float, value2:Float):Array<Float>
	{
		var minAndMaxs = new Array<Float>();

		var min = Math.min(value1, value2);
		var max = Math.max(value1, value2);

		minAndMaxs.push(min);
		minAndMaxs.push(max);
		
		return minAndMaxs;
	}

	inline public static function boundTo(value:Float, min:Float, max:Float):Float {
		return Math.max(min, Math.min(max, value));
	}

	public static function cacheImage(image:String)
	{
		Assets.cache.image.set(image, lime.graphics.Image.fromFile(image));
	}
	public static function isArrayEqualTo(array1:Array<Dynamic>, array2:Array<Dynamic>)
	{
		if (array1.length != array2.length)
		{
			return false;
		}
		else
		{
			for (i in 0...array2.length)
			{
				if (array1[i] != array2[i])
				{
					return false;
				}
			}
		}
		return true;
	}
}
