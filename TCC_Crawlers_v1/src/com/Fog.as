package com
{
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import citrus.view.ACitrusCamera;

	public class Fog extends Sprite
	{
		private var fog:Sprite;
		private var _heroLight:HeroLightAsset;
		private var _target:Object;
		private var point:Point;
		private var targetPoint:Point;
		private var stageOriginal:MovieClip;
		private var _cam:ACitrusCamera;
		private var isInverted:Boolean;
		private var originalScale:Number = 1;
		private var risezedScale:Number = 2;
		private var radToDeg:Number = 180/Math.PI;
		private var isWithCamera:Boolean;
		private var isWithTorch:Boolean;
		private var ticks:int;
		private var FRAME_RATE:int;
		private var seconds:int;
		private var secondsWithTorch:int = 5;
		private var timerWithCamera:int = 1;
		private var ALPHA:Number = .98;
		private var lightType:String = NORMAL_LIGHT;
		private var NORMAL_LIGHT:String = "normal";
		private var CAMERA_LIGHT:String = "camera";
		private var FLASHLIGHT_LIGHT:String = "flashlight";
		private var usingFlashlight:Boolean;
		
		public function Fog(target:Object, cam:ACitrusCamera, _x:int, _y:int, _width:Number, _height:Number)
		{
			_target = target;
			_cam = cam;
			
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
			//trace(_cam.transformMatrix.transformPoint(new Point(0,0)));
			_heroLight.x = _target.x;
			_heroLight.y = _target.y;
			/*if(isInverted){
				_heroLight.x = _cam.transformMatrix.transformPoint(new Point(0,0)).x/2 - _target.x;
				_heroLight.y = _cam.transformMatrix.transformPoint(new Point(0,0)).y/2 - _target.y;
			}else{
				_heroLight.x = _target.x + _cam.transformMatrix.transformPoint(new Point(0,0)).x;
				_heroLight.y = _target.y + _cam.transformMatrix.transformPoint(new Point(0,0)).y;		
			}*/
			
			//trace(_heroLight.x, _heroLight.y);
			if(isWithCamera){
				_heroLight.rotation = Math.atan2(mouseY - _heroLight.y, mouseX - _heroLight.x)*radToDeg;
				if((ticks % timerWithCamera * FRAME_RATE) == 0){
					this.releaseCamera();
				}
			}
			if(usingFlashlight){
				_heroLight.rotation = Math.atan2(mouseY - _heroLight.y, mouseX - _heroLight.x)*radToDeg;
			}
		}
		
		private function updateLightType():void
		{
			if(isWithTorch){
				lightType = NORMAL_LIGHT;
				_heroLight.scaleX = _heroLight.scaleY = risezedScale;
			}
			if(usingFlashlight){
				_heroLight.scaleX = _heroLight.scaleY = originalScale;
				_heroLight.scaleX = _target.getFlashlightEnergy()/100;
				lightType = FLASHLIGHT_LIGHT;
			}
			if(isWithCamera){
				lightType = CAMERA_LIGHT;
			}
			if(!isWithCamera && !usingFlashlight && !isWithTorch){
				lightType = NORMAL_LIGHT;
				_heroLight.scaleX = _heroLight.scaleY = originalScale;
			}
			_heroLight.gotoAndStop(lightType);
		}
		
		private function updateLightSize():void
		{
			if(isWithTorch && !usingFlashlight){
				if((seconds % secondsWithTorch * FRAME_RATE) == 0){
					if(_heroLight.scaleX > originalScale){
						_heroLight.scaleX = _heroLight.scaleY -= .01;
					}else{
						isWithTorch = false;
					}
				}
			}
			if(usingFlashlight){
				//_heroLight.rotation = Math.atan2(mouseY - _heroLight.y, mouseX - _heroLight.x)*radToDeg;
				if((seconds % secondsWithTorch * FRAME_RATE) == 0){
					if(_target.getFlashlightEnergy() > _target.getMinFlashlightEnergy()){
						trace(_target.getFlashlightEnergy());
						_target.setFlashlightEnergy(_target.getFlashlightEnergy()-1);
						_heroLight.scaleX = _target.getFlashlightEnergy()/100;
					}else{
						_heroLight.scaleX = _heroLight.scaleY = originalScale;
						usingFlashlight = false;
						updateLightType();
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
			if(!usingFlashlight){
				usingFlashlight = true;
				_heroLight.scaleX = _target.getFlashlightEnergy()/100;
			}else{
				_heroLight.scaleX = _heroLight.scaleY = originalScale;
				usingFlashlight = false;
			}
			updateLightType();
			//_heroLight.gotoAndStop(lightType);
		}
		
		public function releaseCamera():void
		{
			lightType = NORMAL_LIGHT;
			_target.setCameraUsed(false);
			_heroLight.gotoAndStop(lightType);
			//_heroLight.scaleX = _heroLight.scaleY = originalScale;
			isWithCamera = false;
		}
		
		public function reset():void
		{
			isWithCamera = false;
			isWithTorch = false;
			usingFlashlight = false;
			updateLightType();
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
			updateLightType();
		}
		
		public function setFrameRate(value:int):void
		{
			FRAME_RATE = value;
		}
		
		public function destroy():void
		{
			this.removeEventListener(Event.ENTER_FRAME, update);
			fog = null;
			_heroLight = null;
			_target = null;
			point = null;
			targetPoint = null;
			stageOriginal = null;
			_cam = null;
		}
	}
}