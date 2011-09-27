package 
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	import utils.Utils;
	
	/**
	 * Virtual camera that manage FP.camera
	 */	
	public class Camera extends Entity
	{
		public var _lookAt:Entity;
		public var movedX:Number;
		
		/**
		 * Constructor.
		 * @param	lookAt		The entity to follow. Example : the player
		 */
		public function Camera(lookAt:Entity) 
		{
			_lookAt = lookAt;
			
			x = _lookAt.x - (FP.screen.width / 2);
			y = _lookAt.y - (FP.screen.height / 2);
			
			FP.camera.x = Math.floor(x);
			FP.camera.y = Math.floor(y);
			
		}
		
		override public function update():void
		{	
			var dist:Number = FP.distance(_lookAt.x - (FP.screen.width / 2), _lookAt.y - (FP.screen.height / 2), FP.camera.x, FP.camera.y);
			var spd:Number = dist / 10;
			
			FP.stepTowards(this, _lookAt.x - (FP.screen.width / 2), _lookAt.y - (FP.screen.height / 2), spd);
			
			FP.camera.x = x;
			FP.camera.y = y;
			
			if (FP.camera.x < 0) { FP.camera.x = 0; }
			if (FP.camera.x + FP.screen.width > FP.width) { FP.camera.x = FP.width - FP.screen.width; }
			if (FP.camera.y < 0) { FP.camera.y = 0; }
			if (FP.camera.y + FP.screen.height > FP.height) { FP.camera.y = FP.height - FP.screen.height; }
			
			// Update Quake FX
			Utils.quake.update();
		}		
	}
}