package entities
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flxpunk.FlxTween;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class BaseMonster extends BaseActor 
	{
		public var flx:FlxTween;
		
		protected var image:Image;
		protected var sprite:Spritemap;
		
		protected var childType:String;
		
		public function BaseMonster(x:Number, y:Number)
		{
			super(x, y);
			
			type = "Monster";			
		}
		override public function update():void
		{			
			super.update();
		}
		
		protected function checkForBullet():void
		{
			// abstract
		}
		
		override protected function takeDamage():void
		{
			health--;
			
			FP.world.add(new EmitterEntity(x, y));
			
			if (health <= 0)
			{
				collidable = false;
				dead = true;
			}
		}
	}
}