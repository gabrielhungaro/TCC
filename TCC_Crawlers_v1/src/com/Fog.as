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
		private var _heroLight:HeroLightAsset;
		private var _target:Object;
		private var point:Point;
		private var targetPoint:Point;
		private var stageOriginal:MovieClip;
		private var _camPoint:Point;
		private var isInverted:Boolean;
		private var originalScale:Number = 1;
		private var risezedScale:Number = 2;
		private var radToDeg:Number = 180/Math.PI;
		private var isWithCamera:Boolean;
		private var isWithTorch:Boolean;
		private var isWithFlashlight:Boolean;
		private var ticks:int;
		private var FRAME_RATE:int;
		private var seconds:int;
		private var secondsWithTorch:int = 5;
		private var timerWithCamera:int = 1;
		private var ALPHA:Number = .8;
		private var lightType:String;
		private var NORMAL_LIGHT:String = "normal";
		private var CAMERA_LIGHT:String = "camera";
		private var FLASHLIGHT_LIGHT:String = "flashlight";
		
		public function Fog(target:Object, camPoint:Point, _x:int, _y:int, _width:int, _height:int)
		{
			_target = target;
			_camPoint = camPoint;
			
			targetPoint = new Point(target.x, target.y);
			fog = new Sprite();
			fog.alpha = ALPHA;
			fog.graphics.beginFill(0x000000, 1);
			fog.graphics.drawRect(_x, _y, _width, _height);
			fog.blendMode = BlendMode.LAYER;
			
			_heroLight = new HeroLightAsset();
			_heroLight.x = _target.x;
			_heroLight.y = _target.y;
			_heroLight.scaleX = _heroLight.scaleY = originalScale;
			_heroLight.blendMode = BlendMode.ERASE;
		}
		
		public function init():void
		{
			this.addChild(fog);
			
			fog.addChild(_heroLight);
			
			timerWithCamera = timerWithCamera * FRAME_RATE;
			
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
			//updateLightType();
			updateLightSize();
			
			if(isInverted){
				_heroLight.x = _camPoint.x - _target.x;
				_heroLight.y = _camPoint.y - _target.y;
			}else{
				_heroLight.x = _target.x - _camPoint.x;
				_heroLight.y = _target.y - _camPoint.y;		
			}
			
			if(isWithCamera){
				_heroLight.rotation = Math.atan2(mouseY - _heroLight.y, mouseX - _heroLight.x)*radToDeg;
				if((ticks % timerWithCamera * FRAME_RATE) == 0){
					this.releaseCamera();
				}
			}
		}
		
		private function updateLightType():void
		{
			if(isWithFlashlight){
				lightType = FLASHLIGHT_LIGHT;
			}else if(isWithTorch){
				lightType = NORMAL_LIGHT;
			}else if(isWithCamera){
				lightType = CAMERA_LIGHT;
			}else{
				lightType = NORMAL_LIGHT;
				_heroLight.scaleX = _heroLight.scaleY = originalScale;
			}
			_heroLight.gotoAndStop(lightType);
		}
		
		private function updateLightSize():void
		{
			if(isWithTorch){
				if((seconds % secondsWithTorch * FRAME_RATE) == 0){
					if(_heroLight.scaleX > originalScale){
						_heroLight.scaleX = _heroLight.scaleY -= .01;
					}else{
						isWithTorch = false;
					}
				}
			}else if(isWithFlashlight){
				//_heroLight.rotation = Math.atan2(mouseY - _heroLight.y, mouseX - _heroLight.x)*radToDeg;
				if((seconds % secondsWithTorch * FRAME_RATE) == 0){
					if(_target.getFlashlightEnergy() > _target.getMinFlashlightEnergy()){
						_heroLight.scaleX = _target.getFlashlightEnergy()/100;
						_target.setFlashlightEnergy(_target.getFlashlightEnergy()-1);
					}else{
						isWithFlashlight = false;
					}
				}
			}
		}
		
		public function useCamera():void
		{
			//_heroLight.scaleX = 2;
			lightType = CAMERA_LIGHT;
			isWithCamera = true;
			_heroLight.gotoAndStop(lightType);
		}
		
		public function useFlashlight():void
		{
			//_heroLight.scaleX = 2;
			lightType = FLASHLIGHT_LIGHT;
			_heroLight.scaleX = _heroLight.scaleY = originalScale;
			isWithFlashlight = true;
			_heroLight.gotoAndStop(lightType);
		}
		
		public function releaseCamera():void
		{
			lightType = NORMAL_LIGHT;
			_target.setCameraUsed(false);
			_heroLight.gotoAndStop(lightType);
			//_heroLight.scaleX = _heroLight.scaleY = originalScale;
			isWithCamera = false;
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
			lightType = NORMAL_LIGHT;
			_heroLight.scaleX = _heroLight.scaleY = risezedScale;
			_heroLight.gotoAndStop(lightType);
		}
		
		public function setFrameRate(value:int):void
		{
			FRAME_RATE = value;
		}
	}
}