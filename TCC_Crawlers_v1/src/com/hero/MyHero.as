package com.hero
{
	import com.Backpack;
	import com.Fog;
	import com.data.ASharedObject;
	import com.data.SoundList;
	import com.levels.ILevel;
	import com.objects.Rock;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.physics.box2d.Box2DUtils;
	import citrus.physics.box2d.IBox2DPhysicsObject;
	import citrus.sounds.SoundManager;
	import citrus.view.ACitrusCamera;
	import citrus.view.spriteview.SpriteArt;
	
	public class MyHero extends Hero
	{
		private var initialPos:Point;
		private var isInverted:Boolean;
		private var radToDeg:Number = 180/Math.PI;
		private var angleOfShoot:Number;
		private var _sprite:Sprite = new Sprite();
		public var rock:Rock;
		public var rock1:RockAsset;
		private var _worldScale:Number;
		private var _world:b2World;
		private var withRock:Boolean = false;
		private var iLevel:ILevel;
		private var fog:Fog;
		private var isWithTorch:Boolean = false;
		private var _camPos:Point;
		private var insanity:int = 0;
		private var insanityDangerous:int = 50;
		private var insanityLimit:int = 100;
		private var insanityDebug:Boolean;
		private var insanityTime:int = 5;
		private var FRAME_RATE:int;
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var isInsane:Boolean = false;
		private var cameraUsed:Boolean = false;
		private var usingFlashlight:Boolean = false;
		
		private var insanityBarBackgorund:Sprite;
		private var insanityBar:Sprite;
		private var dirX:Number;
		private var dirY:Number;
		private var arrayOfRocks:Vector.<Rock>;
		private var shadow:Shadow;
		private var isWithFlashlight:Boolean;
		private var flashlightEnergy:int;
		private var maxFlashlightEnergy:int = 100;
		private var minFlashlightEnergy:int = 10;
		private var _cam:ACitrusCamera;
		private var _viewRoot:Sprite;
		private var shadowPos:Point;
		
		private var backpack:Backpack;
		
		//Attributes
		private var _jumpHeight:Number = 20;
		private var _maxVelocity:Number = 8;
		private var _acceleration:Number = 1;
		private var widthBound:Number;
		private var heightBound:Number;
		private var inLader:Boolean;
		
		public function MyHero(name:String, params:Object=null)
		{
			var heroAsset:HeroAsset = new HeroAsset();
			super(name, params);
			this.view = heroAsset;
			this.width = heroAsset.width;
		}
		
		public function init():void
		{
			FRAME_RATE = _ce.stage.frameRate;
			insanityTime = insanityTime*FRAME_RATE;
			setDebugInsanity(false);
			insanity = ASharedObject.getInstance().getHeroInsanity();
			//_camPos = iLevel.getCamPos();
			createFog();
			
			drawInsanityBar();
			arrayOfRocks = new Vector.<Rock>;
			
			shadowPos = new Point(this.x, this.y + this.height);
			
			setupHeroAttributes();
			setupHeroAction();
			createShadow();
		}
		
		private function setupHeroAttributes():void
		{
			this.jumpHeight = _jumpHeight;
			this.maxVelocity = _maxVelocity;
			this.acceleration = _acceleration;
		}
		
		private function createFog():void
		{
			if(!fog){
				fog = new Fog(this, _cam, 0, 0, widthBound, heightBound);
				fog.setFrameRate(FRAME_RATE);
				fog.init();
				_viewRoot.addChild(fog);
			}
		}
		
		private function removeFog():void
		{
			if(fog){
				if(_viewRoot.contains(fog)){
					_viewRoot.removeChild(fog);
					fog.destroy();
					fog = null;
				}
			}
		}
		
		private function createShadow():void
		{
			shadow = new Shadow();
			//shadow.setAsset(hero.getViewAsMovieClip());
			shadow.setHero(this);
			shadow.x = shadowPos.x;
			shadow.y = shadowPos.y;
			_viewRoot.addChild(shadow);
			shadow.addEventListener(MouseEvent.CLICK, onClickShadow);
		}
		
		private function removeShadow():void
		{
			if(shadow){
				if(_viewRoot.contains(shadow)){
					_viewRoot.removeChild(shadow);
					shadow = null;
				}
			}
		}
		
		protected function onClickShadow(event:MouseEvent):void
		{
			invertWorld();
		}
		
		private function setupHeroAction():void
		{
			ASharedObject.getInstance().setKeyboard(_ce.input.keyboard as Keyboard);
			ASharedObject.getInstance().getKeyboard().addKeyAction("fly", Keyboard.F, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.LEFT, HeroActions.LEFT_KEY, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.RIGHT, HeroActions.RIGHT_KEY, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.INVERT, HeroActions.INVERT_KEY, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.HIGH_FLASHLIGHT, HeroActions.HIGH_FLASHLIGHT_KEY, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.FLASHLIGHT, HeroActions.FLASHLIGHT_KEY, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.BACKPACK, HeroActions.BACKPACK_KEY, inputChannel);
			ASharedObject.getInstance().getKeyboard().addKeyAction(HeroActions.CLIMB, HeroActions.CLIMB_KEY, inputChannel);
		}
		
		private function drawInsanityBar():void
		{
			insanityBarBackgorund = new Sprite();
			insanityBarBackgorund.graphics.beginFill(0x888888, .6);
			insanityBarBackgorund.graphics.drawRect(10, 10, 210, 40);
			_ce.stage.addChild(insanityBarBackgorund);
			
			insanityBar = new Sprite();
			insanityBar.graphics.beginFill(0x0000FF, .6);
			insanityBar.graphics.drawRect(15, 15, 200, 30);
			_ce.stage.addChild(insanityBar);
			insanityBar.scaleX = 0;
			
			if(!insanityDebug){
				insanityBarBackgorund.visible = false;
				insanityBar.visible = false;
			}
		}
		
		private function removeInsanityBar():void
		{
			if(insanityBarBackgorund){
				if(_ce.stage.contains(insanityBarBackgorund)){
					_ce.stage.removeChild(insanityBarBackgorund);
				}
			}
			if(insanityBar){
				if(_ce.stage.contains(insanityBar)){
					_ce.stage.removeChild(insanityBar);
				}
			}
		}
		
		public function shootRock():void
		{
			trace("vou atirar");
			trace("_sprite.mouseY " + _sprite.mouseY);
			trace("this.y " + this.y);
			var myPosX:Number = this.x - _camPos.x;
			var myPosY:Number = this.y - _camPos.y;
			trace("myPosY " + myPosY);
			
			angleOfShoot = Math.atan2(_sprite.mouseY - myPosY, _sprite.mouseX - myPosX);//the angle that it must move
			rock = new Rock("rock", _world, _worldScale, this.x, this.y, angleOfShoot, {width:10, height:10, radius:5, view: "../lib/pedra2_resize.png"});
			_ce.state.add(rock);
			//rock.calcPosition();
			rock1 = new RockAsset();
			//_ce.addChild(rock);
			
			
			rock.x = this.x + (50 * Math.cos(angleOfShoot));
			rock.y = this.y + (50 * Math.sin(angleOfShoot));
			//rock.dirX = new Number();
			rock.dirX = Math.cos(angleOfShoot) * 10;
			//rock.dirY = new Number();
			rock.dirY = Math.sin(angleOfShoot) * 10;
			arrayOfRocks.push(rock);
			
			dirX = Math.cos(angleOfShoot) * 10;
			dirY = Math.sin(angleOfShoot) * 10;
			
			setWithRock(false);
			//TODO arrumar rock tirar do state
			//_state.rock.x = 518;
			//_state.rock.y = 671;
			
			/*ySpeed=Math.sin(angle) * maxSpeed;//calculate how much it should move the enemy vertically
			xSpeed=Math.cos(angle) * maxSpeed;//calculate how much it should move the enemy horizontally
			//move the bullet towards the enemy
			this.x+= xSpeed;
			this.y+= ySpeed;*/
		}
		
		public function reset():void
		{
			//(_ce.state as DemoGameState).delayer.push(resetRotation);
			
			setTimeout(resetRotation, 0);
			
			if(isInverted){
				this.cancelInverted();
			}
			this.x = initialPos.x;
			this.y = initialPos.y;
			this.rotation = 90;
			insanity = 0;
			withRock = false;
			isWithTorch = false;
			isWithFlashlight = false;
			usingFlashlight = false;
			isInsane = false;
			cameraUsed = false;
			fog.reset();
			var normalColor:ColorTransform = new ColorTransform();
			normalColor.color = 0x0000FF;
			insanityBar.transform.colorTransform = normalColor;
		}
		
		private function resetRotation():void
		{
			this.rotation = 0;
		}
		
		override public function handleBeginContact(contact:b2Contact):void {
			var collider:IBox2DPhysicsObject = Box2DUtils.CollisionGetOther(this, contact);
			
			if (_enemyClass && collider is _enemyClass)
			{
				if (_body.GetLinearVelocity().y < killVelocity && !_hurt)
				{
					hurt();
					
					//fling the hero
					var hurtVelocity:b2Vec2 = _body.GetLinearVelocity();
					hurtVelocity.y = -hurtVelocityY;
					hurtVelocity.x = hurtVelocityX;
					if (collider.x > x)
						hurtVelocity.x = -hurtVelocityX;
					_body.SetLinearVelocity(hurtVelocity);
				}
				else
				{
					_springOffEnemy = collider.y - height;
					onGiveDamage.dispatch();
				}
			}
			
			//Collision angle if we don't touch a Sensor.
			if (contact.GetManifold().m_localPoint && !(collider is Sensor)) //The normal property doesn't come through all the time. I think doesn't come through against sensors.
			{				
				var collisionAngle:Number = (((new MathVector(contact.normal.x, contact.normal.y).angle) * 180 / Math.PI) + 360) % 360;// 0º <-> 360º
				
				if ((collisionAngle > 45 && collisionAngle < 135))
				{
					_groundContacts.push(collider.body.GetFixtureList());
					_onGround = true;
					updateCombinedGroundAngle();
				}
				if((collisionAngle > 225 && collisionAngle < 315)){
					_groundContacts.push(collider.body.GetFixtureList());
					_onGround = true;
					updateCombinedGroundAngle();
				}
			}
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			ticks = iLevel.getTicks();
			seconds = iLevel.getSeconds();
			minutes = iLevel.getMinutes();
			
			updateInsanity();
			debugInsanity();
			updateRocksPosition();
			
			updateShadowPosition();
			
			if(backpack){
				backpack.update();
			}
			
			
			// we get a reference to the actual velocity vector
			var velocity:b2Vec2 = _body.GetLinearVelocity();
			
			if (controlsEnabled)
			{
				var moveKeyPressed:Boolean = false;
				
				_ducking = (_ce.input.isDoing("duck", inputChannel) && _onGround && canDuck);
				
				if(_ce.input.justDid(HeroActions.HIGH_FLASHLIGHT, inputChannel) && !this.cameraUsed)
				{
					useCamera();
				}
				
				if(_ce.input.justDid(HeroActions.FLASHLIGHT, inputChannel) && !this.cameraUsed)
				{
					useFlashlight();
				}
				
				if(_ce.input.justDid(HeroActions.BACKPACK, inputChannel))
				{
					openBackPack();
				}
				
				if(_ce.input.justDid(HeroActions.INVERT, inputChannel))
				{
					invertWorld();
				}
				
				if(_ce.input.justDid("fly", inputChannel))
				{
					//insert "start flying" code here
				}
				
				if(_ce.input.isDoing("fly", inputChannel))
				{
					//if you are using a controller such as a joystick and want to give more control to your player, you can use the new getActionValue method
					var flying_intensity:Number = _ce.input.getActionValue("fly", inputChannel);
					//and apply it.
					velocity.y = - flying_intensity * 150; //this is just an example application, it might not be as accurate as you'd want it to.
					
					//insert other "flying" code here
				}
				
				if (_ce.input.justDid(HeroActions.RIGHT, inputChannel) && !_ducking)
					SoundManager.getInstance().playSound(SoundList.SFX_NORMAL_WALK_NAME);
					
				if (_ce.input.isDoing(HeroActions.RIGHT, inputChannel) && !_ducking)
				{
					velocity.Add(getSlopeBasedMoveAngle());
					moveKeyPressed = true;
				}
				
				if (_ce.input.justDid(HeroActions.RIGHT, inputChannel) && !_ducking)
					SoundManager.getInstance().playSound(SoundList.SFX_NORMAL_WALK_NAME);
				
				//if (_ce.input.hasDone(HeroActions.RIGHT, inputChannel) || _ce.input.hasDone(HeroActions.LEFT, inputChannel))
					//SoundManager.getInstance().stopSound(SoundList.SFX_NORMAL_WALK_NAME);
				
				if (_ce.input.isDoing(HeroActions.LEFT, inputChannel) && !_ducking)
				{
					velocity.Subtract(getSlopeBasedMoveAngle());
					moveKeyPressed = true;
				}
				
				//If player just started moving the hero this tick.
				if (moveKeyPressed && !_playerMovingHero)
				{
					_playerMovingHero = true;
					_fixture.SetFriction(0); //Take away friction so he can accelerate.
				}
					//Player just stopped moving the hero this tick.
				else if (!moveKeyPressed && _playerMovingHero)
				{
					SoundManager.getInstance().stopSound(SoundList.SFX_NORMAL_WALK_NAME);
					_playerMovingHero = false;
					_fixture.SetFriction(_friction); //Add friction so that he stops running
				}
				
				if (_onGround && _ce.input.justDid(HeroActions.JUMP, inputChannel) && !_ducking)
				{
					SoundManager.getInstance().playSound(SoundList.SFX_NORMAL_JUMP_NAME);
					if(isInverted){
						velocity.y = jumpHeight;
					}else{
						velocity.y = -jumpHeight;
					}
					onJump.dispatch();
				}
				
				if (_ce.input.isDoing(HeroActions.JUMP, inputChannel) && !_onGround && velocity.y < 0)
				{
					if(isInverted){
						velocity.y += jumpAcceleration;
					}else{
						velocity.y -= jumpAcceleration;
					}
				}
				
				if (_springOffEnemy != -1)
				{
					if (_ce.input.isDoing(HeroActions.JUMP, inputChannel))
						velocity.y = -enemySpringJumpHeight;
					else
						velocity.y = -enemySpringHeight;
					_springOffEnemy = -1;
				}
				
				//Cap velocities
				if (velocity.x > (maxVelocity))
					velocity.x = maxVelocity;
				else if (velocity.x < (-maxVelocity))
					velocity.x = -maxVelocity;
			}
			
			updateAnimation();
		}
		
		private function openBackPack():void
		{
			if(!backpack){
				var arrayTeste:Array = ["1", "2", "3", "4", "5", "6", "7", "8", "4", "5", "6", "7", "8", "4", "5", "6", "7", "8"]
				backpack = new Backpack();
				_ce.addChild(backpack);
				backpack.x = backpack.width/2;
				backpack.y = backpack.height/2;
				backpack.setArrayOfItens(arrayTeste);
				backpack.setCloseFunction(closeBackpack);
				backpack.init();
			}else{
				closeBackpack();
			}
		}
		
		private function closeBackpack():void
		{
			backpack.destroy();
			if(backpack){
				if(_ce.contains(backpack)){
					_ce.removeChild(backpack);
					backpack = null;
				}
			}
		}
		
		private function updateShadowPosition():void
		{
			//shadow.x = this.x - this.width/2 - _cam.transformMatrix.transformPoint(new Point(0,0)).x;
			if(isInverted){
				shadowPos.x = this.x;
				shadowPos.y = this.y - this.height/2;
				shadow.scaleY = -1;
			}else{
				shadow.scaleY = 1;
				shadowPos.x = this.x;
				shadowPos.y = this.y + this.height/2;
			}
			shadow.x = shadowPos.x;// + _cam.transformMatrix.transformPoint(new Point(0,0)).x;
			shadow.y = shadowPos.y;// + _cam.transformMatrix.transformPoint(new Point(0,0)).y;
			
			//shadow.x = _ce.localToGlobal(new Point(this.x - this.width/2 - this.getCamPos().x, this.y - this.height/2 - this.getCamPos().y)).x;
			//shadow.y = _ce.localToGlobal(new Point(this.x - this.width/2 - this.getCamPos().x, this.y - this.height/2 - this.getCamPos().y)).y;
		}
		
		private function updateRocksPosition():void
		{
			for (var i:int = 0; i < arrayOfRocks.length; i++) 
			{
				if(arrayOfRocks[i]){
					arrayOfRocks[i].getBody().SetLinearVelocity(new b2Vec2(arrayOfRocks[i].dirX,arrayOfRocks[i].dirY));
					/*arrayOfRocks[i].x += arrayOfRocks[i].dirX;
					arrayOfRocks[i].y += arrayOfRocks[i].dirY;*/
				}
			}
		}
		
		private function debugInsanity():void
		{
			if(insanityDebug){
				
			}
		}
		
		private function updateInsanity():void
		{
			if((ticks % insanityTime * FRAME_RATE) == 0){
				if(!isInverted){
					insanity+=2;
				}else{
					insanity-=2;
				}
				insanityBar.scaleX = insanity / insanityLimit;
				//trace(shadow.scaleX);
				//shadow.scaleX = shadow.scaleY = (insanity / insanityLimit) + 1;
				shadow.update(insanity, insanityLimit);
			}
			if(insanity >= insanityDangerous && insanity <= insanityLimit){
				isInsane = true;
				var insaneColor:ColorTransform = new ColorTransform();
				insaneColor.color = 0xFF0000;
				insanityBar.transform.colorTransform = insaneColor;
			}else if(insanity > insanityLimit){
				trace("morreu de loucura");
				this.reset();
			}else{
				if(isInsane){
					var normalColor:ColorTransform = new ColorTransform();
					normalColor.color = 0x0000FF;
					insanityBar.transform.colorTransform = normalColor;
					this.cancelInverted();
					isInsane = false;
				}
			}
			//trace(insanity/100);
			iLevel.updateInsanityBackground(insanity/100);
		}
		
		public function getViewAsMovieClip():MovieClip
		{
			var art:SpriteArt = _ce.state.view.getArt(this) as SpriteArt;
			
			if(art != null && art.content != null){
				return (art.content as MovieClip);
			}
			return null;
		}
		
		private function cancelInverted():void
		{
			insanity = 0;
			//TODO arrumar o invert e tirar do state
			invertWorld();
			isInsane = false;
			//iLevel.invertAll();
		}
		
		private function invertWorld():void
		{
			if(isInsane){
				trace("vou inverter");
				if(this.rotation == 0){
					this.rotation = 180;
					isInverted = true;
					SoundManager.getInstance().playSound(SoundList.SFX_INVERT_WORLD_NAME);
					SoundManager.getInstance().playSound(SoundList.SOUND_INVERT_WORLD_BACKGROUND_NAME);
				}else{
					SoundManager.getInstance().stopSound(SoundList.SOUND_INVERT_WORLD_BACKGROUND_NAME);
					SoundManager.getInstance().playSound(SoundList.SFX_REVERT_WORLD_NAME);
					this.rotation = 0;
					isInverted = false;
				}
				iLevel.invertAll();
			}
		}
		
		public function useCamera():void
		{
			SoundManager.getInstance().playSound(SoundList.SFX_HIGH_FLASHLIGHT_NAME);
			setInsanity(-5);
			insanity -= 5;
			cameraUsed = true;
			fog.useCamera();
		}
		
		public function setInsanity(value:int):void
		{
			insanity += value;
		}
		
		public function useFlashlight():void
		{
			if(this.isWithFlashlight && this.flashlightEnergy > this.minFlashlightEnergy){
				usingFlashlight = true;
				fog.useFlashlight();
				SoundManager.getInstance().playSound(SoundList.SFX_TURN_ON_FLASHLIGHT_NAME);
			}else if(this.isWithFlashlight && this.usingFlashlight){
				SoundManager.getInstance().playSound(SoundList.SFX_TURN_OFF_FLASHLIGHT_NAME);
				usingFlashlight = false;
				fog.useFlashlight();
			}
		}
		
		override public function destroy():void
		{
			ASharedObject.getInstance().setHeroInsanity(insanity);
			removeFog();
			removeShadow();
			removeInsanityBar();
			super.destroy();
		}
		
		public function setInverted(value:Boolean):void
		{
			isInverted = value;
			fog.setInverted(isInverted);
		}
		
		public function setWorldScale(value:Number):void
		{
			_worldScale = value;
		}
		
		public function setWorld(value:b2World):void
		{
			_world = value;
		}
		
		public function setWithRock(value:Boolean):void
		{
			withRock = value;
		}
		
		public function getWithRock():Boolean
		{
			return withRock;
		}
		
		public function setState(value:ILevel):void
		{
			iLevel = value;
		}
		
		public function setInitialPos(value:Point):void
		{
			initialPos = value;
		}
		
		public function setWithTorch(value:Boolean):void
		{
			isWithTorch = value;
			fog.setWithTorch(value);
		}
		
		public function setWithFlashlight(value:Boolean):void
		{
			this.flashlightEnergy = maxFlashlightEnergy;
			isWithFlashlight = value;
		}
		
		private function setDebugInsanity(value:Boolean):void
		{
			insanityDebug = value;
		}
		
		public function getIsInsane():Boolean
		{
			return isInsane;
		}
		
		public function setCameraUsed(value:Boolean):void
		{
			cameraUsed = value;
		}
		
		public function getCameraUsed():Boolean
		{
			return cameraUsed;
		}

		public function getCamPos():Point
		{
			return _camPos;
		}

		public function setCamPos(value:Point):void
		{
			_camPos = value;
		}
		
		public function getInsanity():int
		{
			return insanity;
		}

		public function getFlashlightEnergy():int
		{
			return flashlightEnergy;
		}

		public function setFlashlightEnergy(value:int):void
		{
			flashlightEnergy = value;
		}

		public function getMinFlashlightEnergy():int
		{
			return minFlashlightEnergy;
		}
		
		public function addFlashlightEnergy(value:int):void
		{
			flashlightEnergy += value;
		}
		
		public function substractFlashlightEnergy(value:int):void
		{
			flashlightEnergy -= value;
		}

		public function setMinFlashlightEnergy(value:int):void
		{
			minFlashlightEnergy = value;
		}

		public function getMaxFlashlightEnergy():int
		{
			return maxFlashlightEnergy;
		}

		public function setMaxFlashlightEnergy(value:int):void
		{
			maxFlashlightEnergy = value;
		}
		
		public function setCam(value:ACitrusCamera):void
		{
			_cam = value;
			_camPos = _cam.transformMatrix.transformPoint(new Point(0,0));
		}
		
		public function setViewRoot(value:Sprite):void
		{
			_viewRoot = value;
		}
		
		public function getViewRoot():Sprite
		{
			return _viewRoot;
		}
		
		public function setLevelWidth(value:Number):void
		{
			widthBound = value;
		}
		
		public function setLevelHeight(value:Number):void
		{
			heightBound = value;
		}
		
		public function setInLader(value:Boolean):void
		{
			inLader = value;
		}
		
		public function getInLader():Boolean
		{
			return inLader;
		}
	}
}