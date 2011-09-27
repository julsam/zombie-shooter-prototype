package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	
	public class Bullet extends Entity
	{
		private const SPEED:Number = 400;
		private var direction:Point = new Point();
		private var velocity:Point = new Point;
		private var speed:Point = new Point(SPEED, SPEED);
		private var angle:Number;
		
		public var hasCollided:Boolean = false; // if has collide, it don't make any more damage to monsters
		
		public function Bullet(x:Number, y:Number, _direction:Point)
		{
			var img:Image = new Image(new BitmapData(2, 2, false, 0xff0000));
			graphic = img;
			setHitbox(4, 4, 1, 1);
			centerOrigin();
			img.centerOO();
			super(x, y, graphic);

			direction = _direction;
			angle = FP.angle(x, y, direction.x, direction.y);			
			
			type = "Bullet";
		}
		
		override public function update():void
		{
			FP.angleXY(velocity, angle, SPEED * FP.elapsed);
			
			//x += speed.x * FP.elapsed * velocity.x;
			//y += speed.y * FP.elapsed * velocity.y;
			
			moveBy(velocity.x, velocity.y);
			
			// if Bullet goes out of the game // TODO: if out of the screen
			if (x > G.windowWidth + 100	|| y > G.windowHeight + 100 
				|| x < -100 || y < -100)
			{
				destroy();
			}
			
			if (collide("Solid", x, y))
			{
				destroy();
			}
			
			super.update();
		}
				
		public function destroy():void
		{
			trace("destroy", this);
			this.hasCollided = true;
			FP.world.remove(this);
		}
	}
}