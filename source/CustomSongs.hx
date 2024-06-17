/*package;
// CUSTOM STUFF LETS GOOOOO!
import lime.utils.Assets;
import openfl.utils.Assets as OpenFlAssets;
import haxe.Json;
import FreeplayState;
import sys.FileSystem;
import sys.io.File;

typedef SongsFile =
{
	// JSON variables
	var songs:Array<Dynamic>;
	var weekNum:Int;
	var songCharacters:Array<String>;
}

class SongData {
	public var songsLoaded:Map<String, SongData> = new Map<String, SongData>();
	public static var songsList:Array<String> = [];
	public var folder:String = '';
	
	// JSON variables
	var songs:Array<String>;
	var weekNum:Int;
	var songCharacters:Array<String>;

	public var fileName:String;

	public static function createSongFile():SongsFile {
		var songFile:SongsFile = {
			songs: ['Warmup'],
            weekNum: 0,
            songCharacters: ['dave']
		};
		return songFile;
	}

	// HELP: Is there any way to convert a WeekFile to WeekData without having to put all variables there manually? I'm kind of a noob in haxe lmao
	public function new(songFile:SongsFile, fileName:String) {
		// here ya go - MiguelItsOut
		for (field in Reflect.fields(songFile)) {
			Reflect.setProperty(this, field, Reflect.getProperty(songFile, field));
		}

		this.fileName = fileName;
	}
}

function addCustomSong(songToCheck:String, path:String, directory:String, i:Int, originalLength:Int)
	{
		if(!songsLoaded.exists(songToCheck))
		{
			var song:SongsFile = getSongFile(path);
			if(song != null)
			{
				var weekFile:SongData = new SongData(song, songToCheck);
				if(i >= originalLength)
				{
					weekFile.folder = directory.substring(Paths.mods().length, directory.length-1);
				}
			}
		}
	}

    var songsLoaded:Map<String, SongData> = new Map<String, SongData>();

    private function getSongFile(path:String):SongsFile {
		var rawJson:String = null;
		
		if(FileSystem.exists(path)) {
			rawJson = File.getContent(path);
		}

		if(rawJson != null && rawJson.length > 0) {
			return cast tjson.TJSON.parse(rawJson); // use haxelib install tjson 1.4.0 btw
		}
		return null;
	} */
