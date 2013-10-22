package com.levels
{
	import com.ImageConstants;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class TutorialPart2State extends Level
	{
		
		public function TutorialPart2State(levelSWF:MovieClip = null, debugSprite:Sprite = null)
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
			super.addBackgroundInsanity(ImageConstants.BACKGROUND_INSANITY_NAME, ImageConstants.BACKGROUND_TUTORIAL2_INSANITY);
		}
		
		override public function addUpPart(imageURL:String="", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL2_SCAFFOLDING);
			super.addUpPartInsanity(ImageConstants.UP_PART_TUTORIAL2_SCAFFOLDING_INSANITY);
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL2, 1.1);
			super.addUpPartInsanity(ImageConstants.UP_PART_TUTORIAL2_INSANITY, 1.1);
		}
	}
}