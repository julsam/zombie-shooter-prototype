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
		public var currentWeapon:BaseWeapon = null;
		public var runningSpeed:Number;
		
		public var sprite:Spritemap;
		
		public function Player(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			this.velocity = new Point(0, 0);
			
			this.sprite = new Spritemap(Assets.PLAYER, 11, 16);
			this.sprite.add("standDown", [0]);
			this.sprite.add("standRight", [8]);
			this.sprite.add("standUp", [6]);
			this.sprite.add("standLeft", [10]);
			this.sprite.add("walkDown", [4, 0, 5, 0], 7, true);
			this.sprite.add("walkUp", [6, 1, 7, 1], 7, true);
			this.sprite.add("walkRight", [8, 2, 9, 2], 7, true);
			this.sprite.add("walkLeft", [10, 3, 11, 3], 7, true);
			this.sprite.play("standDown");
			
			this.blink = new Blink(this.sprite, 2, 0.15);
			
			this.speed = this.normalSpeed = 100;
			this.runningSpeed = 150;
			this.baseline = 10;
			this.setHitbox(6, 8, 3, 2);
			this.graphic = this.sprite;
			
			this.type = "Player";
			
			this.sprite.centerOO();
			
			this.flx = new FlxTween(this);
			addTween(this.flx, true);
		}
		
		override public function update():void
		{
			// Shoot
			if (Input.mousePressed || Input.check("Shoot"))
			{
				SoundMgr.playSound(SoundMgr.sfx_pistol_shot);
				FP.world.add(new Bullet(x, y, new Point(FP.world.mouseX, FP.world.mouseY)));
			}
			
			// Run
			if (Input.check("Run"))
			{
				this.speed = this.runningSpeed;
			}
			else
			{
				this.speed = this.normalSpeed;
			}
			
			this.updateMovement();
			this.updateCollision();			
			
			this.rotation = FP.angle(this.x, this.y, FP.world.mouseX, FP.world.mouseY);
			
			this.updateAnimation();
			
			this.checkForDamage();
			
			super.update();
		}
		
		override protected function checkForDamage():void
		{
			this.blink.update();
			
			var e:Entity = FP.world.nearestToEntity("Monster", this, true);
			if (e)
			{
				if (!this.blink.active && this.collideWith(e, this.x, this.y))
				{
					this.blink.setActive();
					trace('Getting hurt!');
				}
			}
		}
		
		protected function updateAnimation():void
		{
			var dirAnim:String;
			if (this.rotation >= 225 && this.rotation <= 315)
			{
				dirAnim = "Down";
			}
			if (this.rotation >= 315 || this.rotation <= 45)
			{
				dirAnim = "Right";
			}
			if (this.rotation >= 45 && this.rotation <= 135)
			{
				dirAnim = "Up";
			}
			if (this.rotation >= 135 && this.rotation <= 225)
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
			
			this.sprite.play(dirAnim);
		}
		
		protected function updateMovement():void
		{
			var movement:Point = new Point;
			
			if (Input.check("Up")) movement.y--;
			if (Input.check("Down")) movement.y++;
			if (Input.check("Left")) movement.x--;
			if (Input.check("Right")) movement.x++;
			
			
			this.velocity.x = this.speed * FP.elapsed * movement.x;
			this.velocity.y = this.speed * FP.elapsed * movement.y;
		}
		
		protected function updateCollision():void
		{
			this.x += this.velocity.x;
			
			if (collide("Solid", this.x + this.velocity.x, this.y))
			{
				if (FP.sign(this.velocity.x) > 0)
				{
					this.x += -this.velocity.x;
				}
				else
				{
					this.x -= this.velocity.x;
				}
			}
			
			this.y += this.velocity.y;
			
			if (collide("Solid", this.x, this.y + this.velocity.y))
			{
				if (FP.sign(this.velocity.y) > 0)
				{
					this.y += -this.velocity.y;
				}
				else
				{
					this.y -= this.velocity.y;
				}
			}			
		}
	}
}