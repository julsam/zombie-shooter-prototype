package 
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class Camera extends Entity
	{		
		public var lookAt:Entity;
		public var movedX:Number;
		
		public function Camera(_lookAt:Entity) 
		{
			lookAt = _lookAt;
			
			x = lookAt.x - (FP.screen.width / 2);
			y = lookAt.y - (FP.screen.height / 2);
			
			FP.camera.x = Math.floor(x);
			FP.camera.y = Math.floor(y);
			
		}
		
		override public function update():void
		{	
			var dist:Number = FP.distance(lookAt.x - (FP.screen.width / 2), lookAt.y - (FP.screen.height / 2), FP.camera.x, FP.camera.y);
			var spd:Number = dist / 10;
			
			FP.stepTowards(this, lookAt.x - (FP.screen.width / 2), lookAt.y - (FP.screen.height / 2), spd);
			
			FP.camera.x = x;
			FP.camera.y = y;
			
			if (FP.camera.x < 0) { FP.camera.x = 0; }
			if (FP.camera.x + FP.screen.width > FP.width) { FP.camera.x = FP.width - FP.screen.width; }
			if (FP.camera.y < 0) { FP.camera.y = 0; }
			if (FP.camera.y + FP.screen.height > FP.height) { FP.camera.y = FP.height - FP.screen.height; }
		}		
	}
}