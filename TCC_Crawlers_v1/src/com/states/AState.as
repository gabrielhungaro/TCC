package com.states
{
	import com.data.SoundList;
	
	import citrus.core.State;
	
	import org.osflash.signals.Signal;
	
	public class AState extends State
	{
		public var lvlEnded:Signal;
		public var restartLevel:Signal;
		private var loadingScreen:LoadingScreenAsset;
		
		public function AState()
		{
			super();
			lvlEnded = new Signal();
			restartLevel = new Signal();
			loadSounds();
		}
		
		protected function addLoadingScreen():void
		{
			loadingScreen = new LoadingScreenAsset();
			this.addChild(loadingScreen);
		}
		
		protected function removeLoadingScreen():void
		{
			if(loadingScreen){
				if(this.contains(loadingScreen)){
					this.removeChild(loadingScreen);
					loadingScreen = null;
				}
			}
		}
		
		protected function loadSounds():void
		{
			SoundList.getInstance();
		}
	}
}