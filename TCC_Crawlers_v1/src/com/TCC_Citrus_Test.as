package com
{
	import com.levels.Level;
	import com.levels.Level1State;
	import com.levels.Level2State;
	import com.levels.Level3State;
	import com.levels.Level4State;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.ApplicationDomain;
	import flash.system.Security;
	
	import citrus.core.CitrusEngine;
	import citrus.core.IState;
	import citrus.input.controllers.Keyboard;
	import citrus.utils.LevelManager;
	
	[SWF(width=800,height=600)]
	public class TCC_Citrus_Test extends CitrusEngine
	{
		Security.allowDomain("*");
		private var level1State:Level1State;
		private var debugSprite:Sprite = new Sprite();
		
		[Embed(source="../../lib/level1Teste.swf")]
		private var level1:Class;
		
		public function TCC_Citrus_Test()
		{
			//sound.addSound("Hurt", "../sounds/Hurt.mp3");
			//sound.addSound("Kill", "../sounds/Kill.mp3");
			
			//this.console.addCommand("invert", invertAll);
			
			var teste:MovieClip = new level1();
			//this.addChild(teste);
			
			var mc:Level1 = new Level1();
			//level1State = new Level1State(mc, debugSprite);
			//state = level1State;
			
			levelManager = new LevelManager(Level);
			levelManager.applicationDomain = ApplicationDomain.currentDomain; 
			levelManager.onLevelChanged.add(_onLevelChanged);
			levelManager.levels = [[Level1State, "../lib/level1Teste.swf"], [Level2State, "../lib/level2Teste.swf"], [Level3State, "../lib/level3Teste.swf"], [Level4State, "../lib/level4Teste.swf"]];
			//levelManager.levels = [[Level1, "levels/A1/LevelA1.swf"], [Level2, "levels/A2/LevelA2.swf"]];
			levelManager.gotoLevel(); //load the first level, you can change the index. You can also call it later.
			//levelManager.levels = [[Level1State, "level1.swf"], [level2, "level2.swf"]]; 
			
			//TODO tirar essa merda daqui substituir pelo carregamento correto
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handlerLoadCompelete);
			//loader.load(new URLRequest(level1));
			
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function _onLevelChanged(lvl:Level):void {
			
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
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == citrus.input.controllers.Keyboard.Z){
				//if(level1State.getIsInsane()){
					//invertAll();
				//}
			}
		}
		
		protected function handlerLoadCompelete(event:Event):void
		{
			addChild(debugSprite);
			var swfLoaded:MovieClip = event.target.loader.content as MovieClip;
			level1State = new Level1State(swfLoaded, debugSprite);
			state = level1State;
		}
	}
}