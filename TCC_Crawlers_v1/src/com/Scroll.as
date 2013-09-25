package com
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Scroll extends ScrollAsset
	{
		private var _mcToScroll:MovieClip;
		private var holdingScroller:Boolean;
		
		public function Scroll(mcToScroll:MovieClip)
		{
			_mcToScroll = mcToScroll;
			this.scroller.addEventListener(MouseEvent.MOUSE_DOWN, onHoldScroller);
			this.scroller.addEventListener(MouseEvent.MOUSE_UP, onReleaseScroller);
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function onReleaseScroller(event:MouseEvent):void
		{
			holdingScroller = false;
			this.scroller.stopDrag();
		}
		
		protected function onHoldScroller(event:MouseEvent):void
		{
			holdingScroller = true;
			this.scroller.startDrag(false, new Rectangle(this.width/4, 0, 0, this.height - this.scroller.height/2));
		}
		
		protected function update(event:Event):void
		{
			if(holdingScroller){
				//_mcToScroll.y = ((this.scroller.y * _mcToScroll.height)/this.height - this.scroller.height/2)*-1;
				_mcToScroll.y = ((100 * this.scroller.y) / this.scrollBar.height) * -1;
			}
		}
		
		public function destroy():void
		{
			holdingScroller = false;
			this.scroller.removeEventListener(MouseEvent.MOUSE_DOWN, onHoldScroller);
			this.scroller.removeEventListener(MouseEvent.MOUSE_UP, onReleaseScroller);
			this.removeEventListener(Event.ENTER_FRAME, update);
			_mcToScroll = null;
		}
	}
}