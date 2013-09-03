package com.objects
{
	import com.hero.MyHero;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;
	
	public class Torch extends Sensor
	{
		public function Torch(name:String, params:Object=null)
		{
			super(name, params);
			this.view = "../lib/Torch.swf";
			this.onBeginContact.add(cathTorch);
		}
		
		private function cathTorch(contact:b2Contact):void
		{
			trace("Pegou a tocha");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				//addTutorialScreen("Você pegou a tocha, com ela seu campo de visão aumenta, porém vai diminuindo com o tempo, para utilizá-la novamente precione a tecla 'C'!");
				contact.GetFixtureA().GetBody().GetUserData().setWithTorch(true);
			}
		}
	}
}

