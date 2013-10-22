package com.states
{
	import com.data.SoundList;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import away3d.events.LoaderEvent;
	
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
		
		protected function addLoadingScreen(imageURL:String):void
		{
			/*var loader:Loader = new Loader();
			loader.load(new URLRequest("../levels/Levels.swf"));
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoadImage);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);*/
			//addChild(loader);
			
			loadingScreen = new LoadingScreenAsset();
			this.addChild(loadingScreen);
		}
		
		protected function progressHandler(event:ProgressEvent):void
		{
			trace("bnuibilbib" + event.bytesLoaded);
		}
		
		protected function onCompleteLoadImage(event:Event):void
		{
			trace("COMPLETEIIIIII");
			removeLoadingScreen();
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