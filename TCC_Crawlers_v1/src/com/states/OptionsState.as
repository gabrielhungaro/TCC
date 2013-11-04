package com.states
{
	import com.data.ASharedObject;
	import com.greensock.TweenMax;
	
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
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
		private var optionStatus:String;
		private const STATE_NORMAL:String = "normal";
		private const STATE_CONFIGURATION:String = "configuration";
		public function OptionsState()
		{
			
			optionStatus = STATE_NORMAL;
			this.configurationOptions.visible = false;
			actionsDic = ASharedObject.getInstance().getActionsDic();
			
			this.btnBack.addEventListener(MouseEvent.CLICK, onClickBack);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnBack.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnBack.buttonMode = true;
			
			this.btnConfirm.addEventListener(MouseEvent.CLICK, onClickOk);
			this.btnConfirm.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.btnConfirm.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.btnConfirm.buttonMode = true;
			
			if(ASharedObject.getInstance().getSfx()){
				this.normalOptions.btnSfxOn.gotoAndStop("on");
				this.normalOptions.btnSfxOff.gotoAndStop("off");
			}else{
				this.normalOptions.btnSfxOn.gotoAndStop("off");
				this.normalOptions.btnSfxOff.gotoAndStop("on");
			}
			
			this.normalOptions.btnSfxOn.addEventListener(MouseEvent.CLICK, onClickSfxOn);
			this.normalOptions.btnSfxOn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.normalOptions.btnSfxOn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.normalOptions.btnSfxOn.buttonMode = true;
			this.normalOptions.btnSfxOff.addEventListener(MouseEvent.CLICK, onClickSfxOff);
			this.normalOptions.btnSfxOff.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.normalOptions.btnSfxOff.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.normalOptions.btnSfxOff.buttonMode = true;
			
			if(ASharedObject.getInstance().getSound()){
				this.normalOptions.btnSoundOn.gotoAndStop("on");
				this.normalOptions.btnSoundOff.gotoAndStop("off");
			}else{
				this.normalOptions.btnSoundOn.gotoAndStop("off");
				this.normalOptions.btnSoundOff.gotoAndStop("on");
			}
			
			this.normalOptions.btnSoundOn.addEventListener(MouseEvent.CLICK, onClickSoundOn);
			this.normalOptions.btnSoundOn.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.normalOptions.btnSoundOn.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.normalOptions.btnSoundOn.buttonMode = true;
			this.normalOptions.btnSoundOff.addEventListener(MouseEvent.CLICK, onClickSoundOff);
			this.normalOptions.btnSoundOff.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.normalOptions.btnSoundOff.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.normalOptions.btnSoundOff.buttonMode = true;
			
			this.normalOptions.btnFullScreen.addEventListener(MouseEvent.CLICK, onClickFullScreen);
			this.normalOptions.btnFullScreen.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.normalOptions.btnFullScreen.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.normalOptions.btnFullScreen.buttonMode = true;
			
			this.normalOptions.btnConfiguration.addEventListener(MouseEvent.CLICK, onClickConfiguration);
			this.normalOptions.btnConfiguration.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.normalOptions.btnConfiguration.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.normalOptions.btnConfiguration.buttonMode = true;
			
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
			
			this.configurationOptions.right.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(this.configurationOptions.right);
			this.configurationOptions.left.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(this.configurationOptions.left);
			this.configurationOptions.jump.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(this.configurationOptions.jump);
			this.configurationOptions.highflash.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(this.configurationOptions.highflash);
			this.configurationOptions.invert.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			arrayOfTextFields.push(this.configurationOptions.invert);
			
			for (var action:String in actionsDic) {
				var value:uint = actionsDic[action];
				var name:String = action;
				trace(actionsDic[name], name);
				var keyName:String = convertCodeToChar(actionsDic[name]);
				convertCodeToChar(actionsDic[name]);
				if(this.configurationOptions.getChildByName(name)){
					Object(this.configurationOptions.getChildByName(name)).textField.text = keyName;
				}
			}
		}
		
		protected function onKeyDown(event:KeyboardEvent):void
		{
			var actionName:String = event.currentTarget.name;
			var keyName:String = convertCodeToChar(event.keyCode);
			/*if(event.keyCode){
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
			}*/
			for (var i:int = 0; i < arrayOfTextFields.length; i++) 
			{
				if(arrayOfTextFields[i].textField.text == keyName){
					arrayOfTextFields[i].textField.text = "-"
				}
			}
			event.currentTarget.textField.text = keyName;
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
		
		protected function onClickSfxOn(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).mute = false;
			ASharedObject.getInstance().setSfx(true);
			this.normalOptions.btnSfxOn.gotoAndStop("on");
			this.normalOptions.btnSfxOff.gotoAndStop("off");
		}
		
		protected function onClickSfxOff(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.SFX).mute = true;
			ASharedObject.getInstance().setSfx(false);
			this.normalOptions.btnSfxOn.gotoAndStop("off");
			this.normalOptions.btnSfxOff.gotoAndStop("on");
		}
		
		protected function onClickSoundOn(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).mute = false;
			ASharedObject.getInstance().setSound(true);
			this.normalOptions.btnSoundOn.gotoAndStop("on");
			this.normalOptions.btnSoundOff.gotoAndStop("off");
		}
		
		protected function onClickSoundOff(event:MouseEvent):void
		{
			SoundManager.getInstance().getGroup(CitrusSoundGroup.BGM).mute = true;
			ASharedObject.getInstance().setSound(false);
			this.normalOptions.btnSoundOn.gotoAndStop("off");
			this.normalOptions.btnSoundOff.gotoAndStop("on");
		}
		
		protected function onClickFullScreen(event:MouseEvent):void
		{
			if(stage.displayState == StageDisplayState.NORMAL){
				stage.displayState = StageDisplayState.FULL_SCREEN;
				stage.fullScreenSourceRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
				this.normalOptions.btnFullScreen.gotoAndStop(2);
			}else{
				this.normalOptions.btnFullScreen.gotoAndStop(1);
				stage.displayState = StageDisplayState.NORMAL;
				stage.fullScreenSourceRect = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);
			}
		}
		
		
		protected function onClickConfiguration(event:MouseEvent):void
		{
			this.configurationOptions.visible = true;
			this.normalOptions.visible = false;
			optionStatus = STATE_CONFIGURATION;
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
			if(optionStatus == STATE_NORMAL){
				this.closeFunction();
			}else if(optionStatus == STATE_CONFIGURATION){
				closeConfiguration();
			}
		}
		
		private function closeConfiguration():void
		{
			this.configurationOptions.visible = false;
			this.normalOptions.visible = true;
			optionStatus = STATE_NORMAL;
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