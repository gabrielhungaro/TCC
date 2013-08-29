package com
{
	import com.hero.HeroActions;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.State;
	import citrus.input.controllers.Keyboard;
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.objects.platformer.box2d.Sensor;
	import citrus.objects.platformer.box2d.Teleporter;
	import citrus.physics.box2d.Box2D;
	import citrus.utils.objectmakers.ObjectMaker2D;
	import citrus.view.spriteview.SpriteArt;
	
	/**
	 * @author GabrielHungaro
	 */
	public class DemoGameState extends State
	{
		
		//private var _ce:CitrusEngine;
		
		private var box2D:Box2D;
		private var yGravity:Number = 1;
		public var hero:MyHero;
		private var _levelSWF:MovieClip;
		
		private var door:Sensor;
		
		private var _debugSprite:Sprite;
		private var isInverted:Boolean;
		
		private var heroArt:SpriteArt;
		
		private var ticks:int;
		private var seconds:int;
		private var minutes:int;
		private var objectsArray:Array;
		public var rock:Sensor;
		private var torch:Sensor;
		private var isPaused:Boolean = false;
		private var tutorialScreen:TutorialScreenAsset;
		private var jaViu:Boolean;
		
		private var spike1:Spike;
		private var spike2:Spike;
		
		//public var delayer:Vector.<Function> = new Vector.<Function>();
		private var sawRockTutorial:Boolean = false;
		
		
		public function DemoGameState(levelSWF:MovieClip, debugSprite:Sprite)
		{
			super();
			_levelSWF = levelSWF;
			_debugSprite = debugSprite;
			objectsArray = [Platform, Spike, MyHero]
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			_ce = CitrusEngine.getInstance();
			
			box2D = new Box2D("box2D");
			box2D.visible = false;
			add(box2D);
			
			var bg:CitrusSprite = new CitrusSprite("background", {view: "../lib/bg_level1_resize.jpg", width:10, height:stage.stageHeight});
			add(bg);
			
			ObjectMaker2D.FromMovieClip(_levelSWF);
			
			//var heroAsset:HeroAsset = new HeroAsset();
			//addChild(heroAsset);
			hero = getObjectByName("Hero") as MyHero;
			
			//hero.view = new HeroAsset();
			hero.setState(this);
			hero.setWorld(box2D.world);
			hero.setWorldScale(box2D.scale);
			hero.setInitialPos(new Point(hero.x, hero.y))
			hero.init();
			//heroArt = view.getArt(hero) as SpriteArt;
			//hero.setParams(hero.view, heroAsset);
			
			spike1 = getObjectByName("Spike") as Spike;
			spike1.setHero(hero);
			
			spike2 = getObjectByName("Spike2") as Spike;
			spike2.setHero(hero);
			
			door = getObjectByName("Door") as Sensor;
			door.onBeginContact.add(doorTouched);
			
			rock = getObjectByName("Rock") as Sensor;
			rock.onBeginContact.add(cathRock);
			
			torch = getObjectByName("Torch") as Sensor;
			torch.onBeginContact.add(cathTorch);
			
			//hero = new Hero("hero", {x:100, y:300, width:heroAsset.width, height:heroAsset.height});
			//hero.view = heroAsset;
			//add(hero);
			
			view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			view.camera.restrictZoom = true;
			
			//LIBERA A ROTAÇÃO DA CAMERA
			view.camera.allowRotation = true;
			
			hero.onGiveDamage.add(heroAttack);
			hero.onTakeDamage.add(heroHurt);
			
			addTutorialScreen("Para movimentar o personagem use as setas do teclado, para pular use a barra de espaço. Cuidado com sua insanidade a barra a cima mostra o nível dela, quando ela chegar no máximo você morre, quando a insanidade atingir um nível de perigo e a barra ficar vermelha e você pode precionar a tecla 'Z' para rotacionar a tela");
			
			var keyboard:Keyboard = CitrusEngine.getInstance().input.keyboard as Keyboard;
			//and here we can add the "fly" action to the keyboard, that will only be sent to channel 1.
			keyboard.addKeyAction("fly", Keyboard.F);
			keyboard.addKeyAction("left", Keyboard.A);
			
			keyboard.addKeyAction(HeroActions.INVERT, Keyboard.Z);
			
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			this.stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function addTutorialScreen(msg:String):void
		{
			tutorialScreen = new TutorialScreenAsset;
			tutorialScreen.x = _ce.stage.stageWidth/2;
			tutorialScreen.y = _ce.stage.stageHeight/2;
			tutorialScreen.textContent.text = msg;
			_ce.addChild(tutorialScreen);
			
			tutorialScreen.okButton.addEventListener(MouseEvent.CLICK, onClickOk);
			
			isPaused = true;
		}
		
		protected function onClickOk(event:MouseEvent):void
		{
			tutorialScreen.okButton.removeEventListener(MouseEvent.CLICK, onClickOk);
			removeTutorialScreen();
			tutorialScreen = null;
			if(jaViu){
				isPaused = false;
			}else{
				addTutorialScreen("Para aumentar rapidamente seu campo de visão utilize o ecolocalizador, precionando a tecla 'SHIFT' porém use com cuidado, pois cada vez que utilizá-lo sua insanidade irá aumentar, cuidado para não ser consumido por ela");
				jaViu = true;
			}
		
		}
		
		private function removeTutorialScreen():void
		{
			_ce.removeChild(tutorialScreen);
		}
		
		private function cathRock(contact:b2Contact):void
		{
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				if(!sawRockTutorial){
					sawRockTutorial = true;
					addTutorialScreen("você pegou uma pedra para jogá-la clique com o botão esquerdo do mouse");
				}
				rock.x = 0;
				rock.y = 0;
				hero.setWithRock(true);
			}
		}
		
		private function cathTorch(contact:b2Contact):void
		{
			if(contact.GetFixtureA().GetBody().GetUserData() is MyHero){
				addTutorialScreen("Você pegou a tocha, com ela seu campo de visão aumenta, porém vai diminuindo com o tempo, para utilizá-la novamente precione a tecla 'C'!");
				torch.x = 0;
				torch.y = 0;
				hero.setWithTorch(true);
				
			}
		}
		
		protected function onClick(event:MouseEvent):void
		{
			if(hero.getWithRock() && !tutorialScreen){
				hero.shootRock();
			}
		}
		
		private function doorTouched(contact:b2Contact):void
		{
			if (contact.GetFixtureA().GetBody().GetUserData() is MyHero) {
				addTutorialScreen("Parabéns chegou ao final do tutorial!");
				trace("Entrou na porta" + hero.x);
			}
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
				
				/*if(delayer.length > 0)
				{
					var delayf:Function;
					while(delayf = delayer.pop())
					{
						delayf();
					}
				}*/
			}
			//trace(view.camera.camPos);
			
			//VERIFICA SE A AÇÃO SETADA ACIMA FOI FEITA
			/*if(_ce.input.justDid("rotate")){
				view.camera.rotate(Math.PI);
			}*/
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.X){
				hero.setWithRock(false);
			}
		}
		
		//TODO substituir pelos inputs do Hero
		protected function onKeyDown(event:KeyboardEvent):void
		{
			if(event.keyCode == citrus.input.controllers.Keyboard.Z){
				//rotaciona com Tween
				if(hero.getIsInsane()){
					invertAll();
				}
				
				//rotaciona sem Tween
				//MathUtils.RotateAroundInternalPoint(this, new Point(stage.stageWidth/2, stage.stageHeight/2), 180);
				
				//view.camera.offset = new MathVector(stage.stageWidth/2, stage.stageHeight/2);
				//view.camera.bounds = new Rectangle(0, 0, 1550, 450);
			}
			if(event.keyCode == Keyboard.SHIFT){
				if(!hero.getEcolocalizadorUsed()){
					hero.useEcolocalizador();
				}
			}
			if(event.keyCode == Keyboard.X){
				hero.setWithRock(true);
			}
			if(event.keyCode == Keyboard.C){
				hero.setWithTorch(true);
			}
		}
		
		protected function mouseWheel(event:MouseEvent):void
		{
			scaleX = event.delta > 0 ? scaleX + .03 : scaleX - .03;
			scaleY = scaleX;
		}
		
		private function heroAttack():void
		{
			//_ce.sound.playSound("Kill", 1, 0);
		}
		
		private function heroHurt():void
		{
			//_ce.sound.playSound("Hurt", 1, 0);
		}
		
		public function invertAll():void
		{
			if(hero.rotation == 0){
				hero.rotation = 180;
				isInverted = true;
			}else{
				hero.rotation = 0;
				isInverted = false;
			}
			view.camera.rotate(Math.PI);
			view.camera.setUp(hero, new MathVector(stage.stageWidth/2, stage.stageHeight/2), new Rectangle(0, 0, 1550, 1500), new MathVector(.25, .05));
			//trace("Invertendo tudo" + box2D.world.GetGravity().y);
			yGravity = box2D.world.GetGravity().y * (-1);
			box2D.world.SetGravity(new b2Vec2(0, yGravity));
			//_ce.rotation += 5;
			hero.setInverted(isInverted);
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
	}
}