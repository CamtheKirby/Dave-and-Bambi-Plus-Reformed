package;

import flixel.input.gamepad.FlxGamepad;
import openfl.Lib;
import flixel.FlxG;

/**
 * handles save data initialization 
*/
class SaveDataHandler
{
    public static function initSave()
    {
        if (FlxG.save.data.antialiasing == null)
			FlxG.save.data.antialiasing = true;

		if (FlxG.save.data.newInput == null)
			FlxG.save.data.newInput = true;

		if (FlxG.save.data.ghost == null)
			FlxG.save.data.ghost = true;

	    if (FlxG.save.data.fpsRain == null)
		   FlxG.save.data.fpsRain = false;

		if (FlxG.save.data.framerate == null)
			FlxG.save.data.framerate = 140;

		if (FlxG.save.data.blurNotes == null)
			FlxG.save.data.blurNotes = false;

		if (FlxG.save.data.micedUpSus == null)
			FlxG.save.data.micedUpSus = true;

		if (FlxG.save.data.judgementCounter == null)
			FlxG.save.data.judgementCounter = true;

		if (FlxG.save.data.showCombo == null)
			FlxG.save.data.showCombo = true;

		if (FlxG.save.data.camZooms == null)
			FlxG.save.data.camZooms = true;

		if (FlxG.save.data.scoreZoom == null)
			FlxG.save.data.scoreZoom = true;

		if (FlxG.save.data.resetButton == null)
			FlxG.save.data.resetButton = false;

		if (FlxG.save.data.instaRestart == null)
			FlxG.save.data.instaRestart = false;

		if (FlxG.save.data.hideHud == null)
			FlxG.save.data.hideHud = false;

		if (FlxG.save.data.ratingSystemNum == null)
			FlxG.save.data.ratingSystemNum = 0;

		if (FlxG.save.data.middlescroll == null)
			FlxG.save.data.middlescroll = false;

		if (FlxG.save.data.colorBars == null)
			FlxG.save.data.colorBars = true;
		
		if (FlxG.save.data.downscroll == null)
			FlxG.save.data.downscroll = false;

		if (FlxG.save.data.eyesores == null)
			FlxG.save.data.eyesores = true;

		if (FlxG.save.data.hitVolume == null)
			FlxG.save.data.hitVolume = 0.5;

		if (FlxG.save.data.freeplayCuts == null)
			FlxG.save.data.freeplayCuts = false;

		if (FlxG.save.data.npsDisplay == null)
			FlxG.save.data.npsDisplay = false;

		if (FlxG.save.data.accuracyDisplay == null)
			FlxG.save.data.accuracyDisplay = true;

		if (FlxG.save.data.kadeInput == null)
			FlxG.save.data.kadeInput = false;

		if (FlxG.save.data.donoteclickoppo == null)
			FlxG.save.data.donoteclickoppo = false;

		if (FlxG.save.data.missSounds == null)
			FlxG.save.data.missSounds = true;

		if (FlxG.save.data.waving == null)
			FlxG.save.data.waving = true;

		if (FlxG.save.data.shaders == null)
			FlxG.save.data.shaders = true;

		if (FlxG.save.data.newInput != null && FlxG.save.data.lastversion == null)
			FlxG.save.data.lastversion = "pre-beta2";
		
		if (FlxG.save.data.newInput == null && FlxG.save.data.lastversion == null)
			FlxG.save.data.lastversion = "beta2";
		
		if (FlxG.save.data.songPosition == null)
			FlxG.save.data.songPosition = true;
		
		if (FlxG.save.data.noteCamera == null)
			FlxG.save.data.noteCamera = true;
		
		if (FlxG.save.data.offset == null)
			FlxG.save.data.offset = 0;

		if (FlxG.save.data.selfAwareness == null)
			FlxG.save.data.selfAwareness = true;

		if (FlxG.save.data.colorQ == null)
			FlxG.save.data.colorQ = false;

		if (FlxG.save.data.devMode == null)
			#if !debug
			FlxG.save.data.devMode = false;
			#else
			FlxG.save.data.devMode = true;
			#end

		if (FlxG.save.data.comboSound == null)
			FlxG.save.data.comboSound = false;

		if (FlxG.save.data.compactNumbers == null)
			FlxG.save.data.compactNumbers = true;

		if (FlxG.save.data.cpuStrums == null)
			FlxG.save.data.cpuStrums = false;

		if (FlxG.save.data.comboFlash == null)
			FlxG.save.data.comboFlash = false;
		
		if (FlxG.save.data.wasInCharSelect == null)
			FlxG.save.data.wasInCharSelect = false;

		if (FlxG.save.data.charactersUnlocked == null)
			FlxG.save.data.charactersUnlocked = ['bf', 'bf-pixel'];

		if (FlxG.save.data.disableFps == null)
			FlxG.save.data.disableFps = false;

		if (FlxG.save.data.gpuRender == null)
		{
			#if html5
			FlxG.save.data.gpuRender = false;
			#else
			FlxG.save.data.gpuRender = true;
			#end
		}

		if (FlxG.save.data.moreMaxHP == null)
			FlxG.save.data.moreMaxHP = false;
		
		if (FlxG.save.data.masterWeekUnlocked == null)
			FlxG.save.data.masterWeekUnlocked = false;

		if (FlxG.save.data.enteredTerminalCheatingState == null)
			FlxG.save.data.enteredTerminalCheatingState = false;
			
		if (FlxG.save.data.hasSeenCreditsMenu == null)
			FlxG.save.data.hasSeenCreditsMenu = false;

		if (FlxG.save.data.communityGameMode  == null)
			FlxG.save.data.communityGameMode  = false;

		if (FlxG.save.data.PlayerStrums  == null)
			FlxG.save.data.PlayerStrums  = false;
		
		if (FlxG.save.data.songBarOption == null)
			FlxG.save.data.songBarOption = 'ShowTime';

		if (FlxG.save.data.timeBarType == null)
			FlxG.save.data.timeBarType = 'Time Left';

		if (FlxG.save.data.ColorBlindType == null)
			FlxG.save.data.ColorBlindType = 'None';

		if (FlxG.save.data.iconBounceType == null)
			FlxG.save.data.iconBounceType = 'Dave and Bambi Plus';

		if (FlxG.save.data.doubleGhost == null)
			FlxG.save.data.doubleGhost = true;

		if (FlxG.save.data.smoothHealth == null)
			FlxG.save.data.smoothHealth = 'Golden Apple 1.5';

		if (FlxG.save.data.ColorBlindTypeNum == null)
			FlxG.save.data.ColorBlindTypeNum = false;

		if (FlxG.save.data.greenscreenmode == null)
			FlxG.save.data.greenscreenmode = false;

		if (FlxG.save.data.lowQuality == null)
			FlxG.save.data.lowQuality = false;

		if (FlxG.save.data.botplay == null)
			FlxG.save.data.botplay = false;

		if (FlxG.save.data.pMode == null)
			FlxG.save.data.pMode = false;

		if (FlxG.save.data.thebetterscore == null)
			FlxG.save.data.thebetterscore = true;

		if (FlxG.save.data.hitSound == null)
			FlxG.save.data.hitSound = 0;

		/*if (FlxG.save.data.shitMs == null)
			FlxG.save.data.shitMs = 160.0;*/

		if (FlxG.save.data.badWindow == null)
			FlxG.save.data.badWindow = 135;

		if (FlxG.save.data.goodWindow == null)
			FlxG.save.data.goodWindow = 90;

		if (FlxG.save.data.sickWindow == null)
			FlxG.save.data.sickWindow = 45;

		/*Ratings.timingWindows = [
			FlxG.save.data.shitMs,
			FlxG.save.data.badMs,
			FlxG.save.data.goodMs,
			FlxG.save.data.sickMs
		];*/

		if (FlxG.save.data.safeFrames == null)
			FlxG.save.data.safeFrames = 10;

		(cast(Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.framerate);
    }

	public static function resetModifiers():Void
	{
		FlxG.save.data.hgain = 1;
		FlxG.save.data.hloss = 1;
		FlxG.save.data.hdrain = false;
		FlxG.save.data.sustains = true;
		FlxG.save.data.noMisses = false;
		FlxG.save.data.modcharts = true;
		FlxG.save.data.mainaNotesLoly = 0;
		FlxG.save.data.practice = false;
		FlxG.save.data.rns = false;
		FlxG.save.data.opponent = false;
		FlxG.save.data.mirror = false;
		FlxG.save.data.random = false;
		FlxG.save.data.stair = false;
		FlxG.save.data.jackingtime = 0;
		FlxG.save.data.randomspeed = 1;
	}
}