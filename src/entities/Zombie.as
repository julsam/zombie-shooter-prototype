package entities
{
	import utils.*;
	
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
	
	public class Zombie extends BaseMonster
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
			//sprite.centerOO();
			
			speed = FP.rand(10) + 55 ;
			health = 10;
			childType = "Zombie";
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
					this.destroy();
				}
				
				return;
			}
			if (dead)
			{
				sprite.play("explode");
			}
			else
			{				
				x += flx.deltaX;
				y += flx.deltaY;
				
				sprite.play("stand");
			}
			
			if (sprite.currentAnim == "explode" && sprite.complete)
			{	
				//this.destroy();
				sprite.play("death");
			}
			
			checkForDamage();
			
			super.update();
		}
		
		override protected function checkForDamage():void
		{
			var b:Bullet = Bullet(collide("Bullet", x-4, y-4));
			if (b && !b.hasCollided)
			{
				this.takeDamage();
				b.hasCollided = true;
				b.destroy();
			}
		}
	}
}