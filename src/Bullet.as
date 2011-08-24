package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Bullet extends Entity
	{
		private const SPEED:Number = 650; 
		private var direction:Point = new Point();
		private var velocity:Point = new Point;
		private var angle:Number;
		
		public function Bullet(x:Number, y:Number, _direction:Point)
		{
			graphic	= new Image(new BitmapData(3, 3, false, 0x0000ff));
			super(x, y, graphic);
			
			direction = _direction;			
						
			angle = FP.angle(x, y, direction.x, direction.y);
			
			FP.angleXY(velocity, angle, G.FIXED_FRAME_TIME * SPEED);
		}
		
		override public function update():void
		{
			x += velocity.x;
			y += velocity.y;
			
			// if Bullet goes out of the game
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
			FP.world.remove(this);
		}
	}
}