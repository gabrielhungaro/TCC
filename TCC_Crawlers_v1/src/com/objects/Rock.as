package com.objects
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	
	import citrus.objects.platformer.box2d.Crate;
	import citrus.physics.box2d.Box2DShapeMaker;
	
	public class Rock extends Crate
	{
		private var _world:b2World;
		private var rockBody:b2Body; 
		private var _worldScale:Number;
		private var _heroX:int;
		private var _heroY:int;
		private var _angleOfShoot:Number;
		private var rockAsset:RockAsset;
		public var dirX:Number;
		public var dirY:Number;
		public function Rock(name:String, world:b2World, worldScale:Number, heroX:int, heroY:int, angleOfShoot:Number, params:Object=null)
		{
			super(name, params);
			_world = world;
			_worldScale = worldScale
			_heroX = heroX;
			_heroY = heroY;
			_angleOfShoot = angleOfShoot;
			//init();
		}
		
		public function calcPosition():void
		{
			/*var distanceX:Number=this.assetSprite.x-this.initialPosition.x;
			var distanceY:Number=this.assetSprite.y-this.initialPosition.y;*/
			var distanceX:Number=_heroX;
			var distanceY:Number=_heroY;
			var distance:Number=Math.sqrt(distanceX*distanceX+distanceY*distanceY);
			var characterAngle:Number=Math.atan2(distanceY,distanceX);
			var initX:Number = _heroX + 40 * Math.cos(_angleOfShoot);
			var initY:Number = _heroY + 40 * Math.sin(_angleOfShoot);
			this.x = initX;
			this.y = initY;
			//this.getBody().SetLinearVelocity(new b2Vec2(-distance*Math.cos(characterAngle)/4,-distance*Math.sin(characterAngle)/4));
			//this.getBody().SetLinearVelocity(new b2Vec2(Math.cos(_angleOfShoot)/4,Math.sin(_angleOfShoot)/4));
			trace(initX, initY);
			this.body.ApplyImpulse(new b2Vec2(Math.cos(_angleOfShoot)/4,Math.sin(_angleOfShoot)/4), new b2Vec2(Math.cos(_angleOfShoot)/4,Math.sin(_angleOfShoot)/4));
			
			/*var desiredAngle:Number = Math.atan2(_ce.stage.mouseX, _ce.stage.mouseY);
			var nextAngle:Number = this.body.GetAngle() + this.body.GetAngularVelocity() / 60.0;
			var totalRotation:Number = desiredAngle - nextAngle;
			while ( totalRotation < -180 * Math.PI/180 ) totalRotation += 360 * Math.PI/180;
			while ( totalRotation >  180 * Math.PI/180 ) totalRotation -= 360 * Math.PI/180;
			var desiredAngularVelocity:Number = totalRotation * 60;
			var impulse:Number = this.body.GetInertia() * desiredAngularVelocity;// disregard time factor
			this.body.SetAngularVelocity(impulse);*/
			//this.body.SetLinearVelocity(new b2Vec2(initX,initY));
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
		override protected function createShape():void {
			_shape = Box2DShapeMaker.Circle(_width, _height);
		}
		
		override protected function defineBody():void
		{
			super.defineBody();
			_bodyDef.type = b2Body.b2_dynamicBody;
		}
		
		override protected function defineFixture():void
		{
			super.defineFixture();
			//_fixtureDef.isSensor = true;
		}
		
		override public function destroy():void
		{
			//onBeginContact.removeAll();
			//onEndContact.removeAll();
			
			super.destroy();
		}
	}
}