package com
{
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class Fog extends Sprite
	{
		private var fog:Sprite;
		private var _mask:EcolocalizadorAsset;
		private var _target:Object;
		private var point:Point;
		private var targetPoint:Point;
		private var stageOriginal:MovieClip;
		private var _camPoint:Point;
		private var isInverted:Boolean;
		private var originalScale:Number = 1;
		private var risezedScale:Number = 2;
		private var withEcolocalizador:Boolean;
		private var radToDeg:Number = 180/Math.PI;
		private var isWithTorch:Boolean;
		private var ticks:int;
		private var FRAME_RATE:int;
		private var seconds:int;
		private var secondsWithTorch:int = 5;
		private var timerWithEcolocalizador:int = 1;
		
		public function Fog(target:Object, camPoint:Point, _x:int, _y:int, _width:int, _height:int)
		{
			_target = target;
			_camPoint = camPoint;
			
			targetPoint = new Point(target.x, target.y);
			fog = new Sprite();
			fog.alpha = .8;
			fog.graphics.beginFill(0x000000, 1);
			fog.graphics.drawRect(_x, _y, _width, _height);
			fog.blendMode = BlendMode.LAYER;
			
			_mask = new EcolocalizadorAsset();
			_mask.x = _target.x;
			_mask.y = _target.y;
			_mask.scaleX = _mask.scaleY = originalScale;
			_mask.blendMode = BlendMode.ERASE;
		}
		
		public function init():void
		{
			this.addChild(fog);
			
			fog.addChild(_mask);
			
			timerWithEcolocalizador = timerWithEcolocalizador * FRAME_RATE;
			
			this.addEventListener(Event.ENTER_FRAME, update);
		}
		
		protected function update(event:Event):void
		{
			//trace("camera:", _camPoint, "hero", new Point(_target.x, _target.y), "mask", new Point(mask.x, mask.y));
			ticks++;
			if(ticks >= FRAME_RATE){
				ticks = 0;
				seconds++;
			}
			if(isWithTorch){
				updateLightSize();
			}
			
			if(isInverted){
				_mask.x = _camPoint.x - _target.x;
				_mask.y = _camPoint.y - _target.y;
			}else{
				_mask.x = _target.x - _camPoint.x;
				_mask.y = _target.y - _camPoint.y;		}
			
			if(withEcolocalizador){
				_mask.rotation = Math.atan2(mouseY - _mask.y, mouseX - _mask.x)*radToDeg;
				if((ticks % timerWithEcolocalizador * FRAME_RATE) == 0){
					this.releaseEcolocalizador();
				}
			}
		}
		
		private function updateLightSize():void
		{
			if((seconds % secondsWithTorch * FRAME_RATE) == 0){
				if(_mask.scaleX > originalScale){
					_mask.scaleX = _mask.scaleY -= .01;
				}else{
					isWithTorch = false;
				}
			}
		}
		
		public function useEcolocalizador():void
		{
			//_mask.scaleX = 2;
			withEcolocalizador = true;
			_mask.gotoAndStop(2);
		}
		
		public function releaseEcolocalizador():void
		{
			_target.setEcolocalizadorUsed(false);
			_mask.gotoAndStop(1);
			//_mask.scaleX = _mask.scaleY = originalScale;
			withEcolocalizador = false;
		}
		
		public function setInverted(value:Boolean):void
		{
			isInverted = value;
			//if(isInverted){
				//_camPoint.x *= -1;
				//_camPoint.y *= -1;
			//}
		}
		
		public function setWithTorch(value:Boolean):void
		{
			isWithTorch = value;
			_mask.scaleX = _mask.scaleY = risezedScale;
		}
		
		public function setFrameRate(value:int):void
		{
			FRAME_RATE = value;
		}
	}
}