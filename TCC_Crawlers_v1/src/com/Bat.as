package com
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.BezierPlugin;
	import com.greensock.plugins.BezierThroughPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.hero.MyHero;
	
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
		private var initPosX:int;
		private var initPosY:int;
		private var distanceToFly:int = 50;
		public function Bat(name:String, params:Object=null)
		{
			super(name, params);
			this.view = ImageConstants.BAT;
			minimumDistance = 200;
			this.onBeginContact.add(hit);
			this.initPosX = this.x;
			this.initPosY = this.y;
			this.updateCallEnabled = true;
			
			//this.x = 20;
			//this.y = 20;
		}
		
		private function hit(contact:b2Contact):void
		{
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				trace("hitado pelo morcego");
				contact.GetFixtureA().GetBody().GetUserData().addInsanity(15);
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			//if(target){
				calcDistance(_ce.state.getObjectsByType(MyHero)[0], this);
				if(distance <= minimumDistance && !tweening){
					tweening = true;
					doBatTween();
					//TweenLite.to(this, 3, {bezier:[{x:191, y:this.y}, {x:308, y:this.y}]});
					trace("VOU VOAAAAAAAAAAAAAAAAAAAAAAAAAAAAR!");
				}
			//}
		}
		
		private function doBatTween():void
		{
			var flyRange:int = initPosX + distanceToFly;
			trace("this.x: " + this.x, "this.y: " + this.y, "flyRange: " + flyRange);
			TweenMax.to(this, 3, {bezierThrough:[{x:flyRange/2, y:initPosY + 50}, {x:flyRange, y:initPosY}], onComplete:onCompleteTween});
			//TweenMax.to(this, 3, {bezierThrough:[{x:50, y:40}, {x:100, y:20}], onComplete:onCompleteTween});
		}
		
		private function onCompleteTween():void
		{
			trace("TERMINEI DE VOAR");
			distanceToFly *= -1;
			tweening = false;
		}
		
		private function calcDistance(obj1:Object, obj2:Object):Number
		{
			distance = Math.sqrt((obj1.x - obj2.x) * (obj1.x - obj2.x) + (obj1.y - obj2.y) * (obj1.y - obj2.y));
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