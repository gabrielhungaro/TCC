package com.objects
{
	import com.ImageConstants;
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;
	
	public class PrevLevel extends Sensor
	{
		public function PrevLevel(name:String, params:Object=null)
		{
			super(name, params);
			this.view = ImageConstants.DOOR;
			this.onBeginContact.add(enterDoor);
		}
		
		private function enterDoor(contact:b2Contact):void
		{
			trace("Entrou na porta");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				_ce.levelManager.prevLevel();
			}
		}
	}
}