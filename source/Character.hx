package;

import sys.FileSystem;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxEase;


using StringTools;

class Character extends FlxSprite
{
	public var mostRecentRow:Int = 0;
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = 'bf';

	public var holdTimer:Float = 0;
	public var furiosityScale:Float = 1.02;
	public var singDuration:Float = 4; // Multiplier of how long a character holds the sing pose
	public var canDance:Bool = true;

	public var nativelyPlayable:Bool = false;

	public var globalOffset:Array<Float> = new Array<Float>();
	public var offsetScale:Float = 1;
	
	public var barColor:FlxColor;
	
	public var canSing:Bool = true;
	public var skins:Map<String, String> = new Map<String, String>();

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		skins.set('normal', curCharacter);
		skins.set('recursed', 'bf-recursed');
		skins.set('gfSkin', 'gf-none');
		
		antialiasing = FlxG.save.data.globalAntialiasing;

		switch (curCharacter)
		{
			case 'bf':
				frames = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				loadOffsetFile(curCharacter);

				skins.set('gfSkin', 'gf');
				skins.set('3d', 'bf-3d');

				barColor = FlxColor.fromRGB(49, 176, 209);

				playAnim('idle');

				nativelyPlayable = true;

				flipX = true;
			case 'bf-3d':
				frames = Paths.getSparrowAtlas('characters/3d_bf', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);	
				}
				loadOffsetFile(curCharacter);
				
				globalOffset = [-85, -272];
				barColor = FlxColor.fromRGB(49, 176, 209);

				playAnim('idle');
				antialiasing = false;
				nativelyPlayable = true;
				flipX = true;

			case 'bf-cool':
				frames = Paths.getSparrowAtlas('characters/Cool_BF', 'shared');
				
				animation.addByPrefix('idle', 'BFIdle', 24, false);
				for (anim in ['Left', 'Down', 'Up', 'Right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'BF${anim}', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', 'Dead', 24, false);
				}
				loadOffsetFile(curCharacter);

				skins.set('gfSkin', 'gf-cool');
				skins.set('3d', 'bf-3d');

				barColor = FlxColor.fromRGB(49, 176, 209);

				playAnim('idle');

				nativelyPlayable = true;

				flipX = true;
			case 'nofriend':
				frames = Paths.getSparrowAtlas('fiveNights/nofriend', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', 'miss $anim', 24, false);
				}
				animation.addByPrefix('hey', 'hey', 24, false);
				
				animation.addByIndices('attack', 'jumpscare', CoolUtil.numberArray(23, 0), '', 24, false);
				animation.addByIndices('fail', 'jumpscare', CoolUtil.numberArray(44, 24), '', 24, false);
				
				animation.addByPrefix('jumpscare', 'jumpscare', 24, false);
				trace(animation.getByName('jumpscare').frames);
				
				loadOffsetFile(curCharacter);
				
				globalOffset = [0, -75];

				barColor = FlxColor.fromString("0x127798");
				
				flipX = true;

				antialiasing = false;
				
				playAnim('idle');
			case 'bf-pixel':
				frames = Paths.getSparrowAtlas('weeb/bfPixel', 'shared');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				loadOffsetFile(curCharacter);
				
				skins.set('gfSkin', 'gf-pixel');
				skins.set('3d', 'bf-3d');
					
				globalOffset = [196, 160];

				barColor = FlxColor.fromRGB(49, 176, 209);

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

				antialiasing = false;
				nativelyPlayable = true;
				
				playAnim('idle');
				flipX = true;
			case 'bf-pixel-dead':
				frames = Paths.getSparrowAtlas('weeb/bfPixelsDEAD', 'shared');
				animation.addByPrefix('singUP', "BF Dies pixel", 24, false);
				animation.addByPrefix('firstDeath', "BF Dies pixel", 24, false);
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				animation.addByPrefix('deathConfirm', "RETRY CONFIRM", 24, false);
				
				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				
				antialiasing = false;
				nativelyPlayable = true;
				flipX = true;
				playAnim('firstDeath');
			case 'generic-death':
				frames = Paths.getSparrowAtlas('ui/lose', 'shared');
				animation.addByPrefix('firstDeath', "lose... instance 1", 24, false);
				animation.addByPrefix('deathLoop', "still", 24, true);
				animation.addByPrefix('deathConfirm', "still", 24, false);
				
				loadOffsetFile(curCharacter);
				flipX = true;
				playAnim('firstDeath');
			case 'gf':
				// GIRLFRIEND CODE
				frames = Paths.getSparrowAtlas('characters/GF_assets', 'shared');

				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				skins.set('3d', 'gf-3d');

				barColor = FlxColor.fromString('#33de39');

				playAnim('danceRight');
			case 'gf-bent':
				// GIRLFRIEND CODE
				frames = Paths.getSparrowAtlas('characters/GF_Bent_New', 'shared');

				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				skins.set('3d', 'gf-3d');

				barColor = FlxColor.fromString('#33de39');

				playAnim('danceRight');
			case 'gf-3d':
				frames = Paths.getSparrowAtlas('characters/3d_gf', 'shared');
				animation.addByPrefix('danceLeft', 'idle gf', 24, true);
				animation.addByPrefix('danceRight', 'idle gf', 24, true);
				animation.addByPrefix('sad', 'gf sad', 24, false);
		
				loadOffsetFile(curCharacter);
				
				globalOffset = [-50, -160];
				
				barColor = FlxColor.fromString('#33de39');

				updateHitbox();
				antialiasing = false;
						
				playAnim('danceRight');
			case 'gf-cool':
				frames = Paths.getSparrowAtlas('characters/Cool_GF', 'shared');
				animation.addByPrefix('danceLeft', 'left', 24, true);
				animation.addByPrefix('danceRight', 'right', 24, true);
				animation.addByPrefix('sad', 'f', 24, false);
		
				loadOffsetFile(curCharacter);
				
				skins.set('3d', 'gf-3d');

				barColor = FlxColor.fromString('#33de39');
				
