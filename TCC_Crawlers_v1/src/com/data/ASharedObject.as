package com.data
{
	public class ASharedObject
	{
		
		private var _heroInsanity:int;
		private var _isWithFlashlight:Boolean;
		
		public static var okToCreate:Boolean;
		public static var instance:ASharedObject;
		
		public function ASharedObject()
		{
			if(okToCreate == false){
				trace("ASharedObject não pode ter mais de duas instancias");
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


	}
}