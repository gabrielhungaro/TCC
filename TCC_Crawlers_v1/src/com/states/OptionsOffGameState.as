package com.states
{
	import com.data.ASharedObject;
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import citrus.input.controllers.Keyboard;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;

	public class OptionsOffGameState extends AState
	{
		private var optionsScreen:OptionsOffGameAsset
		private var closeFunction:Function;
		private var arrayActionKeys:Array = [];
		private var arrayOfKeys:Array = [];
		private var arrayOfActions:Array = [];
		private var keyboard:Keyboard;
		private var actionsDic:Dictionary = new Dictionary();
		private var arrayOfTextFields:Array = [];
		private var optionStatus:String;
		private var timer:Timer = new Timer(100);  /// delay
		
		public function OptionsOffGameState()
		{
			super();
			actionsDic = ASharedObject.getInstance().getActionsDic();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			init();
			
			optionsScreen = new OptionsOffGameAsset();
			this.addChild(optionsScreen);
			
			optionsScreen.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			optionsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			optionsScreen.btnBack.buttonMode = true;
			
			if(ASharedObject.getInstance().getSfx()){
				optionsScreen.btnSfx.gotoAndStop("on");
			}else{
				optionsScreen.btnSfx.gotoAndStop("off");
			}
			
			optionsScreen.btnSfx.addEventListener(MouseEvent.CLICK, onClickSfx);
			optionsScreen.btnSfx.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnSfx.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			optionsScreen.btnSfx.buttonMode = true;
			
			if(ASharedObject.getInstance().getSound()){
				optionsScreen.btnSound.gotoAndStop("on");
			}else{
				optionsScreen.btnSound.gotoAndStop("off");
			}
			
			optionsScreen.btnSound.addEventListener(MouseEvent.CLICK, onClickSound);
			optionsScreen.btnSound.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnSound.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			optionsScreen.btnSound.buttonMode = true;
			
			optionsScreen.btnFullScreen.addEventListener(MouseEvent.CLICK, onClickFullScreen);
			optionsScreen.btnFullScreen.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			optionsScreen.btnFullScreen.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			optionsScreen.btnFullScreen.buttonMode = true;
			
			//this.btnScaleMode.addEventListener(MouseEvent.CLICK, onClickScaleMode);
			//this.btnScaleMode.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			//this.btnScaleMode.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//this.btnScaleMode.buttonMode = true;
			
			fillArrayOfActionObjects();
			
			/*for (var i:int = 0; i < this.configurationOptions.numChildren; i++) 
			{
			if(this.configurationOptions.getChildAt(i) is TextField){
			this.configurationOptions.getChildAt(i).addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
			arrayOfTextFields.push(this.configurationOptions.getChildAt(i));
			}
			}*/
		}
		
		
		private function init():void
		{
			for (var ii:int =0; ii < numChildren; ii++){
				var lamp:DisplayObject = getChildAt(ii);
				lamp.alpha = Math.random();
			}
			
			timer.addEventListener(TimerEvent.TIMER, restart);
			timer.start();
		}
		
		private function restart(event:Event):void
		{
			
			
			init();
			
		}
		
		private function fillArrayOfActionObjects():void
		{
			/*for (var i:int = 0; i < HeroActions.ArrayOfAction.length; i++) 
			{
				var objectAction:Object = new Object();
				objectAction.action = new String();
				objectAction.key = new String();
				objectAction.action = HeroActions.ArrayOfAction[i];
				objectAction.key = HeroActions.ArrayOfActionKeys[i];
				arrayActionKeys.push(objectAction);
			}*/
			
			optionsScreen.right.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(optionsScreen.right);
			optionsScreen.left.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(optionsScreen.left);
			optionsScreen.jump.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(optionsScreen.jump);
			optionsScreen.highflash.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(optionsScreen.highflash);
			optionsScreen.invert.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(optionsScreen.invert);
			
			for (var action:String in actionsDic) {
				var value:uint = actionsDic[action];
				var name:String = action;
				trace(actionsDic[name], name);
				var keyName:String = convertCodeToChar(actionsDic[name]);
				convertCodeToChar(actionsDic[name]);
				if(optionsScreen.getChildByName(name)){
					Object(optionsScreen.getChildByName(name)).text = keyName;
				}
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			var actionName:String = event.currentTarget.name;
			var keyName:String = convertCodeToChar(event.keyCode);
			for (var i:int = 0; i < arrayOfTextFields.length; i++) 
			{
				if(arrayOfTextFields[i].text == keyName){
					arrayOfTextFields[i].text = "-"
				}
			}
			event.currentTarget.text = keyName;
			verifyIfExistsAction(actionName, event.keyCode);
			//trace("arrayOfActions: " + arrayOfActions);
			//trace("arrayOfKeys: " + arrayOfKeys);
		}
		
		private function convertCodeToChar(code:uint):String
		{
			var char:String = String.fromCharCode(code).toUpperCase();
			if(code == Keyboard.SHIFT){
				char = "SHIFT";
			}
			if(code == Keyboard.CTRL){
				char = "CTRL";
			}
			if(code == Keyboard.SPACE){
				char = "SPACE";
			}
			if(code == Keyboard.ENTER){
				char = "ENTER";
			}
			if(code == Keyboard.LEFT){
				char = "LEFT";
			}
			if(code == Keyboard.RIGHT){
				char = "RIGHT";
			}
			if(code == Keyboard.UP){
				char = "UP";
			}
			if(code == Keyboard.DOWN){
				char = "DOWN";
			}
			return char;
		}
		
		private function verifyIfExistsAction(actionName:String, keyCode:uint):void
		{
			actionsDic[actionName] = keyCode;
			for (var action:String in actionsDic) {
				var value:uint = actionsDic[action];
				var name:String = action;
				if(value == keyCode && name != actionName){
					actionsDic[name] = 0;
				}
				trace(actionsDic[name], name);
			}
			trace("===================================");
			/*if(arrayOfActions.indexOf(actionName) == -1){
				arrayOfActions.push(actionName);
			}else{
				arrayOfActions.splice(arrayOfActions.indexOf(actionName), 1);
			}
			if(arrayOfKeys.indexOf(keyCode) == -1){
				arrayOfKeys.push(keyCode);
			}else{
				arrayOfKeys.splice(arrayOfKeys.indexOf(keyCode), 1);
			}*/
		}
		
		protected function onClickOk(event:MouseEvent):void
		{
			verifyInputs();
		}
		
		private function verifyInputs():void
		{
			keyboard.resetAllKeyActions();
			for (var action:String in actionsDic) {
				var value:uint = actionsDic[action];
				var name:String = action;
				//trace(value, name);
				keyboard.addKeyAction(name, value, 0);
			}
			ASharedObject.getInstance().setActionsDic(actionsDic);
			/*for (var i:int = 0; i < arrayActionKeys.length; i++) 
			{
				if(arrayActionKeys[i].action == arrayOfActions[i]){
					arrayActionKeys[i].key = arrayOfKeys[i];
				}
			}*/
		}
		
		protected function onClickSfx(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).mute = !SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).mute;
			ASharedObject.getInstance().setSfx(!ASharedObject.getInstance().getSfx());
			if(ASharedObject.getInstance().getSfx()){
				optionsScreen.btnSfx.gotoAndStop("on");
			}else{
				optionsScreen.btnSfx.gotoAndStop("off");
			}
		}
		
		protected function onClickSound(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).mute = !SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).mute;
			ASharedObject.getInstance().setSound(!ASharedObject.getInstance().getSound());
			if(ASharedObject.getInstance().getSound()){
				optionsScreen.btnSound.gotoAndStop("on");
			}else{
				optionsScreen.btnSound.gotoAndStop("off");
			}
		}
		
		protected function onClickFullScreen(event:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL){
				stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.fullScreenSourceRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
				optionsScreen.btnFullScreen.gotoAndStop(2);
			}else{
				optionsScreen.btnFullScreen.gotoAndStop(1);
				stage.displayState = StageDisplayState.NORMAL;
				stage.fullScreenSourceRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			}
		}
		
		protected function onClickScaleMode(event:MouseEvent):void
		{
			if(stage.scaleMode == StageScaleMode.EXACT_FIT){
				stage.scaleMode = StageScaleMode.NO_BORDER;
			}else if(stage.scaleMode == StageScaleMode.NO_BORDER){
				stage.scaleMode = StageScaleMode.NO_SCALE;
			}else if(stage.scaleMode == StageScaleMode.NO_SCALE){
				stage.scaleMode = StageScaleMode.SHOW_ALL;
			}else if(stage.scaleMode == StageScaleMode.SHOW_ALL){
				stage.scaleMode = StageScaleMode.EXACT_FIT;
			}
			event.currentTarget.text = stage.scaleMode;
		}
		
		protected function onClickBack(event:MouseEvent):void
		{
			verifyInputs();
			ASharedObject.getInstance().getCitrusEngineRef().levelManager.gotoLevel(StateManager.STATE_OPTIONS);
		}
		
		protected function onMouseOver(event:MouseEvent):void
		{
			TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1.3 }} );
		}
		
		protected function onMouseOut(event:MouseEvent):void
		{
			TweenMax.to(event.currentTarget, 0.1, { colorTransform: { tint:0xffffff, exposure:1 }} );
		}
		
		public function setCloseFunction(value:Function):void
		{
			closeFunction = value;
		}
		
		public function setKeyboard(value:Keyboard):void
		{
			keyboard = value;
		}
	}
}