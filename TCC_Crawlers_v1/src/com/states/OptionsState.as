package com.states
{
	import com.greensock.TweenMax;
	import com.hero.HeroActions;
	
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import citrus.input.controllers.Keyboard;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;

	public class OptionsState extends OptionScreenAsset
	{
		private var closeFunction:Function;
		private var arrayActionKeys:Array = [];
		private var arrayOfKeys:Array = [];
		private var arrayOfActions:Array = [];
		private var keyboard:Keyboard;
		private var actionsDic:Dictionary = new Dictionary();
		private var arrayOfTextFields:Array = [];
		public function OptionsState()
		{
			this.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnBack.buttonMode = true;
			
			this.btnOk.addEventListener(MouseEvent.CLICK, onClickOk);
			this.btnOk.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnOk.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnOk.buttonMode = true;
			
			this.btnEffects.addEventListener(MouseEvent.CLICK, onClickEffects);
			this.btnEffects.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnEffects.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnEffects.buttonMode = true;
			
			this.btnSound.addEventListener(MouseEvent.CLICK, onClickSound);
			this.btnSound.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnSound.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnSound.buttonMode = true;
			
			this.btnFullScreen.addEventListener(MouseEvent.CLICK, onClickFullScreen);
			this.btnFullScreen.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnFullScreen.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnFullScreen.buttonMode = true;
			
			this.btnScaleMode.addEventListener(MouseEvent.CLICK, onClickScaleMode);
			this.btnScaleMode.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnScaleMode.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			//this.btnScaleMode.buttonMode = true;
			
			fillArrayOfActionObjects();
			
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				if(this.getChildAt(i) is TextField){
					this.getChildAt(i).addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
					arrayOfTextFields.push(this.getChildAt(i));
				}
			}
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
			actionsDic[HeroActions.LEFT] = HeroActions.LEFT_KEY;
			actionsDic[HeroActions.RIGHT] = HeroActions.RIGHT_KEY;
			actionsDic[HeroActions.JUMP] = HeroActions.JUMP_KEY;
			actionsDic[HeroActions.INVERT] = HeroActions.INVERT_KEY;
			actionsDic[HeroActions.ACTION] = HeroActions.ACTION_KEY;
			actionsDic[HeroActions.HIGH_FLASHLIGHT] = HeroActions.HIGH_FLASHLIGHT_KEY;
			actionsDic[HeroActions.FLASHLIGHT] = HeroActions.FLASHLIGHT_KEY;
			actionsDic[HeroActions.BACKPACK] = HeroActions.BACKPACK_KEY;
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			var actionName:String = event.currentTarget.name;
			var keyName:String;
			if(event.keyCode){
				keyName = String.fromCharCode(event.charCode).toUpperCase();
			}
			if(event.keyCode == Keyboard.SHIFT){
				keyName = "SHIFT";
			}
			if(event.keyCode == Keyboard.CTRL){
				keyName = "CTRL";
			}
			if(event.keyCode == Keyboard.SPACE){
				keyName = "SPACE";
			}
			if(event.keyCode == Keyboard.ENTER){
				keyName = "ENTER";
			}
			if(event.keyCode == Keyboard.LEFT){
				keyName = "LEFT";
			}
			if(event.keyCode == Keyboard.RIGHT){
				keyName = "RIGHT";
			}
			if(event.keyCode == Keyboard.UP){
				keyName = "UP";
			}
			if(event.keyCode == Keyboard.DOWN){
				keyName = "DOWN";
			}
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
			
			/*for (var i:int = 0; i < arrayActionKeys.length; i++) 
			{
				if(arrayActionKeys[i].action == arrayOfActions[i]){
					arrayActionKeys[i].key = arrayOfKeys[i];
				}
			}*/
		}
		
		protected function onClickEffects(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).mute = !SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).mute;
		}
		
		protected function onClickSound(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).mute = !SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).mute;
			this.btnSound.gotoAndStop(2);
		}
		
		protected function onClickFullScreen(event:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL){
				stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.fullScreenSourceRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
				this.btnFullScreen.gotoAndStop(2);
			}else{
				this.btnFullScreen.gotoAndStop(1);
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
			this.closeFunction();
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
		
		public function destroy():void
		{
			this.btnBack.removeEventListener(MouseEvent.CLICK, onClickBack);
			this.btnBack.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnBack.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			closeFunction = null;
		}
	}
}