package entities
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flxpunk.FlxTween;
	import net.flxpunk.FlxPath;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class BaseMonster extends BaseActor
	{
		protected var timerFindPath:Number = 0;
		
		protected var image:Image;
		protected var sprite:Spritemap;
		
		protected var MonsterID:int; // unique ID
		protected var childType:String;
		protected var stunned:Number; // the amount of time the entity is stunned		
		
		public function BaseMonster(x:Number, y:Number)
		{
			super(x, y);
			
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
			this.timerFindPath += FP.elapsed;
			if (this.timerFindPath > 0.5) // total duration before remove()
			{
				//TODO : find an other way, currently too slow with many entities
				var path:FlxPath;
				path = G.level.pathFinding.findPath(this.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
				if (path != null)
				{
					this.flx.followPath(path, this.speed);
				}
				this.timerFindPath = 0;
			}
			
			super.update();
		}
		
		override protected function takeDamage(amountOfDamage:int=0):void
		{
			this.health--;
			
			FP.world.add(new Explosion(this.x, this.y));
			
			if (health <= 0)
			{
				this.collidable = false;
				this.alive = false;
			}
		}
		
		public function dropSouls():void
		{
			// TODO
		}
	}
}