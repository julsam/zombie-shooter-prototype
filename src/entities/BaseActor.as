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
	
	public class BaseActor extends Entity
	{
		public var pathActor:FlxPath;
		
		protected var speed:Number;
		protected var health:int;
		protected var dead:Boolean = false;		
		protected var invincible:Boolean = false;
		
		protected var blink:Blink;
		
		public function BaseActor(x:Number=0, y:Number=0)
		{
			super(x, y);	
		}
		override public function update():void
		{			
			super.update();
			
			updateDepth();
		}
		
		protected function updateDepth():void
		{
			layer = -y - height;
		}
		
		protected function destroy():void
		{
			trace("destroy", this);
			FP.world.remove(this);
		}
		
		protected function checkForDamage():void
		{
			// abtract
		}
		
		protected function takeDamage():void
		{
			// abtract
		}
	}
}