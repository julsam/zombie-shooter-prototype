package entities
{
	import utils.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import net.flxpunk.FlxPath;
	import net.flxpunk.FlxTween;
	
	public class BaseActor extends Entity
	{
		public var flx:FlxTween;               // flixel movement and path movement controller
		public var pathActor:FlxPath;
		protected var blink:Blink;
		
		protected var insideOfRoomID:int;
		
		// attributes
		protected var speed:Number;
		protected var normalSpeed:Number;
		protected var health:int;
		protected var maxHealth:int;
		protected var mana:int;
		protected var maxMana:int;
		protected var strength:int;
		protected var weapon:BaseWeapon = null;
		
		// state
		protected var alive:Boolean = true;
		protected var invincible:Boolean = false;
		protected var burning:Boolean = false;
		
		public var rotation:Number;
		protected var velocity:Point = new Point();
		protected var baseline:int; // used for depth
		
		public function BaseActor(x:Number=0, y:Number=0)
		{
			super(x, y);
		}
		override public function update():void
		{
			super.update();
			
			this.updateDepth();
		}
		
		protected function updateDepth():void
		{
			this.layer = -this.y -this.baseline;
		}
		
		protected function destroy():void
		{
			trace("destroy", this);
			FP.world.remove(this);
		}
		
		protected function checkForDamage():void
		{
			// Abtract
		}
		
		protected function takeDamage(amountOfDamage:int=0):void
		{
			// Abtract
		}
		
		protected function attack(actor:BaseActor):void
		{
			// Abtract
		}
		
		public function getInBlockCoords():Point
		{
			// TODO
			return new Point();
		}
	}
}