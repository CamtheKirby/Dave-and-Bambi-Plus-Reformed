package;

import flixel.group.FlxGroup;
import haxe.Json;
import haxe.Http;
import flixel.math.FlxRandom;
import Controls.Control;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.addons.display.FlxBackdrop;
import lime.app.Application;
import openfl.Lib;
import OptionsMenu;

class PauseSubState extends MusicBeatSubstate
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;
	var bg:FlxBackdrop;

	var pausebg:FlxSprite;
	var pausebg1:FlxSprite;
	var iconBG:FlxSprite;
	var icon:HealthIcon;

	public static var goToOptions:Bool = false;
    public static var goBack:Bool = false;

	var colorArray:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0, 0)
	];

	var menuItems:Array<PauseOption> = [
		new PauseOption('Resume'),
		new PauseOption('Restart Song'),
		new PauseOption('Change Character'),
		new PauseOption('Pause Options'),
		new PauseOption('Pause Modifiers'),
		new PauseOption('No Miss Mode'),
		new PauseOption('Exit to menu')
	];
	var curSelected:Int = 0;

	public static var playingPause:Bool = false;

	var pauseMusic:FlxSound;
	var expungedSelectWaitTime:Float = 0;
	var timeElapsed:Float = 0;
	var patienceTime:Float = 0;

	public var funnyTexts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	public function new(x:Float, y:Float)
	{
		super();

		for (i in FlxG.sound.list)
		{
			if (i.playing && i.ID != 9000)
				i.pause();
		}
	
		if (!playingPause)
		{
			playingPause = true;
			pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
			pauseMusic.volume = 0;
			pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));
			pauseMusic.ID = 9000;
	
			FlxG.sound.list.add(pauseMusic);
		}
		else
		{
			for (i in FlxG.sound.list)
			{
				if (i.ID == 9000) // jankiest static variable
					pauseMusic = i;
			}
		}

		
		funnyTexts = new FlxTypedGroup<FlxText>();
		add(funnyTexts);

		switch (PlayState.SONG.song.toLowerCase())
		{
			default:
				pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast'), true, true);
			case "exploitation":
				pauseMusic = new FlxSound().loadEmbedded(Paths.music('breakfast-ohno'), true, true);
				expungedSelectWaitTime = new FlxRandom().float(2, 7);
				patienceTime = new FlxRandom().float(15, 30);
		}
		
		pauseMusic.volume = 0;
		pauseMusic.play(false, FlxG.random.int(0, Std.int(pauseMusic.length / 2)));

		FlxG.sound.list.add(pauseMusic);

		var backBg:FlxSprite = new FlxSprite();
		backBg.makeGraphic(FlxG.width + 1, FlxG.height + 1, FlxColor.BLACK);
		backBg.alpha = 0;
		backBg.scrollFactor.set();
		add(backBg);

		if (!FlxG.save.data.lowQuality)
		{
			bg = new FlxBackdrop(Paths.image('ui/checkeredBG', 'preload'), 1, 1, true, true, 1, 1);
			bg.alpha = 0;
			bg.antialiasing = FlxG.save.data.globalAntialiasing;
			bg.scrollFactor.set();
			add(bg);

			pausebg = new FlxSprite().loadGraphic(Paths.image('ui/pausemenubg'));
			pausebg.color = 0xFF1E1E1E;
			pausebg.scrollFactor.set();
			pausebg.updateHitbox();
			pausebg.screenCenter();
			pausebg.antialiasing = FlxG.save.data.globalAntialiasing;
			add(pausebg);
			pausebg.x += 200;
			pausebg.y -= 200;
			pausebg.alpha = 0;
			FlxTween.tween(pausebg, {
				x: 0,
				y: 0,
				alpha: 1
			}, 1, {ease: FlxEase.quadOut});
	
			pausebg1 = new FlxSprite().loadGraphic(Paths.image('ui/iconbackground'));
			pausebg1.color = 0xFF141414;
			pausebg1.scrollFactor.set();
			pausebg1.updateHitbox();
			pausebg1.screenCenter();
			pausebg1.antialiasing = FlxG.save.data.globalAntialiasing;
			add(pausebg1);
			pausebg1.x -= 150;
			pausebg1.y += 150;
			pausebg1.alpha = 0;
			FlxTween.tween(pausebg1, {
				x: 0,
				y: 0,
				alpha: 1
			}, 0.9, {ease: FlxEase.quadOut});
	
			iconBG = new FlxSprite().loadGraphic(Paths.image('ui/iconbackground'));
			iconBG.flipX = true;
			iconBG.scrollFactor.set();
			iconBG.updateHitbox();
			iconBG.screenCenter();
			iconBG.antialiasing = FlxG.save.data.globalAntialiasing;
			add(iconBG);
			iconBG.x += 100;
			iconBG.y += 100;
			iconBG.alpha = 0;
			FlxTween.tween(iconBG, {
				x: 0,
				y: 0,
				alpha: 1
			}, 0.8, {ease: FlxEase.quadOut});
		}

		var levelInfo:FlxText = new FlxText(20, 15, 0, "", 32);
		levelInfo.text += PlayState.SONG.song;
		levelInfo.scrollFactor.set();
		levelInfo.setFormat(Paths.font("comic.ttf"), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		levelInfo.antialiasing = FlxG.save.data.globalAntialiasing;
		levelInfo.borderSize = 2.5;
		levelInfo.updateHitbox();
		add(levelInfo);

		var levelDifficulty:FlxText = new FlxText(20, 15 + 32, 0, "", 32);
		levelDifficulty.text += CoolUtil.difficultyString();
		levelDifficulty.scrollFactor.set();
		levelDifficulty.setFormat(Paths.font('comic.ttf'), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		levelDifficulty.antialiasing = FlxG.save.data.globalAntialiasing;
		levelDifficulty.borderSize = 2.5;
		levelDifficulty.updateHitbox();
		if ((PlayState.SONG.song.toLowerCase() == 'exploitation' && !PlayState.isGreetingsCutscene) || PlayState.storyDifficulty != 1)
		{
			add(levelDifficulty);
		}

		levelDifficulty.alpha = 0;
		levelInfo.alpha = 0;

		levelInfo.x = FlxG.width - (levelInfo.width + 20);
		levelDifficulty.x = FlxG.width - (levelDifficulty.width + 20);

		FlxTween.tween(backBg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bg, {alpha: 0.6}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(levelInfo, {alpha: 1, y: 20}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3});
		FlxTween.tween(levelDifficulty, {alpha: 1, y: levelDifficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.5,
		onComplete: function(tween:FlxTween)
		{
			switch (PlayState.SONG.song.toLowerCase())
			{
				case 'exploitation':
					doALittleTrolling(levelDifficulty);
			}
		}});
		if (PlayState.isStoryMode || FreeplayState.skipSelect.contains(PlayState.SONG.song.toLowerCase()) || PlayState.instance.localFunny == PlayState.CharacterFunnyEffect.Recurser)
		{
			menuItems.remove(PauseOption.getOption(menuItems, 'Change Character'));
		}
		for (item in menuItems)
		{
			if (PlayState.instance.localFunny == PlayState.CharacterFunnyEffect.Recurser)
			{
				if(item.optionName != 'Resume' && item.optionName != 'No Miss Mode')
				{
					menuItems.remove(PauseOption.getOption(menuItems, item.optionName));
				}
				continue;
			}
		}

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, LanguageManager.getTextString('${menuItems[i].optionName}'), true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
        }

		changeSelection();

		tweenColorShit();
		tweenColorShit2();
		tweenColorShit3();
		tweenColorShit4();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float)
	{
		var scrollSpeed:Float = 50;
		bg.x -= scrollSpeed * elapsed;
		bg.y -= scrollSpeed * elapsed;

		timeElapsed += elapsed;
		if (pauseMusic.volume < 0.75)
			pauseMusic.volume += 0.01 * elapsed;

		super.update(elapsed);

		var upP = controls.UP_P;
		var downP = controls.DOWN_P;
		var accepted = controls.ACCEPT;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}
		if (PlayState.SONG.song.toLowerCase() == 'exploitation' && this.exists && PauseSubState != null)
		{
			if (expungedSelectWaitTime >= 0)
			{
				expungedSelectWaitTime -= elapsed;
			}
			else
			{
				expungedSelectWaitTime = new FlxRandom().float(0.5, 2);
				changeSelection(new FlxRandom().int((menuItems.length - 1) * -1, menuItems.length - 1));
			}
		}

		if (accepted)
		{
			selectOption();
		}
	}
	function selectOption()
	{
		var daSelected:String = menuItems[curSelected].optionName;

		switch (daSelected)
		{
			case "Resume":
				close();
			case "Restart Song":
				FlxG.sound.music.volume = 0;
				PlayState.instance.vocals.volume = 0;

				PlayState.instance.shakeCam = false;
				PlayState.instance.camZooming = false;
				if (PlayState.SONG.song.toLowerCase() == "exploitation")
				{
					if (PlayState.window != null)
					{
						PlayState.window.close();
					}
				}
				FlxG.mouse.visible = false;
				FlxG.resetState();
			case "Pause Options":
				if (MathGameState.failedGame)
					{
						MathGameState.failedGame = false;
					}
				PlayState.instance.vocals.volume = 0;
				FlxG.switchState(new OptionsDirect());
				OptionsMenu.onPlayState = true;
				case "Pause Modifiers":
					if (MathGameState.failedGame)
						{
							MathGameState.failedGame = false;
						}
				PlayState.instance.vocals.volume = 0;
				FlxG.switchState(new OptionsDirect2());
				ModifiersState.onPlayStateM = true;
			case "Change Character":
				if (MathGameState.failedGame)
					{
						MathGameState.failedGame = false;
					}
					funnyTexts.clear();
					PlayState.characteroverride = 'none';
					PlayState.formoverride = 'none';
					PlayState.recursedStaticWeek = false;
	
					Application.current.window.title = Main.applicationName;
	
					if (PlayState.SONG.song.toLowerCase() == "exploitation")
					{
						Main.toggleFuckedFPS(false);
						if (PlayState.window != null)
						{
							PlayState.window.close();
						}
					}
					PlayState.instance.shakeCam = false;
					PlayState.instance.camZooming = false;
					FlxG.mouse.visible = false;
					FlxG.switchState(new CharacterSelectState());
			case "No Miss Mode":
				PlayState.instance.noMiss = !PlayState.instance.noMiss;
				var nm = PlayState.SONG.song.toLowerCase();
				if (['exploitation', 'cheating',  'rigged', 'unfairness', 'recursed', 'glitch', 'master', 'supernovae', 'secret', 'secret-mod-leak', 'importumania'].contains(nm))
				{
					PlayState.instance.health = 0;
					close();
				}
			case "Exit to menu":
				if (MathGameState.failedGame)
				{
					MathGameState.failedGame = false;
				}
				funnyTexts.clear();
				PlayState.characteroverride = 'none';
				PlayState.formoverride = 'none';
				PlayState.recursedStaticWeek = false;

				Application.current.window.title = Main.applicationName;

				if (PlayState.SONG.song.toLowerCase() == "exploitation")
				{
					Main.toggleFuckedFPS(false);
					if (PlayState.window != null)
					{
						PlayState.window.close();
					}
				}
				if (FlxG.save.data.framerate > 300)
					(cast(Lib.current.getChildAt(0), Main)).setFPSCap(300);
				PlayState.instance.shakeCam = false;
				PlayState.instance.camZooming = false;
				FlxG.mouse.visible = false;
				if (PlayState.isStoryMode) {
				//FlxG.switchState(new MainMenuState());
				FlxG.switchState(new StoryMenuState());
				} else {
					FlxG.switchState(new FreeplayState());
				}
		}
	}
	function tweenColorShit()
	{
		var beforeInt = FlxG.random.int(0, 6);
		var randomInt = FlxG.random.int(0, 6);
	
		FlxTween.color(iconBG, 4, iconBG.color, colorArray[beforeInt], {
			onComplete: function(twn)
			{
				if (beforeInt != randomInt)
					beforeInt = randomInt;
	
				tweenColorShit();
			}
		});
	}
	function tweenColorShit2()
	{
		var beforeInt = FlxG.random.int(0, 6);
		var randomInt = FlxG.random.int(0, 6);
		
		FlxTween.color(pausebg, 4, pausebg.color, colorArray[beforeInt], {
			onComplete: function(twn)
			{
				if (beforeInt != randomInt)
					beforeInt = randomInt;
		
				tweenColorShit2();
			}
		});
	}
	function tweenColorShit3()
	{
		var beforeInt = FlxG.random.int(0, 6);
		var randomInt = FlxG.random.int(0, 6);
			
		FlxTween.color(pausebg1, 4, pausebg1.color, colorArray[beforeInt], {
			onComplete: function(twn)
			{
				if (beforeInt != randomInt)
					beforeInt = randomInt;
		
				tweenColorShit3();
			}
		});
	}
	function tweenColorShit4()
	{
		var beforeInt = FlxG.random.int(0, 6);
		var randomInt = FlxG.random.int(0, 6);
				
		FlxTween.color(bg, 4, bg.color, colorArray[beforeInt], {
			onComplete: function(twn)
			{
				if (beforeInt != randomInt)
					beforeInt = randomInt;
				
				tweenColorShit4();
			}
		});
	}
	override function close()
	{
		funnyTexts.clear();

		super.close();
	}

	override function destroy()
	{
	//	if (!goToOptions)
		//{
		//    pauseMusic.destroy();
		//	playingPause = false;
		//}
		super.destroy();
	}

	function doALittleTrolling(levelDifficulty:FlxText)
	{
		var difficultyHeight = levelDifficulty.height;
		var amountOfDifficulties = Math.ceil(FlxG.height / difficultyHeight);

		for (i in 0...amountOfDifficulties)
		{
			if (funnyTexts.exists)
			{
				var difficulty:FlxText = new FlxText(20, (15 + 32) * (i + 2), 0, "", 32);
				difficulty.text += levelDifficulty.text;
				difficulty.scrollFactor.set();
				difficulty.setFormat(Paths.font('comic.ttf'), 32, FlxColor.WHITE, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
				difficulty.antialiasing = FlxG.save.data.globalAntialiasing;
				difficulty.borderSize = 2;
				difficulty.updateHitbox();
				funnyTexts.add(difficulty);

				difficulty.alpha = 0;

				difficulty.x = FlxG.width - (difficulty.width + 20);

				FlxTween.tween(difficulty, {alpha: 1, y: difficulty.y + 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.05 * i});
			}
			else
			{
				return;
			}

		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}
class PauseOption
{
	public var optionName:String;

	public function new(optionName:String)
	{
		this.optionName = optionName;
	}
	
	public static function getOption(list:Array<PauseOption>, optionName:String):PauseOption
	{
		for (option in list)
		{
			if (option.optionName == optionName)
			{
				return option;
			}
		}
		return null;
	}
}