				updateHitbox();						
				playAnim('danceRight');
			case 'gf-none':
				frames = Paths.getSparrowAtlas('characters/noGF', 'shared');
				
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [0], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [0], "", 24, false);
				animation.addByPrefix('cheer', 'GF Cheer', 24, false);
				animation.addByPrefix('singLEFT', 'GF left note', 24, false);
				animation.addByPrefix('singRIGHT', 'GF Right Note', 24, false);
				animation.addByPrefix('singUP', 'GF Up Note', 24, false);
				animation.addByPrefix('singDOWN', 'GF Down Note', 24, false);
				animation.addByIndices('sad', 'gf sad', [0], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24);

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromString('#33de39');

				playAnim('danceRight');
			case 'gf-pixel':
				frames = Paths.getSparrowAtlas('weeb/gfPixel', 'shared');
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				
				loadOffsetFile(curCharacter);
				
				skins.set('3d', 'gf-3d');

				globalOffset = [300, 280];

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;
				playAnim('danceRight');

				case 'dave':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/characters/dave_sheet', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}
					animation.addByPrefix('hey', 'hey', 24, false);
		
					globalOffset = [0, -170];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'dave-2.5':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/2.5/dave_sheet', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -170];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'dave-2.1':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/2.1/dave_sheet', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
					}	
					globalOffset = [0, -40];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'dave-2.0':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/2.0/dave_2.0', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -40];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'dave-1.0':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/1.0/dave_1.0', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -40];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'dave-alpha-4':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/Alpha 4/dave_sheet', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -40];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'furiosity-dave':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/Bambi Update/dave_angryboy', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -270];
	
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(195, 138, 161);
	
					playAnim('idle');
				case 'furiosity-dave-alpha-4':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/Alpha 4/dave_angryboy', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -270];
	
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(195, 138, 161);
	
					playAnim('idle');
				case 'dave-alpha':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/Alpha/dave_sheet', 'shared');
					animation.addByPrefix('idle', 'idle', 24, false);
					for (anim in ['left', 'down', 'up', 'right'])
					{
						animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
						animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
					}	
					globalOffset = [0, -320];
	
					skins.set('recursed', 'dave-recursed');
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
					barColor = FlxColor.fromRGB(15, 95, 255);
	
					playAnim('idle');
				case 'dave-pre-alpha':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/Pre-Alpha/dave_pre_alpha', 'shared');
					animation.addByPrefix('idle', 'Dave idle dance', 24, false);
					animation.addByPrefix('singUP', 'Dave Sing Note UP', 24, false);
					animation.addByPrefix('singRIGHT', 'Dave Sing Note RIGHT', 24, false);
					animation.addByPrefix('singDOWN', 'Dave Sing Note DOWN', 24, false);
					animation.addByPrefix('singLEFT', 'Dave Sing Note LEFT', 24, false);
		
					globalOffset = [0, -300];
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
									
					barColor = FlxColor.fromRGB(168, 236, 236);
		
					playAnim('idle');
				case 'dave-pre-alpha-hd':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('dave/classic/characters/Pre-Alpha/dave_pre_alpha_HD', 'shared');
					animation.addByPrefix('idle', 'Dad idle dance', 24, false);
					animation.addByPrefix('singUP', 'Dad Sing Note UP', 24, false);
					animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24, false);
					animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
					animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24, false);
					animation.addByPrefix('hey', 'WhatYouKnowAboutRollingDownInTheDeep', 24, false);
		
					globalOffset = [0, -300];
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
									
					barColor = FlxColor.fromRGB(168, 236, 236);
		
					playAnim('idle');
				case 'marcello-dave':
					// DAVE SHITE ANIMATION LOADING CODE
					frames = Paths.getSparrowAtlas('ass/Marcello_Dave_Assets', 'shared');
					animation.addByPrefix('idle', 'totally dave idle dance', 24, false);
					animation.addByPrefix('singUP', 'totally dave NOTE UP', 24, false);
					animation.addByPrefix('singRIGHT', 'totally dave NOTE RIGHT', 24, false);
					animation.addByPrefix('singDOWN', 'totally dave NOTE DOWN', 24, false);
					animation.addByPrefix('singLEFT', 'totally dave NOTE LEFT', 24, false);
		
					globalOffset = [0, 0];
	
					nativelyPlayable = true;
	
					loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
									
					barColor = FlxColor.fromRGB(168, 236, 236);
		
					playAnim('idle');
				case 'dave-annoyed':
						// DAVE SHITE ANIMATION LOADING CODE
						frames = Paths.getSparrowAtlas('dave/characters/Dave_insanity_lol', 'shared');
						animation.addByPrefix('idle', 'idle', 24, false);
						for (anim in ['left', 'down', 'up', 'right'])
						{
							animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
						}
						animation.addByPrefix('scared', 'scared', 24, true);
						animation.addByPrefix('um', 'um', 24, true);
			
						globalOffset = [0, -170];
		
						loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
						
						barColor = FlxColor.fromRGB(15, 95, 255);
		
						playAnim('idle');
				case 'dave-annoyed-2.1':
						// DAVE SHITE ANIMATION LOADING CODE
						frames = Paths.getSparrowAtlas('dave/classic/characters/2.1/Dave_insanity_lol', 'shared');
						animation.addByPrefix('idle', 'idle', 24, false);
						for (anim in ['left', 'down', 'up', 'right'])
						{
							animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
						}
		
						globalOffset = [0, -40];
		
						loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
						
						barColor = FlxColor.fromRGB(15, 95, 255);
		
						playAnim('idle');
				case 'dave-annoyed-2.0':
						// DAVE SHITE ANIMATION LOADING CODE
						frames = Paths.getSparrowAtlas('dave/classic/characters/2.0/Dave_insanity_lol', 'shared');
						animation.addByPrefix('idle', 'idle', 24, false);
						for (anim in ['left', 'down', 'up', 'right'])
						{
							animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
						}
							
						globalOffset = [0, -40];
		
						loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
						
						barColor = FlxColor.fromRGB(15, 95, 255);
		
						playAnim('idle');
				case 'dave-annoyed-2.5':
						// DAVE SHITE ANIMATION LOADING CODE
						frames = Paths.getSparrowAtlas('dave/classic/characters/2.5/Dave_insanity_lol', 'shared');
						animation.addByPrefix('idle', 'idle', 24, false);
						for (anim in ['left', 'down', 'up', 'right'])
						{
							animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
						}
						animation.addByPrefix('scared', 'scared', 24, true);
						animation.addByPrefix('um', 'um', 24, true);
						animation.addByPrefix('hey', 'um', 24, true);
			
						globalOffset = [0, -170];
		
						loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
						
						barColor = FlxColor.fromRGB(15, 95, 255);
		
						playAnim('idle');
			case 'dave-cool':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/characters/thecoolerdave', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
	
				globalOffset = [0, -170];

				loadOffsetFile(curCharacter);
								
				barColor = FlxColor.fromRGB(15, 95, 255);
	
				playAnim('idle');

			case 'dave-angey':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/characters/Dave_3D', 'shared');

				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [-140, -380];
				
				barColor = FlxColor.fromRGB(130, 47, 42);

				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				antialiasing = false;

				skins.set('recursed', 'dave-3d-recursed');

				playAnim('idle');
			case 'old-dave-cool':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/classic/characters/3.0/thecoolerdave', 'shared');
				animation.addByPrefix('idle', 'Id', 24, false);
				animation.addByPrefix('singUP', 'the up', 24, false);
				animation.addByPrefix('singRIGHT', 'righ', 24, false);
				animation.addByPrefix('singDOWN', 'dow', 24, false);
				animation.addByPrefix('singLEFT', 'lef', 24, false);
	
				globalOffset = [0, -170];

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
								
				barColor = FlxColor.fromRGB(15, 95, 255);
	
				playAnim('idle');
			case 'dave-angey-old':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/classic/characters/2.5/Dave_Furiosity', 'shared');

				animation.addByPrefix('idle', 'IDLE', 24, false);
				animation.addByPrefix('singUP', 'UP', 24, false);
				animation.addByPrefix('singRIGHT', 'RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'LEFT', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [0, -250];
				
				barColor = FlxColor.fromRGB(249, 180, 207);

				setGraphicSize(Std.int((width * 1) / furiosityScale));
				updateHitbox();
				antialiasing = false;

				skins.set('recursed', 'dave-3d-recursed');

				playAnim('idle');
			case 'dave-insanity-3d':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/classic/characters/beta 1/Dave_insanity_3d', 'shared');

				animation.addByPrefix('idle', 'DaveAngry idle dance', 24, true);
				animation.addByPrefix('singUP', 'DaveAngry Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'DaveAngry Sing Note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DaveAngry Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'DaveAngry Sing Note LEFT', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [-140, -380];				
				barColor = FlxColor.fromRGB(249, 180, 207);

				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				antialiasing = false;

				skins.set('recursed', 'dave-3d-recursed');

				playAnim('idle');
			case 'dave-3d-standing-bruh-what':
				// DAVE SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('dave/classic/characters/Alpha 6/dave_angryboy', 'shared');

				animation.addByPrefix('idle', 'DaveAngry idle dance', 24, false);
				animation.addByPrefix('singUP', 'DaveAngry Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'DaveAngry Sing Note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DaveAngry Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'DaveAngry Sing Note LEFT', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
								
				globalOffset = [-140, -380];
				barColor = FlxColor.fromRGB(195, 138, 161);

				antialiasing = false;

				skins.set('recursed', 'dave-3d-recursed');

				playAnim('idle');
			case 'dave-fnaf':
				frames = Paths.getSparrowAtlas('fiveNights/dave_fnaf', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
				}
				animation.addByPrefix('huh', 'huh', 24, true);

				globalOffset = [0, -170];

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromRGB(15, 95, 255);

				nativelyPlayable = true;
				playAnim('idle');
				
			case 'dave-splitathon':
				frames = Paths.getSparrowAtlas('splitathon/Splitathon_Dave', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('scared', 'waiting', 24, true);
				animation.addByPrefix('what', 'bruh', 24, true);
				animation.addByPrefix('happy', 'happy', 24, true);

				loadOffsetFile(curCharacter);
				globalOffset = [0, -180];

				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-splitathon-2.5':
				frames = Paths.getSparrowAtlas('dave/classic/characters/2.5/Splitathon_Dave_Night', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('scared', 'waiting', 24, true);
				animation.addByPrefix('what', 'bruh', 24, true);
				animation.addByPrefix('happy', 'happy', 24, true);
				animation.addByPrefix('hey', 'waiting', 24, true);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				globalOffset = [0, -180];

				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-splitathon-2.0':
				frames = Paths.getSparrowAtlas('dave/classic/characters/2.0/Splitathon_Dave_2.0', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				globalOffset = [0, -40];

				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-splitathon-1.0':
				frames = Paths.getSparrowAtlas('dave/classic/characters/1.0/daveSplitathon', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				globalOffset = [0, -40];

				barColor = FlxColor.fromRGB(15, 95, 255);

				playAnim('idle');
			case 'dave-recursed':
				frames = Paths.getSparrowAtlas('recursed/characters/Dave_Recursed', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}0', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', '$anim miss', 24, false);
				}

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				barColor = FlxColor.WHITE;
				playAnim('idle');
				
			case 'dave-3d-recursed':
				frames = Paths.getSparrowAtlas('recursed/characters/Dave_3D_Recursed', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', '${anim}', 24, false);
				}
				globalOffset = [-140, -380];

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				
				barColor = FlxColor.WHITE;
				playAnim('idle');

			case 'dave-death':
				frames = Paths.getSparrowAtlas('dave/characters/Dave_Dead', 'shared');

				animation.addByPrefix('firstDeath', 'dave dead hit', 24, false);
				animation.addByPrefix('deathLoop', 'dave dead loop', 24, true);
				animation.addByPrefix('deathConfirm', 'dave dead retry confirm', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
			case 'dave-festival':
				frames = Paths.getSparrowAtlas('festival/dave_festival', 'shared');
				
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('sleepIdle', 'sleepy', 24, false);
				animation.addByPrefix('scared', 'bruh', 24, false);
				animation.addByPrefix('sleeping', 'sleeping', 24, true);
				
				globalOffset = [-10, -230];

				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromString("0x198200");

				playAnim('idle');
			case 'dave-festival-3d':
				frames = Paths.getSparrowAtlas('festival/dave_festival_3d', 'shared');
				
				animation.addByPrefix('idle', 'Idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				loadOffsetFile(curCharacter);
				
				globalOffset = [-240, -450];
				
				barColor = FlxColor.fromString("0x619BC1");

				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');

			case 'bambi-new':
				frames = Paths.getSparrowAtlas('bambi/bambiRemake', 'shared');
				animation.addByPrefix('idle', 'bambi idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'bambi $anim', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', 'miss $anim', 24, false);
				}
				for (anim in ['left', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}-alt', 'bambi alt $anim', 24, false);
				}
				animation.addByPrefix('hey', 'bambi look', 24, false);
				animation.addByPrefix('singSmash', 'bambi phone', 24, false);
				animation.addByPrefix('singThrow', 'bambi throw', 24, false);
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [37, 90];
				skins.set('recursed', 'bambi-recursed');

				playAnim('idle');
				
			case 'doge':
				frames = Paths.getSparrowAtlas('doge/doge', 'shared');
				animation.addByPrefix('idle', 'Doge0', 24, false);
				animation.addByPrefix('singUP', 'Doge note up', 24, false);
				animation.addByPrefix('singRIGHT', 'Doge note right', 24, false);
				animation.addByPrefix('singDOWN', 'Doge note down', 24, false);
				animation.addByPrefix('singLEFT', 'Doge note left', 24, false);
				
				barColor = FlxColor.fromRGB(216, 176, 87);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [37, 90];
				skins.set('recursed', 'doge-recursed');

				playAnim('idle');
			case 'super-saiyan-bambi':
				frames = Paths.getSparrowAtlas('bambi/duperBambiAssets', 'shared');
				animation.addByPrefix('idle', 'duperBambiIdle', 24, false);
				for (anim in ['Left', 'Down', 'Up', 'Right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'duperBambi$anim', 24, false);
				}
				animation.addByPrefix('singSmash', 'duperBambiBreak', 24, false);
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				globalOffset = [-37, 50];
				playAnim('idle');
			case 'bambi-beta-2':
				frames = Paths.getSparrowAtlas('bambi/classis/bambi-beta-2', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [37, 90];

				playAnim('idle');
			case 'bambi-2.5':
				frames = Paths.getSparrowAtlas('bambi/classis/bambi 2.5', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [37, 90];

				playAnim('idle');
			case 'bambi-2.0':
				frames = Paths.getSparrowAtlas('bambi/classis/bambi2.0', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [37, 90];

				playAnim('idle');
			case 'bambi-1.0':
				frames = Paths.getSparrowAtlas('bambi/classis/bambiNotRemake', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [37, 90];

				playAnim('idle');
			case 'bambi-scrapped-3.0':
				frames = Paths.getSparrowAtlas('bambi/classis/bambi Scrapped 3.0', 'shared');
				animation.addByPrefix('idle', 'Idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}

				barColor = FlxColor.fromRGB(37, 191, 55);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [37, 30];

				playAnim('idle');
			case 'bambi-recursed':
				frames = Paths.getSparrowAtlas('recursed/characters/Bambi_Recursed', 'shared');

				animation.addByPrefix('idle', 'bambi idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'bambi $anim', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', 'miss $anim', 24, false);
				}
				animation.addByPrefix('singSmash', 'bambi phone', 24, false);
				
				barColor = FlxColor.WHITE;
				loadOffsetFile(curCharacter);
				playAnim('idle');

			case 'bambi-death':
				frames = Paths.getSparrowAtlas('bambi/Bambi_Death', 'shared');

				animation.addByPrefix('firstDeath', 'bambi die', 24, false);
				animation.addByPrefix('deathLoop', 'die loop', 24, true);
				animation.addByPrefix('deathConfirm', 'die end', 24, false);

				loadOffsetFile(curCharacter);
				
				playAnim('firstDeath');
			case 'baldi':
				frames = Paths.getSparrowAtlas('characters/BaldiInRoof', 'shared');
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);

				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromRGB(14, 174, 44);

				setGraphicSize(Std.int((width * 2) / furiosityScale));
				antialiasing = false;

				playAnim('idle');

			case 'bambi-splitathon':
				frames = Paths.getSparrowAtlas('splitathon/Splitathon_Bambi', 'shared');
				
				animation.addByPrefix('idle', 'splitathon idle0', 24, true);
				animation.addByPrefix('yummyCornLol', 'splitathon corn', 24, true);
				animation.addByPrefix('umWhatIsHappening', 'splitathon idle 2', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'splitathon $anim', 24, false);
				}
				loadOffsetFile(curCharacter);

				globalOffset = [30, 85];
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				playAnim('idle');

			case 'bambi-splitathon-2.5':
				frames = Paths.getSparrowAtlas('bambi/classis/Splitathon_Bambi_2.5', 'shared');
				
				animation.addByPrefix('idle', 'splitathon idle0', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'splitathon $anim', 24, false);
				}
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [37, 90];
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				playAnim('idle');

			case 'bambi-splitathon-1.0':
				frames = Paths.getSparrowAtlas('bambi/classis/bambiSplitathonShit', 'shared');
				
				animation.addByPrefix('idle', 'splitathon idle0', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'splitathon $anim', 24, false);
				}
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [0, 0];
				
				barColor = FlxColor.fromRGB(37, 191, 55);

				playAnim('idle');
			
			case 'bambi-splitathon-2.0':
				frames = Paths.getSparrowAtlas('bambi/classis/Splitathon_Bambi2', 'shared');
					
				animation.addByPrefix('idle', 'splitathon idle0', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'splitathon $anim', 24, false);
				}
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
				globalOffset = [37, 90];
					
				barColor = FlxColor.fromRGB(37, 191, 55);
	
				playAnim('idle');

			case 'bambi-angey':
				frames = Paths.getSparrowAtlas('bambi/Angry_Bambi', 'shared');

				animation.addByPrefix('idle', 'a_bambi idle', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'a_bambi $anim', 24, false);
				}
				animation.addByPrefix('singSmash', 'a_bambi phone', 24, false);
				animation.addByPrefix('throw', 'a_bambi throw', 24, false);
				animation.addByPrefix('scream', 'a_bambi scream', 24, false);
				
				barColor = FlxColor.fromRGB(37, 191, 55);
				globalOffset = [37, 90];
				
				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'bambi-angey-old':
				frames = Paths.getSparrowAtlas('bambi/bambimaddddd', 'shared');

				animation.addByPrefix('idle', 'idle', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				barColor = FlxColor.fromRGB(37, 191, 55);
				globalOffset = [37, 90];
				
				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'bambi-angey-oldest':
				frames = Paths.getSparrowAtlas('bambi/classis/marcello_but_now_he_is_REALLY_angry');
				animation.addByPrefix('idle', 'idle', 24, true);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
	
				barColor = FlxColor.fromRGB(255, 0, 0);
				globalOffset = [30, 0];				
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
	
				playAnim('idle');
			case 'bambi-3d-scrapped':
				// BAMBI SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/Old_Cheating', 'shared');
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
		
				barColor = FlxColor.fromRGB(13, 151, 21);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [0, -350];

				setGraphicSize(Std.int((width * 1.5) / furiosityScale));

				updateHitbox();
				antialiasing = false;

				skins.set('recursed', 'bambi-3d-recursed');
		
				playAnim('idle');

			case 'bambi-3d-old':
				// BAMBI SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/bambi_angryboy', 'shared');
				animation.addByPrefix('idle', 'DaveAngry idle dance', 24, false);
				animation.addByPrefix('singUP', 'DaveAngry Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'DaveAngry Sing Note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'DaveAngry Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'DaveAngry Sing Note LEFT', 24, false);
		
				barColor = FlxColor.fromRGB(13, 151, 21);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [-30, -350];

				setGraphicSize(Std.int((width * 1.1) / furiosityScale));

				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');
			case 'bambi-3d':
				// BAMBI SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/Cheating', 'shared');
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
		
				barColor = FlxColor.fromRGB(13, 151, 21);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [0, -350];

				setGraphicSize(Std.int((width * 1.5) / furiosityScale));

				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');
			case 'bambi-unfair':
				// BAMBI SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/unfair_bambi', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				globalOffset = [0, -260];
				barColor = FlxColor.fromRGB(178, 7, 7);

				loadOffsetFile(curCharacter);
				
				antialiasing = false;
				
				setGraphicSize(Std.int((width * 1.3) / furiosityScale));

				playAnim('idle');
				case 'bambi-unfair-old': // add so no crash
				// BAMBI SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/old-unfair-bambi');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'singUP', 24, false);
				animation.addByPrefix('singRIGHT', 'singRIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'singDOWN', 24, false);
				animation.addByPrefix('singLEFT', 'singLEFT', 24, false);
		
				addOffset('idle');
				addOffset("singUP", 140, 70);
				addOffset("singRIGHT", -180, -60);
				addOffset("singLEFT", 250, 0);
				addOffset("singDOWN", 150, 50);
				globalOffset = [150 * 1.3, 450 * 1.3];
				setGraphicSize(Std.int((width * 1.3) / furiosityScale));
				updateHitbox();
				antialiasing = false;
				nativelyPlayable = true;
				playAnim('idle');
			case 'expunged':
				// EXPUNGED SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/ExpungedFinal', 'shared');
				animation.addByPrefix('idle', 'idle0', 24, false);
				animation.addByPrefix('singUP', 'up0', 24, false);
				animation.addByPrefix('singRIGHT', 'right0', 24, false);
				animation.addByPrefix('singDOWN', 'down0', 24, false);
				animation.addByPrefix('singLEFT', 'left0', 24, false);
		
				loadOffsetFile(curCharacter);
				

				barColor = FlxColor.fromRGB(82, 15, 15);
				antialiasing = false;
				
				globalOffset = [0, -350];
				
				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				
				playAnim('idle');

			case 'expunged-mad':
				// EXPUNGED SHITE ANIMATION LOADING CODE
				frames = Paths.getSparrowAtlas('expunged/ExpungedFinal', 'shared');
				animation.addByPrefix('idle', 'idle alt', 24, false);
				animation.addByPrefix('singUP', 'up alt', 24, false);
				animation.addByPrefix('singRIGHT', 'right alt', 24, false);
				animation.addByPrefix('singDOWN', 'down alt', 24, false);
				animation.addByPrefix('singLEFT', 'left alt', 24, false);
		
				loadOffsetFile(curCharacter);
				

				barColor = FlxColor.fromRGB(82, 15, 15);
				antialiasing = false;
				
				globalOffset = [0, -350];
				
				setGraphicSize(Std.int((width * 0.8) / furiosityScale));
				updateHitbox();
				
				playAnim('idle');

			case 'dan':
				frames = Paths.getSparrowAtlas('dan/dan', 'shared');
				animation.addByPrefix('idle', 'bambi idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'bambi $anim', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', 'miss $anim', 24, false);
				}
				for (anim in ['left', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}-alt', 'bambi alt $anim', 24, false);
				}
				animation.addByPrefix('hey', 'bambi look', 24, false);
				animation.addByPrefix('singSmash', 'bambi phone', 24, false);
				animation.addByPrefix('singThrow', 'bambi throw', 24, false);

				loadOffsetFile(curCharacter);
				barColor = FlxColor.fromRGB(0, 0, 0);

				nativelyPlayable = true;
				flipX = true;
				
				globalOffset = [37, 90];
				skins.set('recursed', 'bambi-recursed');

				playAnim('idle');

				case 'dan-v2':
				frames = Paths.getSparrowAtlas('dan/dan-v2', 'shared');
				animation.addByPrefix('idle', 'bambi idle', 24, false);
				animation.addByPrefix('singUP', 'bambi up', 24, false);
				animation.addByPrefix('singLEFT', 'bambi left', 24, false);
				animation.addByPrefix('singRIGHT', 'bambi right', 24, false);
				animation.addByPrefix('singDOWN', 'bambi down', 24, false);
				animation.addByPrefix('hey', 'bambi hey', 24, false);
				animation.addByPrefix('singSmash', 'bambi phone', 24, false);
		
			
			loadOffsetFile(curCharacter);
			barColor = FlxColor.fromRGB(0, 0, 0);

			nativelyPlayable = true;
			flipX = false;
			playAnim('idle');
				
			globalOffset = [37, 90];
			

			playAnim('idle');
			case 'bambi-joke':
				frames = Paths.getSparrowAtlas('joke/bambi-joke', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('hey', 'hey', 24, false);

				loadOffsetFile(curCharacter);

				globalOffset = [70, 52];

				barColor = FlxColor.fromRGB(12, 181, 0);
				nativelyPlayable = true;
				flipX = true;
				playAnim('idle');

			case 'bambi-joke-mad':
				frames = Paths.getSparrowAtlas('joke/bambi-joke-mad', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('die', 'die', 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				barColor = FlxColor.fromRGB(12, 181, 0);
				nativelyPlayable = true;
				flipX = true;

			case 'bambi-shredder':
				frames = Paths.getSparrowAtlas('festival/bambi_shredder', 'shared');
				
				animation.addByPrefix('idle', 'shredder idle', 24, false);
				animation.addByPrefix('singLEFT', 'shredder left', 24, false);
				animation.addByPrefix('singDOWN', 'shredder down', 24, false);
				animation.addByPrefix('singMIDDLE', 'shredder forward', 24, false);
				animation.addByPrefix('singUP', 'shredder up', 24, false);
				animation.addByPrefix('singRIGHT', 'shredder right', 24, false);
				animation.addByPrefix('singMIDDLE', 'shredder forward', 24, false);
				animation.addByPrefix('takeOut', 'shredder take out', 24, false);

				barColor = FlxColor.fromRGB(37, 191, 55);
				loadOffsetFile(curCharacter);
				
				globalOffset = [37, 90];
			case 'tristan':
				frames = Paths.getSparrowAtlas('dave/TRISTAN', 'shared');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing$anim', 'BF NOTE ${anim}0', 24, false);
					animation.addByPrefix('sing${anim}miss', 'BF NOTE $anim MISS', 24, false);
				}
				animation.addByPrefix('hey', 'BF HEY!!', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
	
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				globalOffset = [0, 15];

				barColor = FlxColor.fromRGB(255, 19, 15);
				nativelyPlayable = true;
				flipX = true;

				skins.set('recursed', 'tristan-recursed');

				playAnim('idle');
			case 'bambi-old':
				var tex = Paths.getSparrowAtlas('joke/bambi-old');
				frames = tex;
				animation.addByPrefix('idle', 'MARCELLO idle dance', 24, false);
				animation.addByPrefix('singUP', 'MARCELLO NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'MARCELLO NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'MARCELLO NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'MARCELLO NOTE DOWN0', 24, false);
				animation.addByPrefix('idle', 'MARCELLO idle dance', 24, false);
				animation.addByPrefix('singUPmiss', 'MARCELLO MISS UP0', 24, false);
				animation.addByPrefix('singLEFTmiss', 'MARCELLO MISS LEFT0', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'MARCELLO MISS RIGHT0', 24, false);
				animation.addByPrefix('singDOWNmiss', 'MARCELLO MISS DOWN0', 24, false);

				animation.addByPrefix('firstDeath', "MARCELLO dead0", 24, false);
				animation.addByPrefix('deathLoop', "MARCELLO dead0", 24, true);
				animation.addByPrefix('deathConfirm', "MARCELLO dead0", 24, false);

				loadOffsetFile(curCharacter);
				playAnim('idle');

				barColor = FlxColor.fromRGB(12, 181, 0);
				nativelyPlayable = true;
	
				flipX = true;

			case 'mr-bambi':
				frames = Paths.getSparrowAtlas('bambi/Mr. Bambi/V1/BOYFRIEND', 'shared');
					
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
	
				loadOffsetFile(curCharacter);
	
				barColor = FlxColor.fromRGB(12, 181, 0);
	
				playAnim('idle');
	
				nativelyPlayable = true;
	
				flipX = true;
			case 'mr-bambi-pixel':
				frames = Paths.getSparrowAtlas('bambi/Mr. Bambi/V1/bfPixel', 'shared');
				animation.addByPrefix('idle', 'BF IDLE', 24, false);
				animation.addByPrefix('singUP', 'BF UP NOTE', 24, false);
				animation.addByPrefix('singLEFT', 'BF LEFT NOTE', 24, false);
				animation.addByPrefix('singRIGHT', 'BF RIGHT NOTE', 24, false);
				animation.addByPrefix('singDOWN', 'BF DOWN NOTE', 24, false);
				animation.addByPrefix('singUPmiss', 'BF UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF DOWN MISS', 24, false);

				loadOffsetFile(curCharacter);
					
				globalOffset = [196, 160];

				barColor = FlxColor.fromRGB(12, 181, 0);

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();

				antialiasing = false;
				nativelyPlayable = true;
				
				playAnim('idle');
				flipX = true;
			case 'mr-bambi-v2':
				frames = Paths.getSparrowAtlas('bambi/Mr. Bambi/V2/BOYFRIEND', 'shared');
					
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
	
				loadOffsetFile(curCharacter);
	
				barColor = FlxColor.fromRGB(12, 181, 0);
	
				playAnim('idle');
	
				nativelyPlayable = true;
	
				flipX = true;
			case 'mr-bambi-car':
				frames = Paths.getSparrowAtlas('bambi/Mr. Bambi/V1/bfCar', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				
				loadOffsetFile(curCharacter);
	
				barColor = FlxColor.fromRGB(12, 181, 0);
				nativelyPlayable = true;
	
				playAnim('idle');

				flipX = true;
			case 'mr-bambi-christmas':
				frames = Paths.getSparrowAtlas('bambi/Mr. Bambi/V1/bfChristmas', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				
				loadOffsetFile(curCharacter);
	
				barColor = FlxColor.fromRGB(12, 181, 0);
				nativelyPlayable = true;
	
				playAnim('idle');

				flipX = true;
			case 'tristan-2.0':
				frames = Paths.getSparrowAtlas('dave/classic/TRISTAN');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				globalOffset = [0, 15];

				loadOffsetFile(curCharacter);
				barColor = FlxColor.fromRGB(255, 19, 15);
				nativelyPlayable = true;
	
				playAnim('idle');
	
				flipX = true;
			case 'tristan-beta':
				var tex = Paths.getSparrowAtlas('dave/classic/beta_tristan');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
	
				globalOffset = [0, 15];

				loadOffsetFile(curCharacter);
				barColor = FlxColor.fromRGB(255, 19, 15);
				nativelyPlayable = true;
	
				playAnim('idle');
	
				flipX = true;
			case 'tristan-opponent':
				frames = Paths.getSparrowAtlas('dave/TristanHairFlipped', 'shared');
				
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [0, 15];
				
				barColor = FlxColor.fromRGB(255, 19, 15);
				
				nativelyPlayable = true;
				flipX = true;
				playAnim('idle');

			case 'tristan-death':
				frames = Paths.getSparrowAtlas('dave/Tristan_Dead', 'shared');

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
				flipX = true;

			case 'tristan-golden':
			   frames = Paths.getSparrowAtlas('dave/tristan_golden', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'BF NOTE ${anim}0', 24, false);
					animation.addByPrefix('sing${anim.toUpperCase()}miss', 'BF NOTE $anim MISS', 24, false);
				}
				animation.addByPrefix('hey', 'BF HEY', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
	
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				globalOffset = [0, 15];

				barColor = FlxColor.fromRGB(255, 222, 0);
				skins.set('recursed', 'tristan-recursed');
				nativelyPlayable = true;
				flipX = true;
	
				playAnim('idle');
			case 'tristan-golden-death':
				frames = Paths.getSparrowAtlas('dave/tristan_golden_death', 'shared');

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);

				loadOffsetFile(curCharacter);
				
				flipX = true;

				playAnim('firstDeath');
			case 'tristan-golden-glowing':
				frames = Paths.getSparrowAtlas('dave/tristan_golden_glowing', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
						
				loadOffsetFile(curCharacter);
				globalOffset = [-35, -30];
					
				barColor = FlxColor.fromRGB(255, 222, 0);
				skins.set('recursed', 'tristan-recursed');
					
				playAnim('idle');
	
				nativelyPlayable = true;
		
				flipX = true;
			case 'tristan-golden-2.5':
				var tex = Paths.getSparrowAtlas('dave/classic/tristan_golden');
				frames = tex;
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);
	
				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);
	
				barColor = FlxColor.fromRGB(255, 222, 0);
				loadOffsetFile(curCharacter);
				nativelyPlayable = true;
				flipX = true;
	
				playAnim('idle');	
			case 'tristan-festival':
				frames = Paths.getSparrowAtlas('festival/tristan_festival');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				globalOffset = [0, 20];
				
				barColor = FlxColor.fromRGB(255, 19, 15);
				
				nativelyPlayable = true;
				flipX = true;
				playAnim('idle');
			case 'exbungo':
				frames = Paths.getSparrowAtlas('characters/exbungo', 'shared');

				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);

				loadOffsetFile(curCharacter);

				globalOffset = [0, -300];
				
				setGraphicSize(Std.int((width * 1.3) / furiosityScale));
				updateHitbox();

				barColor = FlxColor.fromRGB(253, 39, 33);

				nativelyPlayable = true;	
				flipX = true;
	
				antialiasing = false;

				playAnim('idle');
			// Bananacore shit
			// You can basically ignore everything beyond this point
			// Most of these are just one-time characters that appear for a few seconds
			case 'old-cockey':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/old-characters/Cockey', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
		
				loadOffsetFile(curCharacter);

				barColor = FlxColor.fromRGB(228, 85, 81);	
				globalOffset = [-30, -350];			

				setGraphicSize(Std.int(width * 0.5));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');
			

			case 'old-pissey':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/old-characters/Pissey', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
			
				loadOffsetFile(curCharacter);
					
				barColor = FlxColor.fromRGB(255, 206, 11);
				globalOffset = [-30, -350];
				
	
				setGraphicSize(Std.int(width * 0.5));
				updateHitbox();
				antialiasing = false;
			
				playAnim('idle');

			case 'old-pooper':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/old-characters/Pooper', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
			
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(136, 104, 107);
				globalOffset = [-30, -350];

				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
			
				playAnim('idle');

			case 'cockey':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/Cockey', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Cockey idle', 24, false);
				animation.addByPrefix('singUP', 'Cockey up', 24, false);
				animation.addByPrefix('singRIGHT', 'Cockey right', 24, false);
				animation.addByPrefix('singDOWN', 'Cockey down', 24, false);
				animation.addByPrefix('singLEFT', 'Cockey left', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				barColor = FlxColor.fromRGB(228, 85, 81);

				globalOffset = [-200, -300];
				setGraphicSize(Std.int(width * 2));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');

			case 'older-cockey':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/Cockey', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24, false);
				animation.addByPrefix('singUP', 'Up', 24, false);
				animation.addByPrefix('singRIGHT', 'Right', 24, false);
				animation.addByPrefix('singDOWN', 'Down', 24, false);
				animation.addByPrefix('singLEFT', 'Left', 24, false);
		
				//loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				loadOffsetFile(curCharacter);

				// joke ass charashit

				barColor = FlxColor.fromRGB(228, 85, 81);

				globalOffset = [130, -130];
				setGraphicSize(Std.int(width * 2));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');
			

			case 'pissey':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/Pissey', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
				animation.addByPrefix('phoneOFF', 'turning his phone off', 24, true);
				animation.addByPrefix('phoneAWAY', 'putting his phone away', 24, false);
		
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));
				
				
				barColor = FlxColor.fromRGB(255, 206, 11);

				globalOffset = [-30, -350];
				setGraphicSize(Std.int(width * 1.85));
				updateHitbox();
				antialiasing = false;
		
				playAnim('idle');

			case 'shartey':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/Shartey', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'Shartey idle', 24, false);
				animation.addByPrefix('singUP', 'Shartey up', 24, false);
				animation.addByPrefix('singRIGHT', 'Shartey right', 24, false);
				animation.addByPrefix('singDOWN', 'Shartey down', 24, false);
				animation.addByPrefix('singLEFT', 'Shartey left', 24, false);
				animation.addByPrefix('singDOWN-alt', 'Shartey alt-down', 24, false);
			
				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));				
				barColor = FlxColor.fromRGB(104, 191, 202);
				globalOffset = [0, -150];
	
				setGraphicSize(Std.int(width * 1.65));
				updateHitbox();
				antialiasing = false;
			
				playAnim('idle');
			case 'pooper':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/Pooper', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
			
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(136, 104, 107);

				globalOffset = [150, 450];

				setGraphicSize(Std.int(width * 4.75));
				updateHitbox();
				antialiasing = false;
			
				playAnim('idle');

			case 'pooper-playable':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/Pooper', 'shared');
				frames = tex;
				animation.addByPrefix('idle', 'idle', 24, false);
				animation.addByPrefix('singUP', 'up', 24, false);
				animation.addByPrefix('singRIGHT', 'right', 24, false);
				animation.addByPrefix('singDOWN', 'down', 24, false);
				animation.addByPrefix('singLEFT', 'left', 24, false);
			
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(136, 104, 107);

				globalOffset = [-30, -350];

				setGraphicSize(Std.int(width * 1.3));
				updateHitbox();
				antialiasing = false;
			
				playAnim('idle');

			case 'bartholemew':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/old-characters/Bartholemew', "shared");
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24);

				loadOffsetFile(curCharacter);

				playAnim('idle');

			case 'kapi':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/Kapi', "shared");
				frames = tex;
				animation.addByPrefix('idle', 'Dad idle dance', 24, false);
				animation.addByPrefix('singUP', 'Dad Sing Note UP', 24, false);
				animation.addByPrefix('singRIGHT', 'Dad Sing Note RIGHT', 24, false);
				animation.addByPrefix('singDOWN', 'Dad Sing Note DOWN', 24, false);
				animation.addByPrefix('singLEFT', 'Dad Sing Note LEFT', 24, false);

				loadOffsetFile(curCharacter + (isPlayer ? '-playable' : ''));

				barColor = FlxColor.fromRGB(116, 117, 133);

				globalOffset = [-150, -400];
	
				playAnim('idle');

			case 'cuzsiee':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/cuzsiee', "shared");
				frames = tex;
				animation.addByPrefix('idle', 'cuzsiee idle', 24, false);
				animation.addByPrefix('singUP', 'cuzsiee up', 24, false);
				animation.addByPrefix('singRIGHT', 'cuzsiee right', 24, false);
				animation.addByPrefix('singDOWN', 'cuzsiee down', 24, false);
				animation.addByPrefix('singLEFT', 'cuzsiee left', 24, false);
	
				loadOffsetFile(curCharacter);
				globalOffset = [-500, -750];
				barColor = FlxColor.fromRGB(255, 255, 255);
		
				playAnim('idle');	

			case 'ayo-the-pizza-here':
				var tex = Paths.getSparrowAtlas('eletric-cockadoodledoo/characters/PizzaMan', "shared");
				frames = tex;
				animation.addByPrefix('idle', 'Idle', 24);
				animation.addByPrefix('singUP', 'Up', 24);
				animation.addByPrefix('singRIGHT', 'Right', 24);
				animation.addByPrefix('singDOWN', 'Down', 24);
				animation.addByPrefix('singLEFT', 'Left', 24);
				animation.addByPrefix('pizza', 'PizzasHere', 24);
				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'recurser':
				frames = Paths.getSparrowAtlas('recursed/Recurser', "shared");

				animation.addByPrefix('idle', 'recursedIdle', 24, false);
				animation.addByPrefix('singLEFT', 'recursedLeft', 24, false);
				animation.addByPrefix('singDOWN', 'recursedDown', 24, false);
				animation.addByPrefix('singUP', 'recursedUp', 24, false);
				animation.addByPrefix('singRIGHT', 'recursedRight', 24, false);

				barColor = FlxColor.fromRGB(44, 44, 44);

				loadOffsetFile(curCharacter);

				playAnim('idle');
			case 'bf-recursed':
				frames = Paths.getSparrowAtlas('recursed/Recursed_BF', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				for (anim in ['LEFT', 'DOWN', 'UP', 'RIGHT'])
				{
					animation.addByPrefix('sing$anim', 'BF NOTE ${anim}0', 24, false);
					animation.addByPrefix('sing${anim}miss', 'BF NOTE $anim MISS', 24, false);
				}
				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, true);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24, false);

				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.WHITE;
				nativelyPlayable = true;
				flipX = true;

				playAnim('idle');
			case 'tristan-recursed':
				frames = Paths.getSparrowAtlas('recursed/characters/TristanRecursed', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);

				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);

				animation.addByPrefix('firstDeath', 'BF dies', 24, false);
				animation.addByPrefix('deathLoop', 'BF Dead Loop', 24, false);
				animation.addByPrefix('deathConfirm', 'BF Dead confirm', 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24, false); 

				flipX = true;
				barColor = FlxColor.WHITE;

				loadOffsetFile(curCharacter);

				nativelyPlayable = true;

				playAnim('idle');
			case 'tb-funny-man':
				frames = Paths.getSparrowAtlas('characters/DONT_GO_SNOOPING_WHERE_YOURE_NOT_SUPPOSED_TO', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY!!', 24, false);

				// animation.addByPrefix('firstDeath', "LOL NO RESTARTING FOR YOU BUCKO", 24, false);
				// animation.addByPrefix('deathLoop', "YOU GONNA HAVE TO RESTART", 24, true);
				// animation.addByPrefix('deathConfirm', "IF YOU CAN SEE THIS YOU HAVE BEEN EPICLY TROLLED!!!", 24, false);
				animation.addByPrefix('scared', 'idle shaking', 24);

				loadOffsetFile(curCharacter);

				skins.set('gfSkin', 'stereo');
				skins.set('recursed', 'tb-recursed');

				flipX = true;
				barColor = FlxColor.fromRGB(102, 255, 0);

				nativelyPlayable = true;

				playAnim('idle');
			case 'tb-recursed':
				frames = Paths.getSparrowAtlas('recursed/characters/STOP_LOOKING_AT_THE_FILES', 'shared');

				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY!!', 24, false);

				// animation.addByPrefix('firstDeath', "LOL NO RESTARTING FOR YOU BUCKO", 24, false);
				// animation.addByPrefix('deathLoop', "YOU GONNA HAVE TO RESTART", 24, true);
				// animation.addByPrefix('deathConfirm', "IF YOU CAN SEE THIS YOU HAVE BEEN EPICLY TROLLED!!!", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);

				loadOffsetFile(curCharacter);

				flipX = true;
				barColor = FlxColor.WHITE;

				nativelyPlayable = true;

				playAnim('idle');

			case 'stereo':
				frames = Paths.getSparrowAtlas('characters/IM_GONNA_TORNADER_YOU_AWAY', 'shared');

				animation.addByPrefix('idle', 'bump', 24, false);

				globalOffset = [500, 500];

				loadOffsetFile(curCharacter);
					
				playAnim('idle');
			case 'moldy':
				frames = Paths.getSparrowAtlas('california/moldygh', 'shared');

				animation.addByPrefix('idle', 'Idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				animation.addByPrefix('waa', 'cry', 24, false);
				animation.addByPrefix('helpMe', 'stuck in fornia', 24, false);

				loadOffsetFile(curCharacter);

				globalOffset = [-30, -125];

				barColor = FlxColor.fromRGB(39, 21, 130);

				playAnim('idle');
			case 'playrobot':
				frames = Paths.getSparrowAtlas('playrobot/playbot', 'shared');
				animation.addByPrefix('idle', 'idle', 24, false);

				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(162, 150, 188);
				playAnim('idle');
			case 'playrobot-shadow':
				frames = Paths.getSparrowAtlas('playrobot/playrobot_shadow', 'shared');
				
				animation.addByPrefix('idle', 'idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', anim, 24, false);
				}
				loadOffsetFile(curCharacter);
				
				barColor = FlxColor.fromRGB(162, 150, 188);
				playAnim('idle');
			case 'dave-awesome':
				frames = Paths.getSparrowAtlas('dave/characters/dave_awesome', 'shared');

				animation.addByPrefix('idle', 'dave idle', 24, false);
				for (anim in ['left', 'down', 'up', 'right'])
				{
					animation.addByPrefix('sing${anim.toUpperCase()}', 'dave $anim', 24, false);
				}
				globalOffset = [0, 40];

				loadOffsetFile(curCharacter);
				barColor = FlxColor.fromRGB(0, 94, 255);
				playAnim('idle');
			case 'shaggy':
				frames = Paths.getSparrowAtlas('characters/shaggy', 'shared');
				animation.addByPrefix('danceRight', 'shaggy_idle0', 30, false);
				animation.addByPrefix('danceLeft', 'shaggy_idle2', 30, false);
				animation.addByPrefix('singUP', 'shaggy_up', 30, false);
				animation.addByPrefix('singLEFT', 'shaggy_right', 30, false);
				animation.addByPrefix('singRIGHT', 'shaggy_left', 30, false);
				animation.addByPrefix('singDOWN', 'shaggy_down', 30, false);

				barColor = FlxColor.fromRGB(51, 114, 74);

				loadOffsetFile(curCharacter);
				globalOffset = [0, -350];

				playAnim('danceRight');

				nativelyPlayable = true;
			case 'supershaggy':
				frames = Paths.getSparrowAtlas('characters/shaggy_super', 'shared');
				animation.addByPrefix('idle', 'shaggy_sidle', 12, true);
				animation.addByPrefix('singUP', 'shaggy_sup', 30, false);
				animation.addByPrefix('singLEFT', 'shaggy_sright', 30, false);
				animation.addByPrefix('singRIGHT', 'shaggy_sleft', 30, false);
				animation.addByPrefix('singDOWN', 'shaggy_sdown', 30, false);

				barColor = FlxColor.fromRGB(51, 114, 74);

				loadOffsetFile(curCharacter);
				globalOffset = [0, -350];

				playAnim('idle');

				nativelyPlayable = true;
			case 'godshaggy':
				frames = Paths.getSparrowAtlas('characters/shaggy_god', 'shared');
				animation.addByPrefix('idle', 'pshaggy_idle', 30, false);
				animation.addByPrefix('singUP', 'pshaggy_up', 30, false);
				animation.addByPrefix('singLEFT', 'pshaggy_right', 30, false);
				animation.addByPrefix('singRIGHT', 'pshaggy_left', 30, false);
				animation.addByPrefix('singDOWN', 'pshaggy_down', 30, false);

				barColor = FlxColor.fromRGB(75, 51, 114);

				loadOffsetFile(curCharacter);
				globalOffset = [30, -400];

				playAnim('idle');

				nativelyPlayable = true;
			case 'redshaggy':
				frames = Paths.getSparrowAtlas('characters/shaggy_red', 'shared');
				animation.addByPrefix('danceRight', 'shaggy_idle0', 30, false);
				animation.addByPrefix('danceLeft', 'shaggy_idle2', 30, false);
				animation.addByPrefix('singUP', 'shaggy_up', 30, false);
				animation.addByPrefix('singLEFT', 'shaggy_right', 30, false);
				animation.addByPrefix('singRIGHT', 'shaggy_left', 30, false);
				animation.addByPrefix('singDOWN', 'shaggy_down', 30, false);

				barColor = FlxColor.fromRGB(209, 26, 26);

				loadOffsetFile(curCharacter);
				globalOffset = [0, -350];

				playAnim('danceRight');

				nativelyPlayable = true;
			case 'shaggy-lose':
				frames = Paths.getSparrowAtlas('characters/shaggy_gameover', 'shared');

				animation.addByPrefix('firstDeath', 'shaggy_lose_start', 24, false);
				animation.addByPrefix('deathLoopRight', 'shaggy_lose_loop1', 24, false);
				animation.addByPrefix('deathLoopLeft', 'shaggy_lose_loop2', 24, false);
				animation.addByPrefix('deathConfirm', 'shaggy_lose_retry', 30, false);

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
			case 'redshaggy-lose':
				frames = Paths.getSparrowAtlas('characters/shaggy_red_gameover', 'shared');

				animation.addByPrefix('firstDeath', 'shaggy_lose_start', 24, false);
				animation.addByPrefix('deathLoopRight', 'shaggy_lose_loop1', 24, false);
				animation.addByPrefix('deathLoopLeft', 'shaggy_lose_loop2', 24, false);
				animation.addByPrefix('deathConfirm', 'shaggy_lose_retry', 30, false);

				loadOffsetFile(curCharacter);
				playAnim('firstDeath');
			case 'flandre':
				frames = Paths.getSparrowAtlas('characters/flandre', 'shared');

				animation.addByPrefix('idle', 'flandre_idle', 12, false);
				animation.addByPrefix('singUP', 'flandre_up', 24, false);
				animation.addByPrefix('singLEFT', 'flandre_left', 24, false);
				animation.addByPrefix('singRIGHT', 'flandre_right', 24, false);
				animation.addByPrefix('singDOWN', 'flandre_down', 24, false);

				loadOffsetFile(curCharacter);

				globalOffset = [0, -270];

				barColor = FlxColor.fromRGB(255, 255, 0);

				playAnim('idle');
			case 'longnosejohn':
				frames = Paths.getSparrowAtlas('characters/longnosejohn', 'shared');

				animation.addByPrefix('idle', 'longnosejohn idle', 24, false);
				animation.addByPrefix('singUP', 'longnosejohn up', 24, false);
				animation.addByPrefix('singRIGHT', 'longnosejohn right', 24, false);
				animation.addByPrefix('singDOWN', 'longnosejohn down', 24, false);
				animation.addByPrefix('singLEFT', 'longnosejohn left', 24, false);
				globalOffset = [-200, -420];

				loadOffsetFile(curCharacter);
				barColor = FlxColor.fromRGB(0, 127, 14);
				playAnim('idle');
			case 'zardyMyBeloved':
				frames = Paths.getSparrowAtlas('characters/Zardy','shared');
				animation.addByPrefix('idle', 'Idle', 14);
				animation.addByPrefix('singUP', 'Sing Up', 24);
				animation.addByPrefix('singRIGHT', 'Sing Right', 24);
				animation.addByPrefix('singDOWN', 'Sing Down', 24);
				animation.addByPrefix('singLEFT', 'Sing Left', 24);
				loadOffsetFile(curCharacter);
				barColor = FlxColor.fromRGB(186, 123, 66);

				// GET SILLY (I think this will work)
				default:
				//var customPlayableChar = CoolUtil.coolTextFile(Paths.txt('CustomChars/' + curCharacter + '/anims'));
				if (FileSystem.exists(Paths.txt('CustomChars/' + curCharacter))) {
				var customPlayableChar = CoolUtil.coolTextFile(Paths.txt('CustomChars/' + curCharacter));

				for (i in 0...customPlayableChar.length)
					{
						var data:Array<String> = customPlayableChar[i].split(':');
						trace('break in 2');
						frames = Paths.getCustomSparrowAtlas('characters/custom/${curCharacter}', 'shared');
		
						animation.addByPrefix('idle', data[0], 24, false);
						animation.addByPrefix('singUP', data[1], 24, false);
						animation.addByPrefix('singRIGHT', data[2], 24, false);
						animation.addByPrefix('singDOWN', data[3], 24, false);
						animation.addByPrefix('singLEFT', data[4], 24, false);
						
						loadOffsetFile(curCharacter);
				
						globalOffset = [Std.parseInt(data[5]), Std.parseInt(data[6])];
					//	barColor = FlxColor.fromRGB(Std.parseInt(data[7]), Std.parseInt(data[8]), Std.parseInt(data[9]));
						barColor = FlxColor.fromString(data[7]);
		
						playAnim('idle');
						antialiasing = false;
						nativelyPlayable = true;
						flipX = true;
					} 
				} else {
				frames = Paths.getSparrowAtlas('characters/BOYFRIEND', 'shared');
				
				animation.addByPrefix('idle', 'BF idle dance', 24, false);
				animation.addByPrefix('singUP', 'BF NOTE UP0', 24, false);
				animation.addByPrefix('singLEFT', 'BF NOTE LEFT0', 24, false);
				animation.addByPrefix('singRIGHT', 'BF NOTE RIGHT0', 24, false);
				animation.addByPrefix('singDOWN', 'BF NOTE DOWN0', 24, false);
				animation.addByPrefix('singUPmiss', 'BF NOTE UP MISS', 24, false);
				animation.addByPrefix('singLEFTmiss', 'BF NOTE LEFT MISS', 24, false);
				animation.addByPrefix('singRIGHTmiss', 'BF NOTE RIGHT MISS', 24, false);
				animation.addByPrefix('singDOWNmiss', 'BF NOTE DOWN MISS', 24, false);
				animation.addByPrefix('hey', 'BF HEY', 24, false);

				animation.addByPrefix('firstDeath', "BF dies", 24, false);
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				animation.addByPrefix('deathConfirm', "BF Dead confirm", 24, false);
				animation.addByPrefix('dodge', "boyfriend dodge", 24, false);
				animation.addByPrefix('scared', 'BF idle shaking', 24);
				animation.addByPrefix('hit', 'BF hit', 24, false);

				loadOffsetFile('bf');

				skins.set('gfSkin', 'gf');
				skins.set('3d', 'bf-3d');

				barColor = FlxColor.fromRGB(49, 176, 209);

				playAnim('idle');

				nativelyPlayable = true;

				flipX = true;
				}
		}
		dance();

		if(isPlayer)
		{
			flipX = !flipX;
		}
	}

	function loadOffsetFile(character:String)
	{
		var offsetStuffs:Array<String> = CoolUtil.coolTextFile(Paths.offsetFile(character));
		
		for (offsetText in offsetStuffs)
		{
			var offsetInfo:Array<String> = offsetText.split(' ');

			addOffset(offsetInfo[0], Std.parseFloat(offsetInfo[1]), Std.parseFloat(offsetInfo[2]));
		}
	}

	override function update(elapsed:Float)
	{
		if (animation == null)
		{
			super.update(elapsed);
			return;
		}
		else if (animation.curAnim == null)
		{
			super.update(elapsed);
			return;
		}
		if (!nativelyPlayable && !isPlayer)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001 * singDuration)
			{
				dance();
				holdTimer = 0;
			}
		}

		switch (curCharacter)
		{
			case 'gf' | 'gf-bent':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;
	private var losedanced:Bool = false;

	/**
	 * FOR DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode && canDance)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-pixel' | 'gf-3d' | 'gf-cool' | 'shaggy' | 'redshaggy' | 'gf-bent':
				if (!animation.curAnim.name.startsWith('hair'))
				{
					danced = !danced;

					if (danced)
						playAnim('danceRight', true);
					else
						playAnim('danceLeft', true);
				}
				default:
					playAnim('idle', true);
			}
			
		}
	}

	public function danceLose()
	{
		if (losedanced)
			playAnim('deathLoopRight', true);
		else
			playAnim('deathLoopLeft', true);

		losedanced = !losedanced;
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		if (animation.getByName(AnimName) == null)
		{
			return; //why wasn't this a thing in the first place
		}
		if((AnimName.toLowerCase() == 'idle' || AnimName.toLowerCase().startsWith('dance')) && !canDance)
		{
			return;
		}
				
		if(AnimName.toLowerCase().startsWith('sing') && !canSing)
		{
			return;
		}
				
		animation.play(AnimName, Force, Reversed, Frame);
			
		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0] * offsetScale, daOffset[1] * offsetScale);
		}
				
		else
			offset.set(0, 0);
			
		if (curCharacter == 'gf')
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}
		
			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}		
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}
}
