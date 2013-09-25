package com.hero
{
	import flash.utils.Dictionary;
	
	import citrus.input.controllers.Keyboard;

	public class HeroActions
	{
		public static var LEFT:String = "left";
		public static var RIGHT:String = "right";
		public static var JUMP:String = "jump";
		public static var INVERT:String = "invert";
		public static var ACTION:String = "action";
		public static var HIGH_FLASHLIGHT:String = "camera";
		public static var FLASHLIGHT:String = "flashlight";
		public static var BACKPACK:String = "backpack";
		
		public static var LEFT_KEY:int = Keyboard.A;
		public static var RIGHT_KEY:int = Keyboard.D;
		public static var JUMP_KEY:int = Keyboard.SPACE;
		public static var INVERT_KEY:int = Keyboard.Z;
		public static var ACTION_KEY:int = Keyboard.E;
		public static var HIGH_FLASHLIGHT_KEY:int = Keyboard.X;
		public static var FLASHLIGHT_KEY:int = Keyboard.SHIFT;
		public static var BACKPACK_KEY:int = Keyboard.P;
		
		public static var actionsDic:Dictionary;
		
		public static const ArrayOfAction:Array = [LEFT, RIGHT, JUMP, INVERT, ACTION, HIGH_FLASHLIGHT, FLASHLIGHT, BACKPACK];
		public static const ArrayOfActionKeys:Array = [LEFT_KEY, RIGHT_KEY, JUMP_KEY, INVERT_KEY, ACTION_KEY, HIGH_FLASHLIGHT_KEY, FLASHLIGHT_KEY, BACKPACK_KEY];
		
		public function HeroActions()
		{
			
		}
		
		public static function setActionDictionaries():void
		{
			actionsDic[LEFT] = LEFT_KEY;
			actionsDic[RIGHT] = RIGHT_KEY;
			actionsDic[JUMP] = JUMP_KEY;
			actionsDic[INVERT] = INVERT_KEY;
			actionsDic[ACTION] = ACTION_KEY;
			actionsDic[HIGH_FLASHLIGHT] = HIGH_FLASHLIGHT_KEY;
			actionsDic[FLASHLIGHT] = FLASHLIGHT_KEY;
			actionsDic[BACKPACK] = BACKPACK_KEY;
		}
	}
}