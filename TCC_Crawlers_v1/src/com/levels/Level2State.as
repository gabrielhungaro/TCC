package com.levels
{
	import com.ImageConstants;
	import com.hero.MyHero;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import citrus.math.MathVector;
	
	public class Level2State extends Level
	{
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		
		public function Level2State(levelSWF:MovieClip, debugSprite:Sprite = null)
		{
			super();
			this._levelSWF = levelSWF;
			_debugSprite = debugSprite;
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			//ObjectMaker2D.FromMovieClip(_levelSWF);
			
			//createHero();
			//setUpCamera();
		}
		
		override public function addBackground(imageURL:String=""):void
		{
			super.addBackground(ImageConstants.BACKGROUND_TUTORIAL2);
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
			hero.setInitialPos(new Point(hero.x + 100, hero.y))
			hero.init();
		}
	}
}