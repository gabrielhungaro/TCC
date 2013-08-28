package com{	import flash.utils.setTimeout;		import Box2D.Dynamics.Contacts.b2Contact;		import citrus.objects.platformer.box2d.Sensor;
		public class Spike2 extends Sensor	{		private var hero:MyHero;		public function Spike2(name:String, params:Object=null)		{			super(name, params);						this.onBeginContact.add(applyDamage);		}				private function applyDamage():void
		{			setTimeout(movePlayer, 0);
			
		}		
		private function movePlayer():void
		{
			hero.x = 10;			hero.y = 10;		}
				/*override protected function _teleport():void		{					}*/				public function setHero(value:MyHero):void		{			hero = value;		}	}}