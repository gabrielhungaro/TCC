package com.levels
{
	import com.ImageConstants;
	import com.data.SoundList;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import citrus.sounds.SoundManager;
	
	public class TutorialPart1State extends Level
	{
		
		public function TutorialPart1State(levelSWF:MovieClip = null, debugSprite:Sprite = null)
		{
			super(levelSWF);
			addLoadingScreen(ImageConstants.BACKGROUND_TUTORIAL1);
		}
		
		override public function initialize():void
		{
			super.initialize();
		}
		
		override public function addBackground(imageName:String = "", imageURL:String=""):void
		{
			super.addBackground(ImageConstants.BACKGROUND_NAME, ImageConstants.BACKGROUND_TUTORIAL1);
			super.addBackgroundInsanity(ImageConstants.BACKGROUND_INSANITY_NAME, ImageConstants.BACKGROUND_TUTORIAL1_INSANITY);
		}
		
		override public function addUpPart(imageURL:String="", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			super.addUpPart(ImageConstants.UP_PART_TUTORIAL1, 1.1);
			super.addUpPartInsanity(ImageConstants.UP_PART_TUTORIAL1_INSANITY, 1.1);
		}
		
		override protected function loadSounds():void
		{
			super.loadSounds();
			SoundManager.getInstance().playSound(SoundList.SOUND_TUTORIAL1_BACKGROUND_NAME);
		}
	}
}