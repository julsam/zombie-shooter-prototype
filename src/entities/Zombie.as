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
			
			this.baseline = 10;
			setHitbox(6, 6, 1, 2);
			centerOrigin();
			
			this.sprite = new Spritemap(Assets.MONSTER1, 8, 8);
			this.sprite.add("stand", [0]);
			this.sprite.add("explode", [16, 17, 18, 18, 20], 5, false);
			this.sprite.add("death", [20]);
			this.sprite.play("stand");
			
			this.graphic = this.sprite;
			sprite.centerOO();
			
			this.strength = 10;
			this.runningSpeed = FP.rand(10) + 35;
			this.normalSpeed = FP.rand(10) + 15;
			this.health = 1;
			this.maxHealth = 1;
			this.childType = "Zombie";
		}
		
		override public function update():void
		{
			// if it's dead, on the floor, stand there for a few seconds with death animation
			if (!this.alive && this.sprite.currentAnim == "death")
			{
				this.timer += FP.elapsed;
				
				// TODO queue list that contain entity to remove if too many
				if (this.timer > 10) // total duration before remove()
				{
					this.destroy();
				}
				
				return;
			}
			if (!this.alive)
			{
				this.sprite.play("explode");
			}
			else
			{				
				this.x += this.flx.deltaX;
				this.y += this.flx.deltaY;
				
				this.sprite.play("stand");
			}
			
			if (this.sprite.currentAnim == "explode" && this.sprite.complete)
			{	
				//this.destroy();
				this.sprite.play("death");
			}
			
			this.checkForDamage();
			
			super.update();
		}
		
		override protected function checkForDamage():void
		{
			if (this.alive)
			{
				var b:Bullet = Bullet(collide("Bullet", this.x, this.y));
				if (b && !b.hasCollided)
				{
					this.takeDamage(b.damage);
					b.hasCollided = true;
					b.destroy();
				}
			}
		}
	}
}