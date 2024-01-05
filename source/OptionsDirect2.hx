import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;

class OptionsDirect2 extends MusicBeatState
{
	var bgShader:Shaders.GlitchEffect;
	var awaitingExploitation:Bool;
	var menuBG:FlxSprite = new FlxSprite();

	var colorArray:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0, 0)
	];

	override function create()
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.8, true);
		#if not web
		Paths.clearUnusedMemory();
        Paths.clearStoredMemory();
		#end

		persistentUpdate = true;

		awaitingExploitation = (FlxG.save.data.exploitationState == 'awaiting');

		if (awaitingExploitation)
		{
			menuBG = new FlxSprite(-600, -200).loadGraphic(Paths.image('backgrounds/void/redsky', 'shared'));
			menuBG.scrollFactor.set();
			menuBG.antialiasing = false;
			add(menuBG);
			
			if(FlxG.save.data.waving){
			#if SHADERS_ENABLED
			bgShader = new Shaders.GlitchEffect();
			bgShader.waveAmplitude = 0.1;
			bgShader.waveFrequency = 5;
			bgShader.waveSpeed = 2;
			
			menuBG.shader = bgShader.shader;
			#end
		    }
		}
		else
		{
			menuBG.color = 0xFFea71fd;
			menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
			menuBG.updateHitbox();
			menuBG.antialiasing = FlxG.save.data.globalAntialiasing;
			menuBG.loadGraphic(MainMenuState.randomizeBG());
			add(menuBG);
		}

		openSubState(new ModifiersState());
		
		tweenColorShit();
	}

	override function update(elapsed:Float){
		super.update(elapsed);

		if(FlxG.save.data.waving){
		#if SHADERS_ENABLED
		if (bgShader != null)
		{
			bgShader.shader.uTime.value[0] += elapsed;
		}
		#end
	    }
	}

	function tweenColorShit()
	{
		var beforeInt = FlxG.random.int(0, 6);
		var randomInt = FlxG.random.int(0, 6);

		FlxTween.color(menuBG, 4, menuBG.color, colorArray[beforeInt], {
			onComplete: function(twn)
			{
				if (beforeInt != randomInt)
					beforeInt = randomInt;

				tweenColorShit();
			}
		});
	}
}
