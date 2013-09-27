package com.levels
{
	import com.Bat;
	import com.ImageConstants;
	import com.Spike;
	import com.Spike2;
	import com.data.SoundList;
	import com.hero.MyHero;
	import com.objects.Flashlight;
	import com.objects.NextLevel;
	import com.objects.PrevLevel;
	import com.objects.Stack;
	import com.objects.Torch;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.core.CitrusEngine;
	import citrus.core.State;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.spriteview.SpriteView;
	
	import org.osflash.signals.Signal;
	
	public class Level extends State implements ILevel
	{
		public var _levelSWF:MovieClip;
		private var objectsArray:Array;
		private var _debugSprite:Sprite;
		private var hero:MyHero;
		public var box2D:Box2D;
		
		private var isPaused:Boolean;
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var isInverted:Boolean;
		private var yGravity:Number;
		
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		
		private var viewRoot:SpriteView;
		private var bg:CitrusSprite;
		private var upImage:CitrusSprite;
		
		public function Level(levelSWF:MovieClip = null)
		{
			super();
			this._levelSWF = levelSWF;
			lvlEnded = new Signal();
			restartLevel = new Signal();
			objectsArray = [Platform, Spike, Spike2, MyHero, Torch, Bat, Flashlight, Stack, NextLevel, PrevLevel]
		}
		
		override public function initialize():void
		{
			super.initialize();
			_ce = CitrusEngine.getInstance();
			
			viewRoot = this._realState.view as SpriteView;
			
			box2D = new Box2D("box2D");
			box2D.visible = false;
			add(box2D);
			
			addBackground();
			
			ObjectMaker2D.FromMovieClip(_levelSWF);
			
			createHero();
			setUpCamera();
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, _mouseWheel);
			
			addUpPart();
			loadSounds();
		}
		
		private function _mouseWheel(event:MouseEvent):void {
			if (event.delta > 0)
				view.camera.setZoom(view.camera.getZoom() + 0.1);
			else if (event.delta < 0)
				view.camera.setZoom(view.camera.getZoom() - 0.1);
		}
		
		public function addBackground(imageURL:String = ""):void
		{
			bg = new CitrusSprite(ImageConstants.BACKGROUND_NAME, {view: imageURL});
			bg.parallaxX = 1;
			add(bg);
		}
		
		public function addUpPart(imageURL:String = ""):void
		{
			upImage = new CitrusSprite(ImageConstants.UP_PART_NAME, {view: imageURL});
			upImage.parallaxX = 1.1;
			add(upImage);
		}
		
		private function loadSounds():void
		{
			SoundManager.getInstance().addSound(SoundList.TUTORIAL1_SOUND_NAME, { sound:SoundList.TUTORIAL1_SOUND, loop:false, triggerSoundComplete:true,triggerRepeatComplete:true, timesToRepeat:12 , group:CitrusSoundGroup.BGM } );
			SoundManager.getInstance().playSound(SoundList.TUTORIAL1_SOUND_NAME);
		}
		
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
			trace(widthBound, heightBound);
			view.camera.setUp(hero, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, widthBound, heightBound), new Point(.25, .05));
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
				if(ticks >= _ce.stage.frameRate){
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
			view.camera.rotate(Math.PI);
			view.camera.setUp(hero, new Point(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new Point(.25, .05));
			//view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			//trace("Invertendo tudo" + box2D.world.GetGravity().y);
			yGravity = box2D.world.GetGravity().y * (-1);
			box2D.world.SetGravity(new b2Vec2(0, yGravity));
			//_ce.rotation += 5;
			//hero.setInverted(isInverted);
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