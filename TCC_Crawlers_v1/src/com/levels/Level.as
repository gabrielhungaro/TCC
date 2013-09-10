package com.levels
{
	import com.Bat;
	import com.ImageConstants;
	import com.Spike;
	import com.Spike2;
	import com.hero.MyHero;
	import com.objects.Flashlight;
	import com.objects.Stack;
	import com.objects.Torch;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	public class Level extends State implements ILevel
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
		private var isInverted:Boolean;
		private var yGravity:Number;
		
		public function Level()
		{
			super();
			objectsArray = [Platform, Spike, Spike2, MyHero, Torch, Bat, Flashlight, Stack]
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
			setUpCamera();
		}
		
		public function addBackground(imageURL:String = ""):void
		{
			var bg:CitrusSprite = new CitrusSprite("background", {view: imageURL, width:10, height:stage.stageHeight});
			bg.parallaxX = 1;
			add(bg);
		}
		
		public function setUpCamera():void
		{
			view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			view.camera.restrictZoom = true;
			
			//LIBERA A ROTAÇÃO DA CAMERA
			view.camera.allowRotation = true;
		}
		
		public function createHero():void
		{
			hero = getObjectByName("Hero") as MyHero;
			hero.name = "Hero";
			hero.setState(this);
			hero.setWorld(this.box2D.world);
			hero.setWorldScale(this.box2D.scale);
			hero.setInitialPos(new Point(hero.x, hero.y))
			hero.init();
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
		
		public function invertAll():void
		{
			/*if(hero.rotation == 0){
				hero.rotation = 180;
				isInverted = true;
			}else{
				hero.rotation = 0;
				isInverted = false;
			}*/
			view.camera.rotate(Math.PI);
			view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			//trace("Invertendo tudo" + box2D.world.GetGravity().y);
			yGravity = box2D.world.GetGravity().y * (-1);
			box2D.world.SetGravity(new b2Vec2(0, yGravity));
			//_ce.rotation += 5;
			//hero.setInverted(isInverted);
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
		
		public function getCamPos():Point
		{
			return this.view.camera.camPos;
		}
	}
}