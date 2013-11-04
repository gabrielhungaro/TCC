package com.states
{
	import com.data.ASharedObject;
	import com.data.SoundList;
	
	import flash.events.MouseEvent;
	
	import citrus.sounds.SoundManager;
	
	public class MainMenu extends AState
	{
		private var mainMenuAsset:MainMenuAsset;
		private var optionScreen:OptionsState;
		
		public function MainMenu()
		{
			super();
			SoundManager.getInstance().playSound(SoundList.SOUND_MAIN_MENU_BACKGROUND_NAME);
		}
		
		override public function initialize():void
		{
			super.initialize();
			mainMenuAsset = new MainMenuAsset();
			this.addChild(mainMenuAsset);
			
			mainMenuAsset.btnPlay.buttonHit.alpha = 0;
			mainMenuAsset.btnPlay.buttonHit.addEventListener(MouseEvent.CLICK, onClickPlay);
			mainMenuAsset.btnPlay.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenuAsset.btnPlay.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mainMenuAsset.btnPlay.buttonHit.buttonMode = true;
			
			mainMenuAsset.btnOptions.buttonHit.alpha = 0;
			mainMenuAsset.btnOptions.buttonHit.addEventListener(MouseEvent.CLICK, onClickOptions);
			mainMenuAsset.btnOptions.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenuAsset.btnOptions.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mainMenuAsset.btnOptions.buttonHit.buttonMode = true;
			
			mainMenuAsset.btnExit.buttonHit.alpha = 0;
			mainMenuAsset.btnExit.buttonHit.addEventListener(MouseEvent.CLICK, onClickExit);
			mainMenuAsset.btnExit.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenuAsset.btnExit.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mainMenuAsset.btnExit.buttonHit.buttonMode = true;
			
			mainMenuAsset.btnCredits.buttonHit.alpha = 0;
			mainMenuAsset.btnCredits.buttonHit.addEventListener(MouseEvent.CLICK, onClickCredits);
			mainMenuAsset.btnCredits.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			mainMenuAsset.btnCredits.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			mainMenuAsset.btnCredits.buttonHit.buttonMode = true;
		}
		
		protected function onClickPlay(event:MouseEvent):void
		{
			ASharedObject.getInstance().getCitrusEngineRef().levelManager.gotoLevel(StateManager.STATE_TUTORIAL_PT1);
		}
		
		protected function onClickExit(event:MouseEvent):void
		{
			//_ce.levelManager.gotoLevel(StateManager.STATE_CREDITS);
		}
		
		protected function onClickOptions(event:MouseEvent):void
		{
			ASharedObject.getInstance().getCitrusEngineRef().levelManager.gotoLevel(StateManager.STATE_OPTIONS);
		}
		
		protected function onClickCredits(event:MouseEvent):void
		{
			ASharedObject.getInstance().getCitrusEngineRef().levelManager.gotoLevel(StateManager.STATE_CREDITS);
		}
		
		private function closeOptions():void
		{
			optionScreen.destroy();
			if(optionScreen){
				if(this.contains(optionScreen)){
					this.removeChild(optionScreen);
				}
			}
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			//TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1.3 }} );
			event.currentTarget.gotoAndStop("over");
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			//TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1 }} );
			event.currentTarget.gotoAndStop("out");
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			/*if(mainMenuAsset){
				if(mainMenuAsset.currentFrame == mainMenuAsset.totalFrames){
					_ce.levelManager.gotoLevel(StateManager.STATE_TUTORIAL_PT1);
				}
			}*/
		}
		
		override public function destroy():void
		{
			if(mainMenuAsset){
				if(this.contains(mainMenuAsset)){
					this.removeChild(mainMenuAsset);
					mainMenuAsset = null;
				}
			}
			SoundManager.getInstance().stopAllPlayingSounds();
			super.destroy();
		}
	}
}