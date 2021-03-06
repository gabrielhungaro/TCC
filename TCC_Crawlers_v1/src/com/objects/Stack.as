package com.objects
{
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;

	public class Stack extends Sensor
	{
		public function Stack(name:String, params:Object=null)
		{
			super(name, params);
			this.view = "../lib/stack_resize.png";
			this.onBeginContact.add(cathTorch);
		}
		
		private function cathTorch(contact:b2Contact):void
		{
			trace("Pegou a pilha");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				//addTutorialScreen("Você pegou a tocha, com ela seu campo de visão aumenta, porém vai diminuindo com o tempo, para utilizá-la novamente precione a tecla 'C'!");
				contact.GetFixtureA().GetBody().GetUserData().addFlashlightEnergy(10);
				_ce.state.remove(this);
			}
		}
	}
}