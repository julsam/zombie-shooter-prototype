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
		private var angle:Number;
		
		public var hasCollided:Boolean = false; // if has collide, it don't make any more damage to monsters
		
		public function Bullet(x:Number, y:Number, _direction:Point)
		{
			graphic	= new Image(new BitmapData(2, 2, false, 0xff0000));
			setHitbox(3, 3);
			centerOrigin();
			super(x, y, graphic);

			direction = _direction;

			angle = FP.angle(x, y, direction.x, direction.y);
			
			FP.angleXY(velocity, angle, SPEED * FP.elapsed);
			
			type = "Bullet";
		}
		
		override public function update():void
		{
			x += velocity.x;
			y += velocity.y;
			
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