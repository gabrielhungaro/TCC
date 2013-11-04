package com.states
{
	import com.data.ASharedObject;
	
	import flash.events.MouseEvent;
	
	public class NotebookState extends NotebookScreenAsset
	{
		
		private var closeFunction:Function;
		private var optionScreen:OptionsState;
		
		public function NotebookState()
		{
			ASharedObject.getInstance().setIsPaused(true);
			this.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnBack.buttonMode = true;
			this.btnOptions.addEventListener(MouseEvent.CLICK, onClickOptionsButton);
			this.btnOptions.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnOptions.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnOptions.buttonMode = true;
			this.btnPags.addEventListener(MouseEvent.CLICK, onClickPags);
			this.btnPags.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnPags.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnPags.buttonMode = true;
			this.btnCredtis.addEventListener(MouseEvent.CLICK, onClickCredits);
			this.btnCredtis.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnCredtis.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnCredtis.buttonMode = true;
			this.btnExit.addEventListener(MouseEvent.CLICK, onClickExit);
			this.btnExit.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnExit.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnExit.buttonMode = true;
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			event.currentTarget.gotoAndStop("out");
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			event.currentTarget.gotoAndStop("over");
		}
		
		protected function onClickExit(event:MouseEvent):void
		{
			this.closeFunction(true);
			ASharedObject.getInstance().getCitrusEngineRef().levelManager.gotoLevel(StateManager.STATE_MENU);
		}
		
		protected function onClickCredits(event:MouseEvent):void
		{
			this.closeFunction();
			ASharedObject.getInstance().getCitrusEngineRef().levelManager.gotoLevel(StateManager.STATE_CREDITS);
		}
		
		protected function onClickPags(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onClickOptionsButton(event:MouseEvent):void
		{
			optionScreen = new OptionsState();
			optionScreen.setCloseFunction(closeOptions);
			optionScreen.setKeyboard(ASharedObject.getInstance().getKeyboard());
			this.addChild(optionScreen);
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
		
		protected function onClickBack(event:MouseEvent):void
		{
			ASharedObject.getInstance().setIsPaused(false);
			this.closeFunction();
		}
		
		public function setCloseFunction(value:Function):void
		{
			closeFunction = value;
		}
		
		public function destroy():void
		{
			if(optionScreen){
				if(this.contains(optionScreen)){
					this.removeChild(optionScreen);
					optionScreen = null;
				}
			}
		}
	}
}