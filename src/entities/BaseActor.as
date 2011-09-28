package entities
{
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
	
	import utils.*;
	
	public class BaseActor extends Entity
	{
		public var flx:FlxTween;               // flixel movement and path movement controller
		public var pathActor:FlxPath;
		public var currentCoords:Point = new Point;
		public var coordsJustChanged:Boolean = false;
		protected var blink:Blink;
		
		protected var insideOfRoomID:int;
		
		// attributes
		protected var speed:Number;
		protected var normalSpeed:Number;
		protected var health:int = 1;
		protected var maxHealth:int = 1;
		protected var mana:int;
		protected var maxMana:int;
		protected var strength:int;
		protected var weapon:BaseWeapon = null;
		
		// state
		protected var alive:Boolean = true;
		protected var invincible:Boolean = false;
		protected var burning:Boolean = false;
		
		public var angle:Number = 0;
		protected var velocity:Point = new Point();
		protected var baseline:int; // used for depth
		
		public function BaseActor(x:Number=0, y:Number=0)
		{
			super(x, y);
		}
		override public function update():void
		{
			var c:Point = this.getInBlockCoords();
			if (c.x != currentCoords.x || c.y != currentCoords.y)
			{
				//trace("current : ", this.currentCoords);
				this.coordsJustChanged = true;
				this.currentCoords = this.getInBlockCoords();
			}
			else
			{
				this.coordsJustChanged = false;
			}
			
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
		
		public function takeDamage(amountOfDamage:int):void
		{
			this.health = this.health - amountOfDamage < 0 ? 0 : this.health - amountOfDamage;
		}
		
		public function heal(amountOfLife:int=0):void
		{
			this.health = this.health + amountOfLife > this.maxHealth ? this.maxHealth : this.health + amountOfLife;
		}
		
		public function attack(actor:BaseActor):void
		{
			// Abtract
		}
		
		public function getInBlockCoords():Point
		{
			return new Point(int(this.x / G.grid), int(this.y / G.grid));
		}
	}
}