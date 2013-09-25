package com.states
{
	import com.greensock.TweenMax;
	import com.hero.HeroActions;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import citrus.input.controllers.Keyboard;

	public class OptionsState extends OptionScreenAsset
	{
		private var closeFunction:Function;
		private var arrayActionKeys:Array = [];
		private var arrayOfKeys:Array = [];
		private var arrayOfActions:Array = [];
		private var keyboard:Keyboard;
		private var actionsDic:Dictionary = new Dictionary();
		private var arrayOfTextFields:Object;
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
			
			fillArrayOfActionObjects();
			
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				if(this.getChildAt(i) is TextField){
					arrayOfTextFields.push(this.getChildAt(i).addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown));
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
			if(event.keyCode){
				event.currentTarget.text = String.fromCharCode(event.charCode).toUpperCase();
			}
			if(event.keyCode == Keyboard.SHIFT){
				event.currentTarget.text = "SHIFT";
			}
			if(event.keyCode == Keyboard.CTRL){
				event.currentTarget.text = "CTRL";
			}
			if(event.keyCode == Keyboard.SPACE){
				event.currentTarget.text = "SPACE";
			}
			if(event.keyCode == Keyboard.ENTER){
				event.currentTarget.text = "ENTER";
			}
			if(event.keyCode == Keyboard.LEFT){
				event.currentTarget.text = "LEFT";
			}
			if(event.keyCode == Keyboard.RIGHT){
				event.currentTarget.text = "RIGHT";
			}
			if(event.keyCode == Keyboard.UP){
				event.currentTarget.text = "UP";
			}
			if(event.keyCode == Keyboard.DOWN){
				event.currentTarget.text = "DOWN";
			}
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
				trace(value, name);
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
			// TODO Auto-generated method stub
			
		}
		
		protected function onClickSound(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			
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