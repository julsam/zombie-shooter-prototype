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
		static public const RANDOMWALK:int = 0;          // aimless walk, when target reached && targetEntity == null
		static public const FOLLOWTARGET:int = 1;        // hunt target, when targetEntity != null
		static public const GOTOLASTEYESIGHT:int = 2;    // reach target, when target != null && targetEntity == null
		static public const GOTOPOSITION:int = 3;        // go to a position, without worrying about things around
		protected var behavior:int = RANDOMWALK;
		
		protected var timerFindPath:Number = 0;
		protected var destination:* = new Point;    // position
		protected var currentTarget:*;                   // entity
		protected var targetEntity:*;                   // the kind of target to... target
		public    var targetVisibility:Boolean = false;	// if the target is visible, updated each frame
		
		protected var image:Image;
		protected var sprite:Spritemap;
		
		protected var MonsterID:int; // unique ID
		protected var childType:String;	
		
		public function BaseMonster(x:Number, y:Number)
		{
			super(x, y);
			this.destination = new Point(x, y);
			
			this.flx = new FlxTween(this);
			this.addTween(this.flx, true);
			
			// without this 2 params the entity behaviour 
			// is completely fucked when it have no more
			// nodes in his path (it reached his target)
			this.flx.drag.x = 400;
			this.flx.drag.y = 400;
			
			this.type = "Monster";
		}
		
		override public function update():void
		{
			// TODO
			// if not onScreen + ~100:
			//     this.visible = false;
			//     this.collidable = false;
			//     return;
			// if very far, remove this;
			
			if (this.alive)
			{
				this.targetVisibility = this.isTargetVisible();
				
				// target is visible
				if (this.targetVisibility == true)
				{
					this.behavior = FOLLOWTARGET;
					this.speed = this.runningSpeed;
					this.currentTarget = G.player;
					this.destination = G.player.flx.getMidpoint();
					this.moveToPoint(this.destination);
					if (this.targetReached())
					{
						this.attack(this.currentTarget);
					}
				}
				// target not visible but moving along path to the last place it saw it
				else if (this.destination != null)
				{
					this.behavior = GOTOLASTEYESIGHT;
					this.speed = this.runningSpeed;
					this.currentTarget = null;
					this.moveToPoint(this.destination);
					if (this.targetReached())
					{
						this.destination = null;
					}
				}
				// walking around
				else if (this.destination == null)
				{
					this.behavior = RANDOMWALK;
					this.speed = this.normalSpeed;
					this.randomWalk();
				}
			}
			super.update();
		}
		
		// CPU intensive, do not use it too much
		public function isTargetVisible():Boolean
		{
			// TODO : could be cool to check orientation of the entity
			// and activate only if it's in his view area
			return G.level.pathFinding.ray(this.flx.getMidpoint(), G.player.flx.getMidpoint(), null, 1);
		}
		
		public function targetReached():Boolean
		{
			var _x:int = this.flx.getMidpoint().x;
			var _y:int = this.flx.getMidpoint().y;
			
			// distance before we start checking
			var minimalDistance:Number = 16;
			var distance:Number = FP.distance(_x, _y, int( this.destination.x), int( this.destination.y));
			if (distance <= minimalDistance)
			{
				if (this.currentTarget != null && this.collideWith(this.currentTarget, this.x, this.y))
					return true;
				else if (this.currentTarget == null && this.collidePoint(_x, _y, this.destination.x, this.destination.y))
					return true;
			}
			return false;
		}
		
		public function randomWalk():void
		{
			
		}
		
		// Simple movement
		public function moveToPoint(p:Point):void
		{
			var _x:int = this.flx.getMidpoint().x;
			var _y:int = this.flx.getMidpoint().y;
			this.angle = FP.angle(_x, _y, int(p.x), int(p.y));
			FP.angleXY(this.velocity, this.angle, this.speed * FP.elapsed);				
			this.updateCollision();
		}
		
		// A Star
		public function updateFindPath():void
		{
			var path:FlxPath;
			path = G.level.pathFinding.findPath(this.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
			if (path != null)
			{
				this.flx.followPath(path, this.speed);
			}			
		}
		
		// A Star
		public function updateTimedFindPath():void
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
		
		protected function updateCollision():void
		{
			this.x += this.velocity.x;
			
			// monster x
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
			// wall x
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
			
			// monster y
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
			// wall y
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
		
		override public function attack(actor:BaseActor):void
		{
			actor.takeDamage(this.strength)
		}
		
		override public function takeDamage(amountOfDamage:int):void
		{
			super.takeDamage(amountOfDamage);
			
			FP.world.add(new Explosion(this.x, this.y));
			
			if (this.health <= 0)
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