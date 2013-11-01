package com.hero
{
	import flash.display.Sprite;
	
	public class Shadow extends Sprite
	{
		private var asset:ShadowAsset;
		private var hero:MyHero;
		public function Shadow()
		{
			super();
			asset = new ShadowAsset();
			this.addChild(asset);
			
		}
		
		public function init():void
		{
			/*if(isInverted){
				this.x = _camPoint.x - hero.x;
				this.y = _camPoint.y - hero.y;
			}else{*/
				this.x = hero.x - hero.width/2 - hero.getCamPos().x;
				this.y = hero.y - hero.height/2 - hero.getCamPos().y;
			//}
		}
		
		/*public function setAsset(value:MovieClip):void
		{
			asset = value;
			//this.addChild(asset);
		}*/
		
		
		public function update(insanity:int, insanityLimit:int):void
		{
			/*this.x = hero.x - hero.width/2 - hero.getCamPos().x;
			this.y = hero.y - hero.height/2 - hero.getCamPos().y;*/
			var currentFrame:int = (this.asset.totalFrames * insanity) / insanityLimit;
			//trace("[ SHADOW ] - CURRENTFRAME: " + currentFrame);
			this.asset.gotoAndStop(currentFrame);
		}
		
		public function setHero(value:MyHero):void
		{
			hero = value;
		}
	}
}