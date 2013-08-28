package com.objects
{
	public class Flashlight
	{
		private var isActive:Boolean;
		public function Flashlight()
		{
		}
		
		public function setIsActive(value:Boolean):void
		{
			isActive = value;
		}
		
		public function getIsActive():Boolean
		{
			return isActive;
		}
	}
}