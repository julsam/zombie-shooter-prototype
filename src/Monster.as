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
		protected var dead:Boolean = false;
		
		public function Monster(x:Number, y:Number)
		{
			super(x, y);
			this.x = x;
			this.y = y;
			
			centerOrigin();
			setHitbox(8, 8);
			image = new Image(new BitmapData(8, 8, false, 0xffff00));
			graphic = image;
			image.centerOO();
			
			type = "Monster";			
		}
		override public function update():void
		{
			var b:Bullet = Bullet(collide("Bullet", x-4, y-4));
			if (b)
			{
				this.takeDamage();
				b.destroy();
			}
			else
			{
				image.color = 0xffff00;
			}
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
		
		protected function takeDamage():void
		{			
			image.color = 0xff0000;
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