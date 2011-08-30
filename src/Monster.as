package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import flashx.textLayout.debug.assert;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Monster extends Entity 
	{
		protected var speed:Number;
		protected var health:int;
		
		protected var image:Image;
		protected var sprite:Spritemap;
		
		
		public function Monster(x:int, y:int)
		{
			super(x, y);
			this.x = x;
			this.y = y;
			
			setHitbox(8, 8);
			centerOrigin();
			image = new Image(new BitmapData(8, 8, false, 0xffff00));
			graphic = image;
			
			type = "Monster";
			
			image.centerOO();
		}
		override public function update():void
		{
			var b:Bullet = Bullet(collide("Bullet", x-4, y-4));
			if (b)
			{
				image.color = 0xff0000;
				b.destroy();
				destroy();
			}
			else
			{
				image.color = 0xffff00;
			}
			super.update();
		}
		
		protected function destroy():void
		{
			trace("destroy", this);
			FP.world.remove(this);
		}
		
		protected function takeDamage():void
		{
			health--;
		}
	}
}