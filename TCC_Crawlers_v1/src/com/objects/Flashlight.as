package com.objects
{
	import com.ImageConstants;
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;

	public class Flashlight extends Sensor
	{
		public function Flashlight(name:String, params:Object=null)
		{
			super(name, params);
			this.view = ImageConstants.FLASHLIGHT;
			this.onBeginContact.add(cathTorch);
		}
		
		private function cathTorch(contact:b2Contact):void
		{
			trace("Pegou a lanterna");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				contact.GetFixtureA().GetBody().GetUserData().setWithFlashlight(true);
				_ce.state.remove(this);
			}
		}
	}
}