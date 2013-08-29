package com.levels
{
	import com.MyHero;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	public class Level extends State
	{
		public var _levelSWF:MovieClip;
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		public var box2D:Box2D;
		
		private var isPaused:Boolean;
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		
		public function Level()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			_ce = CitrusEngine.getInstance();
			
			box2D = new Box2D("box2D");
			box2D.visible = false;
			add(box2D);
			
			var bg:CitrusSprite = new CitrusSprite("background", {view: "../lib/bg_level1_resize.jpg", width:10, height:stage.stageHeight});
			add(bg);
			
			ObjectMaker2D.FromMovieClip(_levelSWF);
		}
		
		override public function update(timeDelta:Number):void
		{
			if(!isPaused){
				super.update(timeDelta);
				box2D.world.Step(1/30, 10, 10);
				
				ticks++;
				if(ticks >= _ce.stage.frameRate){
					ticks = 0;
					seconds++;
				}
				if(seconds >= 60){
					seconds = 0;
					minutes++;
				}
			}
		}
		
		public function getTicks():int
		{
			return ticks;
		}
		
		public function getSeconds():int
		{
			return seconds;
		}
		
		public function getMinutes():int
		{
			return minutes;
		}
	}
}