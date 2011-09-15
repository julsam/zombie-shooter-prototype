package entities
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flxpunk.FlxTween;
	
	import utils.Blink;
	
	public class Player extends BaseActor
	{
		public var flx:FlxTween;               // flixel movement and path movement controller
		
		private var vector:Point;
		
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
			
			blink = new Blink(sprite, 2, 0.15);
			
			baseline = 10;
			setHitbox(6, 8, 3, 2);
			graphic	= sprite;
			
			type = "Player";
			
			sprite.centerOO();
			
			flx = new FlxTween(this);
			addTween(flx, true);
		}
		
		override public function update():void
		{
			// Shoot
			if(Input.mousePressed || Input.check("Shoot"))
			{
				SoundMgr.playSound(SoundMgr.sfx_pistol_shot);
				FP.world.add(new Bullet(x, y, new Point(FP.world.mouseX, FP.world.mouseY)));
			}
			
			// Run
			if(Input.check("Run"))
			{
				SoundMgr.playSound(SoundMgr.sfx_miss_hit);
				speed = RSPEED; // run speed
			}
			else
			{
				speed = NSPEED; // normal speed
			}
			
			updateMovement();
			updateCollision();			
			
			rotation = FP.angle(this.x, this.y, FP.world.mouseX, FP.world.mouseY);
			
			var dirAnim:String;
			if (rotation >= 225 && rotation <= 315)
			{
				dirAnim = "Down";
			}
			if (rotation >= 315 || rotation <= 45)
			{
				dirAnim = "Right";
			}
			if (rotation >= 45 && rotation <= 135)
			{
				dirAnim = "Up";
			}
			if (rotation >= 135 && rotation <= 225)
			{
				dirAnim = "Left";
			}
			
			if (Input.check("Up") || Input.check("Down") || Input.check("Left") || Input.check("Right"))
			{
				dirAnim = "walk"+dirAnim;
			}
			else
			{
				dirAnim = "stand"+dirAnim;
			}
			
			sprite.play(dirAnim);
			
			checkForDamage();
			
			super.update();
		}
		
		override protected function checkForDamage():void
		{
			blink.update();
			
			var e:Entity = FP.world.nearestToEntity("Monster", this, true);
			if (e)
			{
				if (!this.blink.active && this.collideWith(e, this.x, this.y))
				{
					blink.setActive();
					trace('COLLIDE!');
				}
			}
		}
		
		protected function updateMovement():void
		{
			var movement:Point = new Point;
			
			if (Input.check("Up")) movement.y--;
			if (Input.check("Down")) movement.y++;
			if (Input.check("Left")) movement.x--;
			if (Input.check("Right")) movement.x++;
			
			
			vector.x = speed * FP.elapsed * movement.x;
			vector.y = speed * FP.elapsed * movement.y;
		}
		
		protected function updateCollision():void
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