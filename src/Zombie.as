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
	
	public class Zombie extends Monster 
	{
		private var timer:Number = 0;
		
		public function Zombie(x:Number, y:Number)
		{
			super(x, y);
			this.x = x;
			this.y = y;
			
			centerOrigin();
			setHitbox(10, 10);
			
			sprite = new Spritemap(Assets.MONSTER1, 8, 8);
			sprite.add("stand", [0]);
			sprite.add("explode", [16, 17, 18, 18, 20], 5, false);
			sprite.add("death", [20]);
			sprite.play("stand");
			
			graphic = sprite;
			sprite.centerOO();
			
			health = 10;
		}
		
		override public function update():void
		{
			// if it's dead, on the floor, stand there for a few seconds with death animation
			if (dead && sprite.currentAnim == "death")
			{
				timer += FP.elapsed;
				
				// TODO queue list that contain entity to remove if too many
				if( timer > 10 ) // total duration before remove()
				{
					FP.world.remove(this);
				}
				
				return;
			}
			if (dead)
			{
				sprite.play("explode");
			}
			else
			{
				sprite.play("stand");
			}
			
			if (sprite.currentAnim == "explode" && sprite.complete)
			{	
				//FP.world.remove(this);
				sprite.play("death");
			}
			super.update();
		}
	}
}