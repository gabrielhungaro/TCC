package com.levels
{
	import com.ImageConstants;
	import com.data.SoundList;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import citrus.sounds.SoundManager;
	
	public class Level1Part2 extends Level
	{
		
		public function Level1Part2(levelSWF:MovieClip = null, debugSprite:Sprite = null)
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
			super.addBackground(ImageConstants.BACKGROUND_NAME, ImageConstants.BACKGROUND_LEVEL1_PART2);
			super.addBackgroundInsanity(ImageConstants.BACKGROUND_INSANITY_NAME, ImageConstants.BACKGROUND_LEVEL1_PART2_INSANITY);
		}
		
		override public function addUpPart(imageURL:String="", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			super.addUpPart(ImageConstants.UP_PART_LEVEL1_PART2_SCAFFOLDING, 1.1);
			super.addUpPartInsanity(ImageConstants.UP_PART_LEVEL1_PART2_SCAFFOLDING_INSANITY, 1.1);
			super.addUpPart(ImageConstants.UP_PART_LEVEL1_PART2, 1.1);
			super.addUpPartInsanity(ImageConstants.UP_PART_LEVEL1_PART2_INSANITY, 1.1);
		}
		
		override protected function loadSounds():void
		{
			super.loadSounds();
			SoundManager.getInstance().playSound(SoundList.SOUND_TUTORIAL1_BACKGROUND_NAME);
		}
	}
}