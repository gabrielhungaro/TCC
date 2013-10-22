package com.levels
{
	import com.Bat;
	import com.Hole;
	import com.ImageConstants;
	import com.Spike;
	import com.Spike2;
	import com.data.ASharedObject;
	import com.hero.MyHero;
	import com.objects.Flashlight;
	import com.objects.Lader;
	import com.objects.NextLevel;
	import com.objects.Page;
	import com.objects.PrevLevel;
	import com.objects.Stack;
	import com.objects.Torch;
	import com.states.AState;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;
	
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.spriteview.SpriteView;
	
	public class Level extends AState implements ILevel
	{
		public var _levelSWF:MovieClip;
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		public var box2D:Box2D;
		
		private var isPaused:Boolean = true;;
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var isInverted:Boolean;
		private var yGravity:Number;
		
		private var viewRoot:SpriteView;
		private var bg:CitrusSprite;
		private var bgInsanity:CitrusSprite;
		protected var displayBgInsanity:DisplayObject;
		private var upImage:CitrusSprite;
		private var upImageInsanity:CitrusSprite;
		protected var displayUpImageInsanity:DisplayObject;
		private var arrayOfInanitysParties:Array;
		
		private var loadingScreen:Sprite;
		private var loadingStatus:LoadingAsset;
		
		public function Level(levelSWF:MovieClip = null)
		{
			super();
			this._levelSWF = levelSWF;
			objectsArray = [Platform, Hole, Page, Lader, Spike, Spike2, MyHero, Torch, Bat, Flashlight, Stack, NextLevel, PrevLevel];
			//addLoadingScreen();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			/*viewRoot = this._realState.view as SpriteView;
			
			box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			addBackground();
			
			ObjectMaker2D.FromMovieClip(_levelSWF);*/
			//view.loadManager.onLoadComplete.addOnce(handleLoadComplete);
			setTimeout(loadLevel, 0);
		}
		
		private function handleLoadComplete():void
		{
			// TODO Auto Generated method stub
			trace("loading test");
		}
		
		private function loadLevel():void
		{
			super.initialize();
			
			viewRoot = this._realState.view as SpriteView;
			
			box2D = new Box2D("box2D");
			box2D.visible = true;
			add(box2D);
			
			addBackground();
			
			ObjectMaker2D.FromMovieClip(_levelSWF);
			
			createHero();
			setUpCamera();
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheel);
			
			addUpPart();
			loadSounds();
			isPaused = false;
			//removeLoadingScreen();
		}
		
		private function _mouseWheel(event:MouseEvent):void {
			if (event.delta > 0)
				view.camera.setZoom(view.camera.getZoom() + 0.1);
			else if (event.delta < 0)
				view.camera.setZoom(view.camera.getZoom() - 0.1);
		}
		
		public function addBackground(imageName:String = "", imageURL:String = ""):void
		{
			//view.loadManager.onLoadComplete.add(handleLoadComplete);
			bg = new CitrusSprite(imageName, {view: imageURL});
			bg.parallaxX = 1;
			add(bg);
		}
		
		public function addBackgroundInsanity(imageName:String = "", imageURL:String = ""):void
		{
			arrayOfInanitysParties = new Array();
			bgInsanity = new CitrusSprite(imageName, {view: imageURL});
			bgInsanity.parallaxX = 1;
			add(bgInsanity);
			
			displayBgInsanity = view.getArt(bgInsanity) as DisplayObject;
			displayBgInsanity.alpha = 0;
			arrayOfInanitysParties.push(displayBgInsanity);
			//TestDo.alpha = 0;
			//eaze((TestDo).to(1, {alpha:1}).to(0, {alpha:1});
		}
		
		public function addUpPart(imageURL:String = "", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			upImage = new CitrusSprite(ImageConstants.UP_PART_NAME, {view: imageURL});
			upImage.parallaxX = imageParallaxX;
			upImage.parallaxY = imageParallaxY;
			add(upImage);
		}
		
		public function addUpPartInsanity(imageURL:String = "", imageParallaxX:Number = 1, imageParallaxY:Number = 1):void
		{
			upImageInsanity = new CitrusSprite(ImageConstants.UP_PART_NAME, {view: imageURL});
			upImageInsanity.parallaxX = imageParallaxX;
			upImageInsanity.parallaxY = imageParallaxY;
			add(upImageInsanity);
			
			displayUpImageInsanity = view.getArt(upImageInsanity) as DisplayObject;
			displayUpImageInsanity.alpha = 0;
			arrayOfInanitysParties.push(displayUpImageInsanity);
		}
		
		/*override protected function loadSounds():void
		{
			super.loadSounds();
			SoundManager.getInstance().playSound(SoundList.SOUND_TUTORIAL1_BACKGROUND_NAME);
		}*/
		
		public function setUpCamera():void
		{
			
			var widthBound:int = _levelSWF.width;
			var heightBound:int = _levelSWF.height;
			if(widthBound <= stage.stageWidth){
				widthBound = stage.stageWidth;
			}
			if(heightBound <= stage.stageHeight){
				heightBound = stage.stageHeight;
			}
			view.camera.setUp(hero, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, widthBound, heightBound), new Point(.25, .20));
			//view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			view.camera.allowZoom = true;
			//view.camera.boundsMode = ACitrusCamera.BOUNDS_MODE_ADVANCED;
			//view.camera.restrictZoom = true;
			
			//LIBERA A ROTAÇÃO DA CAMERA
			view.camera.allowRotation = true;
			view.camera.reset();
		}
		
		public function createHero():void
		{
			
			//var _hero:MyHero = getObjectByName("Hero") as MyHero;
			hero = getObjectByName("Hero") as MyHero;
			//hero = MyHero.getInstace();
			hero.name = "Hero";
			hero.setState(this);
			hero.setCam(view.camera);
			hero.setViewRoot(viewRoot.viewRoot);
			//hero.setCamPos(view.camera.camPos);
			hero.setWorld(this.box2D.world);
			hero.setWorldScale(this.box2D.scale);
			hero.setInitialPos(new Point(hero.x, hero.y));
			trace("hero.x, hero.y: " + hero.x, hero.y);
			hero.init();
		}
		
		override public function update(timeDelta:Number):void
		{
			if(!isPaused){
				super.update(timeDelta);
				box2D.world.Step(1/30, 10, 10);
				
				ticks++;
				if(ticks >= ASharedObject.getInstance().getCitrusEngineRef().stage.frameRate){
					ticks = 0;
					seconds++;
				}
				if(seconds >= 60){
					seconds = 0;
					minutes++;
				}
			}
		}
		
		public function invertAll():void
		{
			/*if(hero.rotation == 0){
				hero.rotation = 180;
				isInverted = true;
			}else{
				hero.rotation = 0;
				isInverted = false;
			}*/
			var widthBound:int = _levelSWF.width;
			var heightBound:int = _levelSWF.height;
			view.camera.rotate(Math.PI);
			view.camera.setUp(hero, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, widthBound, heightBound), new Point(.25, .20));
			//setUpCamera();
			//view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			//trace("Invertendo tudo" + box2D.world.GetGravity().y);
			yGravity = box2D.world.GetGravity().y * (-1);
			box2D.world.SetGravity(new b2Vec2(0, yGravity));
			//_ce.rotation += 5;
			//hero.setInverted(isInverted);
		}
		
		public function updateInsanityBackground(insanityAlpha:Number):void
		{
			if(arrayOfInanitysParties){
				for (var i:int = 0; i < arrayOfInanitysParties.length; i++) 
				{
					if(arrayOfInanitysParties[i]){
						arrayOfInanitysParties[i].alpha = insanityAlpha;
					}
				}
			}
		}
		
		override public function destroy():void
		{
			hero.destroy();
			super.destroy();
		}
		
		public function getTicks():int
		{
			return ticks;
		}
		
		public function getSeconds():int
		{
			return seconds;
		}
		
		public function getMinutes():int
		{
			return minutes;
		}
		
		public function getCamPos():Point
		{
			return this.view.camera.camPos;
		}
	}
}