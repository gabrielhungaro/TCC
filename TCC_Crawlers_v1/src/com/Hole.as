package com
{
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Teleporter;
	
	public class Hole extends Teleporter
	{
		private var hero:MyHero;
		public function Hole(name:String, params:Object=null)
		{
			super(name, params);
			this.endX = 70;
			this.endY = 100;
			this.onBeginContact.add(activeTeleport);
		}
		
		private function activeTeleport(cEvt:b2Contact):void {
			if (cEvt.GetFixtureA().GetBody().GetUserData() is MyHero) {
				this.object = cEvt.GetFixtureA().GetBody().GetUserData();
				cEvt.GetFixtureA().GetBody().GetUserData().reset();
				this.teleport = true;
			}
		}
		
		public function setHero(value:MyHero):void
		{
			hero = value;
		}
	}
}