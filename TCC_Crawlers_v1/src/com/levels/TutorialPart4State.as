package com.levels
{
	import com.ImageConstants;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class TutorialPart4State extends Level
	{
		
		public function TutorialPart4State(levelSWF:MovieClip, debugSprite:Sprite = null)
		{
			super(levelSWF);
		}
		
		override public function initialize():void
		{
			super.initialize();
		}
		
		override public function addBackground(imageName:String = "", imageURL:String=""):void
		{
			super.addBackground(ImageConstants.BACKGROUND_NAME, ImageConstants.BACKGROUND_TUTORIAL4);
			super.addBackgroundInsanity(ImageConstants.BACKGROUND_INSANITY_NAME, ImageConstants.BACKGROUND_TUTORIAL4_INSANITY);
		}
		
		override public function addUpPart(imageURL:String="", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL4, 1.1, 1.1);
			super.addUpPartInsanity(ImageConstants.UP_PART_TUTORIAL4_INSANITY, 1.1), 1.1;
		}
	}
}