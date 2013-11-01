package com
{
	import com.data.ASharedObject;
	import com.states.NotebookState;
	import com.states.OptionsState;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	

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
		private var notebook:NotebookState;
		private var arm:MatheusArmAsset;
		private var holdingZiper:Boolean;
		private var opened:Boolean = false;
		
		public function Backpack()
		{
			this.btnOptions.addEventListener(MouseEvent.CLICK, onClickOptionsButton);
			this.btnOptions.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnOptions.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnOptions.buttonMode = true;
			this.btnOptions.visible = false;
			this.btnNotebook.addEventListener(MouseEvent.CLICK, onClickNotebook);
			this.btnNotebook.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnNotebook.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnNotebook.buttonMode = true;
			this.btnNotebook.visible = false;
			this.btnStack.addEventListener(MouseEvent.CLICK, onClickStack);
			this.btnStack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnStack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnStack.buttonMode = true;
			this.btnStack.visible = false;
			this.btnFlashlight.addEventListener(MouseEvent.CLICK, onClickFlashlight);
			this.btnFlashlight.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnFlashlight.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnFlashlight.buttonMode = true;
			this.btnFlashlight.visible = false;
			
			this.ziperTracker.addEventListener(MouseEvent.MOUSE_DOWN, onHoldZiperTracker);
			this.ziperTracker.addEventListener(MouseEvent.MOUSE_UP, onReleaseZiperTracker);
			this.addEventListener(MouseEvent.MOUSE_UP, onReleaseZiperTracker);
			
			arm = new MatheusArmAsset();
			this.addChild(arm);
			arm.mouseChildren = false;
			arm.mouseEnabled = false;
		}
		
		protected function onReleaseZiperTracker(event:MouseEvent):void
		{
			holdingZiper = false;
			this.ziperTracker.stopDrag();
		}
		
		protected function onHoldZiperTracker(event:MouseEvent):void
		{
			holdingZiper = true;
			this.ziperTracker.startDrag(false, new Rectangle(this.ziper.x, this.ziper.y, this.ziper.width, 0));
		}
		
		public function init():void
		{
			//fillContainerOfItens();
			//addScroll();
		}
		/*private function fillContainerOfItens():void
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
		}*/
		
		protected function onClickNotebook(event:MouseEvent):void
		{
			notebook = new NotebookState();
			notebook.setCloseFunction(closeNotebook);
			this.addChild(notebook);
		}
		
		private function closeNotebook():void
		{
			notebook.destroy();
			if(notebook){
				if(this.contains(notebook)){
					this.removeChild(notebook);
				}
			}
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
		
		protected function onClickFlashlight(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onClickStack(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		
		protected function onClickBack(event:MouseEvent):void
		{
			this.closeFunction();
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
		
		public function setArrayOfItens(value:Array):void
		{
			arrayOfItens = value;
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
			this.btnNotebook.removeEventListener(MouseEvent.CLICK, onClickNotebook);
			this.btnNotebook.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnNotebook.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnStack.removeEventListener(MouseEvent.CLICK, onClickStack);
			this.btnStack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnStack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnFlashlight.removeEventListener(MouseEvent.CLICK, onClickFlashlight);
			this.btnFlashlight.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnFlashlight.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			if(scroll){
				this.scroll.destroy();
				if(this.contains(scroll)){
					this.removeChild(scroll);
				}
			}
			if(optionScreen){
				if(this.contains(optionScreen)){
					this.removeChild(optionScreen);
					optionScreen = null;
				}
			}
			if(notebook){
				if(this.contains(notebook)){
					this.removeChild(notebook);
					notebook = null;
				}
			}
			
			arrayOfItens = null;
			scroll = null;
		}
		
		public function update():void
		{
			if(arm){
				if(mouseY >= this.ziper.y - 100){
					arm.y = mouseY;
				}
				arm.x = mouseX;
			}
			
			if(this.ziperTracker.x >= (this.ziper.x+this.ziper.width)-this.ziperTracker.width && !opened){
				opened = true;
				this.gotoAndStop(2);
				this.ziperTracker.visible = false;
				this.ziper.visible = false;
				this.ziperTracker.removeEventListener(MouseEvent.MOUSE_DOWN, onHoldZiperTracker);
				this.ziperTracker.removeEventListener(MouseEvent.MOUSE_UP, onReleaseZiperTracker);
				this.removeEventListener(MouseEvent.MOUSE_UP, onReleaseZiperTracker);
				showItens();
				if(arm){
					if(this.contains(arm)){
						this.removeChild(arm);
						arm = null;
					}
				}
			}
		}
		
		private function showItens():void
		{
			this.btnOptions.visible = true;
			this.btnNotebook.visible = true;
			this.btnStack.visible = true;
			this.btnFlashlight.visible = true;
		}
		
		private function hideItens():void
		{
			this.btnOptions.visible = false;
			this.btnNotebook.visible = false;
			this.btnStack.visible = false;
			this.btnFlashlight.visible = false;
		}
	}
}