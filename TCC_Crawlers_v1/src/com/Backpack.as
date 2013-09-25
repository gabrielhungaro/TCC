package com
{
	import com.greensock.TweenMax;
	import com.states.OptionsState;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import citrus.input.controllers.Keyboard;
	

	public class Backpack extends MenuInGameAsset
	{
		private var arrayOfItens:Array;
		private var numberOfCols:int = 4;
		private var numberOfLines:int = 3;
		private var offsetX:int = 13;
		private var offsetY:int = 13;
		private var scroll:Scroll;
		private var closeFunction:Function;
		private var optionScreen:OptionsState;
		private var keyboard:Keyboard;
		
		public function Backpack()
		{
			this.btnOptions.addEventListener(MouseEvent.CLICK, onClickOptionsButton);
			this.btnOptions.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnOptions.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnOptions.buttonMode = true;
			this.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnBack.buttonMode = true;
		}
		
		public function init():void
		{
			fillContainerOfItens();
			addScroll();
		}
		private function fillContainerOfItens():void
		{
			var cols:int = 0;
			var lines:int = 0;
			var backgroundFill:Sprite = new Sprite();
			this.itensContainer.container.addChild(backgroundFill);
			for (var i:int = 0; i < arrayOfItens.length; i++) 
			{
				var item:ItemAsset = new ItemAsset();
				this.itensContainer.container.addChild(item);
				item.buttonMode = true;
				if(cols == numberOfCols){
					item.x = offsetX*(cols+1) + cols * item.width;
					item.y = offsetY*(lines+1) + lines * item.height;
					cols = 0;
					lines++;
				}else{
					item.x = offsetX*(cols+1) + cols * item.width;
					item.y = offsetY*(lines+1) + lines * item.height;
					cols++;
				}
			}
			
			backgroundFill.graphics.beginFill(0x101010, 1);
			backgroundFill.graphics.drawRect(0, 0, item.width*(numberOfCols+1) + offsetX*(numberOfCols+2), item.height*(lines+1) + offsetY*(lines+2));
			backgroundFill.graphics.endFill();
		}
		
		private function addScroll():void
		{
			scroll = new Scroll(this.itensContainer.container);
			this.addChild(scroll);
			scroll.x = this.itensContainer.x + this.itensContainer.width + offsetX;
		}
		
		protected function onClickOptionsButton(event:MouseEvent):void
		{
			optionScreen = new OptionsState();
			optionScreen.setCloseFunction(closeOptions);
			optionScreen.setKeyboard(keyboard);
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
			this.closeFunction();
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1.3 }} );
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1 }} );
		}
		
		public function setArrayOfItens(value:Array):void
		{
			arrayOfItens = value;
		}
		
		public function setKeyboard(value:Keyboard):void
		{
			keyboard = value;
		}
		
		public function setCloseFunction(value:Function):void
		{
			closeFunction = value;
		}
		
		public function destroy():void
		{
			this.btnOptions.removeEventListener(MouseEvent.CLICK, onClickOptionsButton);
			this.btnOptions.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnOptions.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
			this.btnBack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnBack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.scroll.destroy();
			if(scroll){
				if(this.contains(scroll)){
					this.removeChild(scroll);
				}
			}
			
			arrayOfItens = null;
			scroll = null;
		}
	}
}