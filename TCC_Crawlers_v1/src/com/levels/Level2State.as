package com.levels
{
	import com.ImageConstants;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Level2State extends Level
	{
		
		public function Level2State(levelSWF:MovieClip = null, debugSprite:Sprite = null)
		{
			super(levelSWF);
		}
		
		override public function initialize():void
		{
			super.initialize();
		}
		
		override public function addBackground(imageName:String = "", imageURL:String=""):void
		{
			super.addBackground(ImageConstants.BACKGROUND_NAME, ImageConstants.BACKGROUND_TUTORIAL2);
		}
		
		override public function addUpPart(imageURL:String="", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL2_SCAFFOLDING);
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL2, 1.1);
		}
	}
}