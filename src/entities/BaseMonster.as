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
		
		protected var childType:String;
		
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
				//Log.CustomMetric("mousePressedTest");
				//Log.LevelCounterMetric("clickCount", "level1");
				var path:FlxPath;
				path = G.level.pathFinding.findPath(this.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
				this.flx.followPath(path, speed);
				timerFindPath = 0;
			}
			
			super.update();
		}
		
		protected function checkForBullet():void
		{
			// abstract
		}
		
		override protected function takeDamage():void
		{
			health--;
			
			FP.world.add(new EmitterEntity(x, y));
			
			if (health <= 0)
			{
				collidable = false;
				dead = true;
			}
		}
	}
}