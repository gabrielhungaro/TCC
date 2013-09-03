package com
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.hero.MyHero;
	
	import flash.display.Bitmap;
	
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.objects.platformer.box2d.Sensor;
	
	TweenPlugin.activate([BezierPlugin, BezierThroughPlugin]);

	
	public class Bat extends Sensor
	{
		//[EMBED(src="../lib/bat_resize.png")];
		//private var view:Bitmap;
		
		private var minimumDistance:int;
		private var distance:Number;
		private var target:Object;
		private var tweening:Boolean;
		public function Bat(name:String, params:Object=null)
		{
			super(name, params);
			this.view = "../lib/bat_resize.png";
			minimumDistance = 100;
			this.onBeginContact.add(hit);
		}
		
		private function hit(contact:b2Contact):void
		{
			trace("hitado pelo morcego");
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				//addTutorialScreen("Você pegou a tocha, com ela seu campo de visão aumenta, porém vai diminuindo com o tempo, para utilizá-la novamente precione a tecla 'C'!");
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			trace("bulbi");
			calcDistance(target, this);
			if(distance <= minimumDistance && !tweening){
				TweenMax.to(this, 3, {bezier:[{x:191, y:this.y + 20}, {x:308, y:this.y}]});
				//TweenLite.to(this, 3, {bezier:[{x:191, y:this.y}, {x:308, y:this.y}]});
				trace("VOU VOAAAAAAAAAAAAAAAAAAAAAAAAAAAAR!");
			}
		}
		
		private function calcDistance(obj1:Object, obj2:Object):Number
		{
			distance = Math.SQRT2((obj1.x - obj2.x) * (obj1.x - obj2.x) + (obj1.y - obj2.y) * (obj1.y - obj2.y));
			trace(distance);
			
			
			return distance;
		}
		
		public function setMinimumDistance(value:int):void
		{
			minimumDistance = value;
		}
		
		public function setTarget(value:Object):void
		{
			target = value;
		}
	}
}