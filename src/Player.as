package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import flashx.textLayout.debug.assert;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity 
	{
		private var vector:Point;
		private var velocity:Point = new Point();
		
		private var SPEED:Number = 100; 
		private var FRICTION:int = 250; 
		private var MAXSPEED:int = 125; 
		
		private var image:Image;
		
		public function Player(x:int=100, y:int=100)
		{
			this.x = x;
			this.y = y;
			vector = new Point(0, 0);
			graphic	= new Image(Assets.PLAYER);
			setHitbox(28, 28, 14, 14);
			
			type = "Player";
			
			image = (this.graphic as Image);
			image.centerOrigin();
		}
		override public function update():void
		{
			// Shoot
			if(Input.mousePressed)
			{
				FP.world.add(new Bullet(x, y, new Point(Input.mouseX, Input.mouseY)));
			}
			// Run
			if(Input.check("Run"))
			{
				SPEED = 200;
			}
			else
			{
				SPEED = 100;
			}
			
			updateMovement();
			updateCollision();			
			
			//image.angle = FP.angle(this.x + (image.width / 2), this.y + (image.height / 2), Input.mouseX, Input.mouseY);
			// because of centerOrigin() x, y is the new center of the image
			image.angle = FP.angle(this.x, this.y, Input.mouseX, Input.mouseY);
		}
		
		
		private function updateMovement():void
		{
			var movement:Point = new Point;
			
			if (Input.check("Up")) movement.y--;
			if (Input.check("Down")) movement.y++;
			if (Input.check("Left")) movement.x--;
			if (Input.check("Right")) movement.x++;
			
			
			vector.x = SPEED * G.FIXED_FRAME_TIME * movement.x;
			vector.y = SPEED * G.FIXED_FRAME_TIME * movement.y;
		}
		
		private function updateCollision():void
		{
			x += vector.x;
			
			if (collide("Solid", x + vector.x, y + vector.y))
			{				
				if (FP.sign(vector.x) > 0)
				{
					x -= vector.x;
				}
				else
				{
					x -= vector.x;
				}
			}
			
			y += vector.y;
			
			if (collide("Solid", x + vector.x, y + vector.y))
			{				
				if (FP.sign(vector.y) > 0)
				{
					y -= vector.y;
				}
				else
				{
					y -= vector.y;
				}
			}			
		}
		
		
		/*
		override public function update():void
		{
		var acceleration:Point = new Point();
		var movedX:Boolean = false;
		var movedY:Boolean = false;
		
		// Shoot
		if(Input.mousePressed)
		{
		FP.world.add(new Bullet(x, y, new Point(Input.mouseX, Input.mouseY)));
		}
		
		// Movements
		if(Input.check("Up")) 
		{
		acceleration.y -= SPEED;
		movedY = true;
		}
		if(Input.check("Down"))
		{
		acceleration.y += SPEED;
		movedY = true;			
		}
		if(Input.check("Left"))
		{
		acceleration.x -= SPEED;
		movedX = true;		
		}
		if(Input.check("Right"))
		{
		acceleration.x += SPEED;
		movedX = true;
		}
		
		// Run
		if(Input.check("Run"))
		{
		MAXSPEED = 250;
		}
		else
		{
		MAXSPEED = 125;
		}
		
		trace("x: "+Math.abs(acceleration.x) + ", y:" + Math.abs(acceleration.x) );
		
		// Apply movement to velocity
		velocity.x += acceleration.x * G.FIXED_FRAME_TIME;
		velocity.y += acceleration.y * G.FIXED_FRAME_TIME;
		
		if(!movedX)
		{
		if(Math.abs(velocity.x) > 1)
		{
		velocity.x = FP.approach(velocity.x, 0, FRICTION * G.FIXED_FRAME_TIME);
		}
		}
		if(!movedY)
		{
		if(Math.abs(velocity.y) > 1)
		{
		velocity.y = FP.approach(velocity.y, 0, FRICTION * G.FIXED_FRAME_TIME);
		}
		}
		
		// Max Speed
		if (Math.abs(velocity.x) > MAXSPEED)
		{
		velocity.x = FP.sign(velocity.x) * MAXSPEED;
		}
		if (Math.abs(velocity.y) > MAXSPEED)
		{
		velocity.y = FP.sign(velocity.y) * MAXSPEED;
		}
		
		// apply velocity to position
		position.x += velocity.x * G.FIXED_FRAME_TIME;
		position.y += velocity.y * G.FIXED_FRAME_TIME;
		
		
		x = position.x;
		y = position.y;
		
		//updateMovement();
		//updateCollision();
		super.update();
		}
		*/
	}
}