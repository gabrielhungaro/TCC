package com.levels
{
	import com.ImageConstants;
	import com.hero.MyHero;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Level1State extends Level
	{
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		
		public function Level1State(levelSWF:MovieClip = null, debugSprite:Sprite = null)
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
			super.addBackground(ImageConstants.BACKGROUND_TUTORIAL1);
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL1);
		}
	}
}