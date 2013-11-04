package com
{
	import com.data.ASharedObject;
	import com.levels.Level1Part1;
	import com.levels.Level1Part2;
	import com.levels.Level1Part3;
	import com.levels.TutorialPart1State;
	import com.levels.TutorialPart2State;
	import com.levels.TutorialPart3State;
	import com.levels.TutorialPart4State;
	import com.states.AState;
	import com.states.Credits;
	import com.states.MainMenu;
	import com.states.OptionsOffGameState;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.input.controllers.Keyboard;
	import citrus.utils.LevelManager;
	
	[SWF(width="1024",height="768")]
	public class TCC_Citrus_Test extends CitrusEngine
	{
		Security.allowDomain("*");
		private var mainMenu:MainMenu;
		private var debugSprite:Sprite = new Sprite();
		
		private var levels:Array = [];
		
		public function TCC_Citrus_Test()
		{
			ASharedObject.getInstance();
			ASharedObject.getInstance().setKeyboard(this.input.keyboard as Keyboard);
			ASharedObject.getInstance().setCitrusEngineRef(this);
			stage.fullScreenSourceRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			//sound.addSound("Hurt", "../sounds/Hurt.mp3");
			//sound.addSound("Kill", "../sounds/Kill.mp3");
			
			//this.console.addCommand("invert", invertAll);
			
			//mainMenu = new MainMenu();
			//state = mainMenu;
			
			this.console.enabled = false;
			
			levelManager = new LevelManager(AState);
			levelManager.applicationDomain = ApplicationDomain.currentDomain; 
			levelManager.onLevelChanged.add(_onLevelChanged);
			levelManager.levels = [MainMenu, Credits, OptionsOffGameState,
									[TutorialPart1State, Tutorial_part1Mc],
									[TutorialPart2State, Tutorial_part2Mc],
									[TutorialPart3State, Tutorial_part3Mc],
									[TutorialPart4State, Tutorial_part4Mc],
									[Level1Part1, Level1_Part1Mc],
									[Level1Part2, Level1_Part2Mc],
									[Level1Part3, Level1_Part3Mc]];
			levelManager.gotoLevel();
			
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function _onLevelChanged(lvl:AState):void {
			
			state = lvl;
			
			lvl.lvlEnded.add(_nextLevel);
			lvl.restartLevel.add(_restartLevel);
		}
		
		private function _nextLevel():void {
			
			levelManager.nextLevel();
		}
		
		private function _restartLevel():void {
			
			state = levelManager.currentLevel as IState;
		}
	}
}