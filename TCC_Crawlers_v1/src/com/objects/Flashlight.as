package com.objects
{
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;

	public class Flashlight extends Sensor
	{
		private var isActive:Boolean;
		public function Flashlight(name:String, params:Object=null)
		{
			super(name, params);
			this.view = "../lib/flashlight_resize.png";
			this.onBeginContact.add(cathTorch);
		}
		
		private function cathTorch(contact:b2Contact):void
		{
			trace("Pegou a tocha");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				//addTutorialScreen("Você pegou a tocha, com ela seu campo de visão aumenta, porém vai diminuindo com o tempo, para utilizá-la novamente precione a tecla 'C'!");
				contact.GetFixtureA().GetBody().GetUserData().setWithFlashlight(true);
			}
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