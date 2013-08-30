package com.levels
{
	import com.hero.HeroActions;
	import com.hero.MyHero;
	import com.hero.Shadow;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	public class Level extends State
	{
		public var _levelSWF:MovieClip;
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		private var shadow:Shadow;
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
			
			addBackground();
			
			ObjectMaker2D.FromMovieClip(_levelSWF);
			
			createHero();
			createShadow();
			setUpCamera();
		}
		
		private function addBackground():void
		{
			var bg:CitrusSprite = new CitrusSprite("background", {view: "../lib/bg_level1_resize.jpg", width:10, height:stage.stageHeight});
			bg.parallaxX = 1;
			add(bg);
		}
		
		private function setUpCamera():void
		{
			view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			view.camera.restrictZoom = true;
			
			//LIBERA A ROTAÇÃO DA CAMERA
			view.camera.allowRotation = true;
		}
		
		private function createHero():void
		{
			hero = getObjectByName("Hero") as MyHero;
			hero.name = "Hero";
			hero.setState(this);
			hero.setWorld(this.box2D.world);
			hero.setWorldScale(this.box2D.scale);
			hero.setInitialPos(new Point(hero.x, hero.y))
			hero.init();
		}
		
		private function createShadow():void
		{
			shadow = new Shadow();
			//shadow.setAsset(hero.getViewAsMovieClip());
			shadow.setHero(hero);
			//shadow.x = hero.x - hero.width/2;
			//shadow.y = hero.y - hero.height/2;
			this.addChild(shadow);
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
				if(shadow){
					shadow.update();
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