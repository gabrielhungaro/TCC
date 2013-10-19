package com.data
{
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;

	public class SoundList
	{
		public static const SOUND_TUTORIAL1_BACKGROUND_NAME:String = "Sound_Background1";
		public static const SOUND_TUTORIAL1_BACKGORUND:Sound_Background1 = new Sound_Background1();
		public static const SOUND_MAIN_MENU_BACKGROUND_NAME:String = "Sound_MainMenu";
		public static const SOUND_MAIN_MENU_BACKGROUND:Sound_MainMenu = new Sound_MainMenu();
		
		public static const SFX_NORMAL_WALK_NAME:String = "Sfx_NormalWalk";
		public static const SFX_NORMAL_WALK:Sfx_NormalWalk = new Sfx_NormalWalk();
		public static const SFX_NORMAL_JUMP_NAME:String = "Sfx_NormalJump";
		public static const SFX_NORMAL_JUMP:Sfx_NormalJump = new Sfx_NormalJump();
		public static const SFX_INVERT_WORLD_NAME:String = "Sfx_InvertWorld";
		public static const SFX_INVERT_WORLD:Sfx_InvertWorld = new Sfx_InvertWorld();
		public static const SFX_REVERT_WORLD_NAME:String = "Sfx_RevertWorld";
		public static const SFX_REVERT_WORLD:Sfx_RevertWorld = new Sfx_RevertWorld();
		public static const SFX_DIE_BY_HOLE_NAME:String = "Sfx_DieByHole";
		public static const SFX_DIE_BY_HOLE:Sfx_DieByHole = new Sfx_DieByHole();
		public static const SFX_DIE_BY_SPIKE_NAME:String = "Sfx_DieBySpike";
		public static const SFX_DIE_BY_SPIKE:Sfx_DieBySpike = new Sfx_DieBySpike();
		public static const SFX_DIE_BY_INSANITY_NAME:String = "Sfx_DieByInsanity";
		public static const SFX_DIE_BY_INSANITY:Sfx_DieByInsanity = new Sfx_DieByInsanity();
		public static const SFX_TURN_ON_FLASHLIGHT_NAME:String = "Sfx_TurnOnFlashlight";
		public static const SFX_TURN_ON_FLASHLIGHT:Sfx_TurnOnFlashlight = new Sfx_TurnOnFlashlight();
		public static const SFX_TURN_OFF_FLASHLIGHT_NAME:String = "Sfx_TurnOffFlashlight";
		public static const SFX_TURN_OFF_FLASHLIGHT:Sfx_TurnOffFlashlight = new Sfx_TurnOffFlashlight();
		public static const SFX_HIGH_FLASHLIGHT_NAME:String = "Sfx_HighFlashlight";
		public static const SFX_HIGH_FLASHLIGHT:Sfx_HighFlashlight = new Sfx_HighFlashlight();
		public static const SFX_BAT_NAME:String = "Sfx_Bat";
		public static const SFX_BAT:Sfx_Bat = new Sfx_Bat();
		
		private static var okToCreate:Boolean = true;
		private static var instance:SoundList; 
		
		public function SoundList()
		{
			if(okToCreate){
				okToCreate = false;
				loadSounds();
			}
		}
		
		public static function getInstance():SoundList
		{
			if(instance == null){
				okToCreate = true;
				instance = new SoundList();
				okToCreate = false;
			}
			return instance;
		}
		
		private function loadSounds():void
		{
			SoundManager.getInstance().addSound(SOUND_TUTORIAL1_BACKGROUND_NAME, { sound:SOUND_TUTORIAL1_BACKGORUND, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.BGM } );
			SoundManager.getInstance().addSound(SOUND_MAIN_MENU_BACKGROUND_NAME, { sound:SOUND_MAIN_MENU_BACKGROUND, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.BGM } );
			
			SoundManager.getInstance().addSound(SFX_NORMAL_WALK_NAME, { sound:SFX_NORMAL_WALK, timesToPlay:0, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_NORMAL_JUMP_NAME, { sound:SFX_NORMAL_JUMP, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_INVERT_WORLD_NAME, { sound:SFX_INVERT_WORLD, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_REVERT_WORLD_NAME, { sound:SFX_REVERT_WORLD, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_DIE_BY_HOLE_NAME, { sound:SFX_DIE_BY_HOLE, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_DIE_BY_INSANITY_NAME, { sound:SFX_DIE_BY_INSANITY, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_DIE_BY_SPIKE_NAME, { sound:SFX_DIE_BY_SPIKE, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_TURN_ON_FLASHLIGHT_NAME, { sound:SFX_TURN_ON_FLASHLIGHT, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_TURN_OFF_FLASHLIGHT_NAME, { sound:SFX_TURN_OFF_FLASHLIGHT, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
			SoundManager.getInstance().addSound(SFX_HIGH_FLASHLIGHT_NAME, { sound:SFX_HIGH_FLASHLIGHT, timesToPlay:1, triggerSoundComplete:true,triggerRepeatComplete:true, group:CitrusSoundGroup.SFX } );
		}
	}
}