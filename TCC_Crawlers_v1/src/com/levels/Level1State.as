package com.levels
{
	import com.Spike;
	import com.Spike2;
	import com.hero.HeroActions;
	import com.hero.MyHero;
	import com.objects.Torch;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import citrus.core.CitrusEngine;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	
	public class Level1State extends Level
	{
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		
		public function Level1State(levelSWF:MovieClip, debugSprite:Sprite)
		{
			super();
			this._levelSWF = levelSWF;
			_debugSprite = debugSprite;
			objectsArray = [Platform, Spike, Spike2, MyHero, Torch]
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			//ObjectMaker2D.FromMovieClip(_levelSWF);
			
			//createHero();
			//setUpCamera();
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
			hero.setState(this);
			hero.setWorld(this.box2D.world);
			hero.setWorldScale(this.box2D.scale);
			hero.setInitialPos(new Point(hero.x, hero.y))
			hero.init();
		}
	}
}