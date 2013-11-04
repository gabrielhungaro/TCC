package com.data
{
	import com.hero.HeroActions;
	
	import flash.utils.Dictionary;
	
	import citrus.core.CitrusEngine;
	import citrus.input.controllers.Keyboard;

	public class ASharedObject
	{
		
		private var _heroInsanity:int;
		private var _isWithFlashlight:Boolean;
		private var _sound:Boolean = true;
		private var _sfx:Boolean = true;
		private var _fullScreen:Boolean = true;
		private var _actionsDic:Dictionary = new Dictionary();
		private var _keyboard:Keyboard;
		private var _ce:CitrusEngine;
		private var _isPaused:Boolean = true;
		
		public static var okToCreate:Boolean;
		public static var instance:ASharedObject;
		
		public function ASharedObject()
		{
			if(okToCreate == false){
				trace("ASharedObject não pode ter mais de duas instancias");
			}else{
				init();
			}
		}
		
		public static function getInstance():ASharedObject
		{
			if(instance == null){
				okToCreate = true;
				instance = new ASharedObject();
				okToCreate = false;
			}
			return instance;
		}
		
		private function init():void
		{
			_actionsDic[HeroActions.LEFT] = HeroActions.LEFT_KEY;
			_actionsDic[HeroActions.RIGHT] = HeroActions.RIGHT_KEY;
			_actionsDic[HeroActions.JUMP] = HeroActions.JUMP_KEY;
			_actionsDic[HeroActions.INVERT] = HeroActions.INVERT_KEY;
			_actionsDic[HeroActions.ACTION] = HeroActions.ACTION_KEY;
			_actionsDic[HeroActions.HIGH_FLASHLIGHT] = HeroActions.HIGH_FLASHLIGHT_KEY;
			_actionsDic[HeroActions.FLASHLIGHT] = HeroActions.FLASHLIGHT_KEY;
			_actionsDic[HeroActions.BACKPACK] = HeroActions.BACKPACK_KEY;
		}
		
		public function getSound():Boolean
		{
			return _sound;
		}
		
		public function setSound(value:Boolean):void
		{
			_sound = value;
		}
		
		public function getSfx():Boolean
		{
			return _sfx;
		}
		
		public function setSfx(value:Boolean):void
		{
			_sfx = value;
		}

		public function getHeroInsanity():int
		{
			return _heroInsanity;
		}

		public function setHeroInsanity(value:int):void
		{
			_heroInsanity = value;
		}

		public function getIsWithFlashlight():Boolean
		{
			return _isWithFlashlight;
		}

		public function setIsWithFlashlight(value:Boolean):void
		{
			_isWithFlashlight = value;
		}

		public function getFullScreen():Boolean
		{
			return _fullScreen;
		}

		public function setFullScreen(value:Boolean):void
		{
			_fullScreen = value;
		}

		public function getActionsDic():Dictionary
		{
			return _actionsDic;
		}

		public function setActionsDic(value:Dictionary):void
		{
			_actionsDic = value;
		}

		public function getKeyboard():Keyboard
		{
			return _keyboard;
		}

		public function setKeyboard(value:Keyboard):void
		{
			_keyboard = value;
		}

		public function getCitrusEngineRef():CitrusEngine
		{
			return _ce;
		}

		public function setCitrusEngineRef(value:CitrusEngine):void
		{
			_ce = value;
		}

		public function getIsPaused():Boolean
		{
			return _isPaused;
		}

		public function setIsPaused(value:Boolean):void
		{
			_isPaused = value;
		}

	}
}