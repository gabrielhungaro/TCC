package com
{
	import com.levels.Level;
	import com.levels.Level1State;
	import com.levels.Level2State;
	import com.levels.Level3State;
	import com.levels.Level4State;
	import com.states.AState;
	import com.states.Credits;
	import com.states.MainMenu;
	
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.utils.LevelManager;
	
	[SWF(width="1024",height="768")]
	public class TCC_Citrus_Test extends CitrusEngine
	{
		Security.allowDomain("*");
		private var mainMenu:MainMenu;
		private var level1State:Level1State;
		private var debugSprite:Sprite = new Sprite();
		
		private var levels:Array = [];
		
		public function TCC_Citrus_Test()
		{
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
			levelManager.levels = [MainMenu, Credits, [Level1State, Level1Mc], [Level2State, Level2Mc], [Level3State, Level3Mc], [Level4State, Level4Mc]];
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