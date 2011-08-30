package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import flashx.textLayout.debug.assert;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Player extends Entity 
	{
		private var vector:Point;
		private var velocity:Point = new Point();
		private var speed:Number;
		
		private const NSPEED:Number = 100;
		private const RSPEED:Number = 200;
		private var FRICTION:int = 250;
		private var MAXSPEED:int = 125;
		
		public var sprite:Spritemap;
		
		public function Player(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			vector = new Point(0, 0);
			
			sprite = new Spritemap(Assets.PLAYER, 11, 16);
			sprite.add("standDown", [0]);
			sprite.add("standRight", [8]);
			sprite.add("standUp", [6]);
			sprite.add("standLeft", [10]);
			sprite.add("walkDown", [4, 0, 5, 0], 7, true);
			sprite.add("walkUp", [6, 1, 7, 1], 7, true);
			sprite.add("walkRight", [8, 2, 9, 2], 7, true);
			sprite.add("walkLeft", [10, 3, 11, 3], 7, true);
			sprite.play("standDown");
			
			setHitbox(6, 8, 3, 2);
			graphic	= sprite;
			
			type = "Player";			
			
			sprite.centerOO();
		}
		override public function update():void
		{
			// Shoot
			if(Input.mousePressed || Input.check("Shoot"))
			{
				FP.world.add(new Bullet(x, y, new Point(FP.world.mouseX, FP.world.mouseY)));
			}
			
			// Run
			if(Input.check("Run"))
			{
				speed = RSPEED; // run speed
			}
			else
			{
				speed = NSPEED; // normal speed
			}
			
			updateMovement();
			updateCollision();			
						
			var axe:Number = FP.angle(this.x, this.y, FP.world.mouseX, FP.world.mouseY);
			
			var dirAnim:String;
			if (axe >= 225 && axe <= 315)
			{
				dirAnim = "Down";
			}
			if (axe >= 315 || axe <= 45)
			{
				dirAnim = "Right";
			}
			if (axe >= 45 && axe <= 135)
			{
				dirAnim = "Up";
			}
			if (axe >= 135 && axe <= 225)
			{
				dirAnim = "Left";
			}
			
			if (Input.check("Up") || Input.check("Down") || Input.check("Left") || Input.check("Right"))
				dirAnim = "walk"+dirAnim;
			else
				dirAnim = "stand"+dirAnim;
			sprite.play(dirAnim);
		}
		
		
		private function updateMovement():void
		{
			var movement:Point = new Point;
			
			if (Input.check("Up")) movement.y--;
			if (Input.check("Down")) movement.y++;
			if (Input.check("Left")) movement.x--;
			if (Input.check("Right")) movement.x++;
			
			
			vector.x = speed * G.FIXED_FRAME_TIME * movement.x;
			vector.y = speed * G.FIXED_FRAME_TIME * movement.y;
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
	}
}