package com.levels
{
	import flash.geom.Point;

	public interface ILevel
	{
		function initialize():void
		function addBackground(imageName:String = "", imageURL:String = ""):void
		function setUpCamera():void
		function createHero():void
		function update(timeDelta:Number):void
		function invertAll():void
		function getTicks():int
		function getSeconds():int
		function getMinutes():int
		function getCamPos():Point
		function updateInsanityBackground(insanityAlpha:Number):void
	}
}