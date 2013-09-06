package com
{
	import com.levels.Level1State;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.system.Security;
	
	import citrus.core.CitrusEngine;
	import citrus.input.controllers.Keyboard;
	
	[SWF(width=800,height=600)]
	public class TCC_Citrus_Test extends CitrusEngine
	{
		Security.allowDomain("*");
		private var level1State:Level1State;
		private var debugSprite:Sprite = new Sprite();
		
		[Embed(source="../../levels/level1.swf")]
		private var level1:Class;
		
		public function TCC_Citrus_Test()
		{
			sound.addSound("Hurt", "../sounds/Hurt.mp3");
			sound.addSound("Kill", "../sounds/Kill.mp3");
			
			//this.console.addCommand("invert", invertAll);
			
			//TODO tirar essa merda daqui substituir pelo carregamento correto
			var mc:Level1 = new Level1();
			level1State = new Level1State(mc, debugSprite);
			state = level1State;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handlerLoadCompelete);
			//loader.load(new URLRequest(level1));
			
			//this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			//this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
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