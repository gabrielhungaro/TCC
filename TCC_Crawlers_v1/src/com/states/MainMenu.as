package com.states
{
	import flash.events.MouseEvent;
	
	import citrus.core.State;
	
	public class MainMenu extends State
	{
		private var backgrodround:MainMenuBackgroundAsset;
		private var btnStart:BtnStartAsset;
		private var btnOptions:BtnOptionsAsset;
		private var btnCredits:BtnCreditsAsset;
		
		public function MainMenu()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			backgrodround = new MainMenuBackgroundAsset();
			this.addChild(backgrodround);
			btnStart = new BtnStartAsset();
			btnStart.x = 150;
			btnStart.y = 150;
			btnStart.addEventListener(MouseEvent.CLICK, onClickStart);
			btnStart.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			btnStart.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			btnStart.buttonMode = true;
			this.addChild(btnStart)
			btnOptions = new BtnOptionsAsset();
			btnOptions.x = 150;
			btnOptions.y = 300;
			btnOptions.addEventListener(MouseEvent.CLICK, onClickOptions);
			btnOptions.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			btnOptions.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			btnOptions.buttonMode = true;
			this.addChild(btnOptions)
			btnCredits = new BtnCreditsAsset();
			btnCredits.x = 150;
			btnCredits.y = 450;
			btnCredits.addEventListener(MouseEvent.CLICK, onClickCredits);
			btnCredits.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			btnCredits.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			btnCredits.buttonMode = true;
			this.addChild(btnCredits)
		}
		
		protected function onClickStart(event:MouseEvent):void
		{
			_ce.levelManager.gotoLevel()
		}
		
		protected function onClickCredits(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onClickOptions(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
	}
}