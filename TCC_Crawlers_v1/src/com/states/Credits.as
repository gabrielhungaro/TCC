package com.states
{
	import com.greensock.TweenMax;
	
	import flash.events.MouseEvent;

	public class Credits extends AState
	{
		private var creditScreen:CreditsScreenAsset;
		
		public function Credits()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			creditScreen = new CreditsScreenAsset();
			this.addChild(creditScreen);
			
			creditScreen.btnBack.buttonMode = true;
			creditScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			creditScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			creditScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		protected function onClickBack(event:MouseEvent):void
		{
			_ce.levelManager.gotoLevel(StateManager.STATE_MENU);
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1.3 }} );
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1 }} );
		}
		
		override public function destroy():void
		{
			creditScreen.btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
			creditScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			creditScreen.btnBack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			if(creditScreen){
				if(this.contains(creditScreen)){
					this.removeChild(creditScreen);
					creditScreen = null;
				}
			}
		}
	}
}