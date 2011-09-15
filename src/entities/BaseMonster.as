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
		public var flx:FlxTween;
		protected var timerFindPath:Number = 0;
		
		protected var image:Image;
		protected var sprite:Spritemap;
		
		protected var MonsterID:int; // unique ID
		protected var childType:String;
		protected var stunned:Number; // the amount of time the entity is stunned		
		
		public function BaseMonster(x:Number, y:Number)
		{
			super(x, y);
			
			flx = new FlxTween(this);
			addTween(flx, true);
			flx.drag.x = 400;
			flx.drag.y = 400;
			
			type = "Monster";
		}
		
		override public function update():void
		{
			timerFindPath += FP.elapsed;
			if( timerFindPath > 0.5 ) // total duration before remove()
			{
				var path:FlxPath;
				path = G.level.pathFinding.findPath(this.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
				this.flx.followPath(path, speed);
				timerFindPath = 0;
			}
			
			super.update();
		}
		
		override protected function takeDamage(damageAmount:int=0):void
		{
			health--;
			
			FP.world.add(new EmitterEntity(x, y));
			
			if (health <= 0)
			{
				collidable = false;
				alive = false;
			}
		}
		
		public function dropSouls():void
		{
			// TODO
		}
	}
}