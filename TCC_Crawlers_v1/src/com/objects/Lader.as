package com.objects
{
	import com.ImageConstants;
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;
	
	public class Lader extends Sensor
	{
		public function Lader(name:String, params:Object=null)
		{
			super(name, params);
			this.view = ImageConstants.DOOR;
			this.onBeginContact.add(enterDoor);
		}
		
		private function enterDoor(contact:b2Contact):void
		{
			trace("Entrou na porta");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				contact.GetFixtureA().GetBody().GetUserData().setInLader(true);
			}
		}
	}
}