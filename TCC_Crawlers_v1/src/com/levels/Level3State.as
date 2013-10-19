package com.levels
{
	import com.ImageConstants;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class Level3State extends Level
	{
		
		public function Level3State(levelSWF:MovieClip, debugSprite:Sprite = null)
		{
			super(levelSWF);
		}
		
		override public function initialize():void
		{
			super.initialize();
		}
		
		override public function addBackground(imageName:String = "", imageURL:String=""):void
		{
			super.addBackground(ImageConstants.BACKGROUND_NAME, ImageConstants.BACKGROUND_TUTORIAL3);
		}
		
		override public function addUpPart(imageURL:String="", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL3, 1.1, 1.1);
		}
	}
}