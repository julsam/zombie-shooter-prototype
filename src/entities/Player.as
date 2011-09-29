package entities
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flxpunk.FlxTween;
	
	import utils.Blink;
	import utils.Utils;
	
	public class Player extends BaseActor
	{
		public var currentWeapon:BaseWeapon = null;
		
		public var weaponFireLights:Vector.<Light> = new Vector.<Light>()
		public var weaponFireLight:Light;
		
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
			
			this.health = 250;
			this.maxHealth = 250;
			this.speed = this.normalSpeed = 75;
			this.runningSpeed = 150;
			
			this.type = "Player";
			
			this.sprite.centerOO();
			this.baseline = 10;
			this.setHitbox(6, 8, 3, 2);
			this.graphic = this.sprite;
			
			this.flx = new FlxTween(this);
			addTween(this.flx, true);
		}
		
		override public function update():void
		{
			// Shoot
			if (Input.mousePressed || Input.check("Shoot"))
			{
				SoundMgr.playSound(SoundMgr.sfx_pistol_shot);
				trace(x, y, this.flx.getMidpoint());
				FP.world.add(new Bullet(x, y, new Point(FP.world.mouseX, FP.world.mouseY)));
				
				// firelight, TODO: it should be in weapon class
				if (G.lightingEnabled)
				{
					weaponFireLights.push(new Light(x, y, 1.5, 1));
					G.lighting.addLight(weaponFireLights[weaponFireLights.length-1]);
					
					var v:VarTween = new VarTween(removeFireLight, Tween.ONESHOT);
					v.tween(weaponFireLights[weaponFireLights.length-1], "scale", 0, 0.25, Ease.sineInOut);
					FP.world.addTween(v, true);
				}
			}
			
			var l:int = weaponFireLights.length;
			if (l > 0)
			{
				for (var i:int = 0; i < l; i++)
				{
					weaponFireLights[i].x = G.player.x;
					weaponFireLights[i].y = G.player.y;
				}
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
			
			this.angle = FP.angle(this.x, this.y, FP.world.mouseX, FP.world.mouseY);
			
			this.updateAnimation();
			
			this.blink.update();
			
			super.update();
		}
		
		// TODO: should be in weapon class too
		public function removeFireLight():void
		{
			G.lighting.removeLight(weaponFireLights[0]);
			weaponFireLights.splice(0, 1);
		}
		
		override public function takeDamage(amountOfDamage:int):void
		{
			if (!this.blink.active)
			{
				this.blink.setActive();
				trace('Getting hurt!');
				if (!this.invincible)
				{
					super.takeDamage(amountOfDamage);
					var percentRemaining:Number = this.health / this.maxHealth * 100;
					G.hud.healthBar.setHealth(percentRemaining);
				}
			}
		}
		
		protected function updateAnimation():void
		{
			var dirAnim:String;
			if (this.angle >= 225 && this.angle <= 315)
			{
				dirAnim = "Down";
			}
			if (this.angle >= 315 || this.angle <= 45)
			{
				dirAnim = "Right";
			}
			if (this.angle >= 45 && this.angle <= 135)
			{
				dirAnim = "Up";
			}
			if (this.angle >= 135 && this.angle <= 225)
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