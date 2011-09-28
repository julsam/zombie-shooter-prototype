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
	import net.flxpunk.FlxPath;
	import net.flxpunk.FlxPathFinding;
	import net.flxpunk.FlxTween;
	
	public class BaseMonster extends BaseActor
	{
		protected var timerFindPath:Number = 0;
		protected var lastEyesightTarget:Point;
		protected var target:Point = new Point;
		protected var targetEntity:*;
		
		protected var image:Image;
		protected var sprite:Spritemap;
		
		protected var MonsterID:int; // unique ID
		protected var childType:String;
		protected var stunned:Number; // the amount of time the entity is stunned		
		
		public function BaseMonster(x:Number, y:Number)
		{
			super(x, y);
			lastEyesightTarget = new Point(x, y);
			
			this.flx = new FlxTween(this);
			addTween(this.flx, true);
			
			// without this 2 params the entity behaviour 
			// is completely fucked when it have no more
			// nodes in his path (it reached his target)
			this.flx.drag.x = 400;
			this.flx.drag.y = 400;
			
			this.type = "Monster";
		}
		
		override public function update():void
		{
			if (this.alive)
			{
				updateRayPath();
			}
			super.update();
		}
		
		public function updatePath():void
		{
			var path:FlxPath;
			path = G.level.pathFinding.findPath(this.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
			if (path != null)
			{
				this.flx.followPath(path, this.speed);
			}			
		}
		
		public function updateTimedPath():void
		{
			this.timerFindPath += FP.elapsed;
			if (this.timerFindPath > 0.5) // total duration before remove()
			{
				var path:FlxPath;
				path = G.level.pathFinding.findPath(this.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
				if (path != null)
				{
					this.flx.followPath(path, this.speed);
				}
				this.timerFindPath = 0;
			}
		}
		
		public function updateRayPath():void
		{
			// TODO:check if player position changed since last Ray
			if (G.level.pathFinding.ray(this.flx.getMidpoint(), G.player.flx.getMidpoint(), null, 1))
			{
				target = new Point(G.player.flx.getMidpoint().x, G.player.flx.getMidpoint().y);
				targetEntity = G.player;
				moveToPoint(G.player.flx.getMidpoint());
				lastEyesightTarget = G.player.flx.getMidpoint();
			}
			else
			{
				target = new Point(lastEyesightTarget.x + this.width * 0.5, lastEyesightTarget.y + this.height * 0.5);
				targetEntity = null;
				moveToPoint(target);
			}
		}
		
		public function moveToPoint(p:Point):void
		{
			var _x:int = this.flx.getMidpoint().x;
			var _y:int = this.flx.getMidpoint().y;
			this.angle = FP.angle(_x, _y, int(p.x), int(p.y));
			FP.angleXY(velocity, angle, this.speed * FP.elapsed);				
			updateCollision();
			if (this.targetReached())
			{
				if (this.targetEntity != null)
				{
					this.targetEntity.takeDamage(this.strength);
				}
			}
		}
		
		public function targetReached():Boolean
		{
			var _x:int = this.flx.getMidpoint().x;
			var _y:int = this.flx.getMidpoint().y;
			
			// distance before we start checking
			var distance:Number = FP.distance(_x, _y, int( this.target.x), int( this.target.y));
			if (distance > 16)
			{
				return false
			}
			else
			{
				if (this.targetEntity is Player && this.collideWith(this.targetEntity, this.x, this.y))
					return true;
				else if (this.targetEntity == null && this.collidePoint(_x, _y, this.target.x, this.target.y))
					return true;
				else
					return false
			}
		}
		
		protected function updateCollision():void
		{
			this.x += this.velocity.x;
			
			// monster
			var e:Entity = this.collide("Monster", this.x, this.y) as Entity;
			if (e)
			{
				if (this.x + this.width > e.x + e.width && !collide("Solid", this.x + 1, this.y))
				{
					this.x += 1;
				}
				else if (this.x + this.width < e.x + e.width && !collide("Solid", this.x - 1, this.y))
				{
					this.x -= 1;
				}
			}
			// wall
			if (this.collide("Solid", this.x, this.y))
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
			
			// monster
			e = null;
			e = this.collide("Monster", this.x, this.y) as Entity;			
			if (e)
			{
				if (this.y + this.height > e.y + e.height && !collide("Solid", this.x, this.y + 1))
				{
					this.y += 1;
				}
				else if (this.y + this.height < e.y + e.height && !collide("Solid", this.x, this.y - 1))
				{
					this.y -= 1;
				}
			}
			// wall
			if (this.collide("Solid", this.x, this.y))
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
		
		override public function takeDamage(amountOfDamage:int=0):void
		{
			this.health--;
			
			FP.world.add(new Explosion(this.x, this.y));
			
			if (health <= 0)
			{
				this.collidable = false;
				this.alive = false;
			}
		}
		
		override protected function destroy():void
		{
			Game2.removeMonsterFromPathList(this);
			super.destroy();
		}
		
		public function dropSouls():void
		{
			// TODO
		}
	}
}