package utils
{
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	
	/**
	 * Quake allows you to shake the whole screen on the game. Note that it 
	 * doesn't use the camera, only shakes FP.screen.
	 * 
	 * @author Rolpege
	 */	
	public class Quake
	{
		protected var intensity:Number=0;	
		protected var timer:Number=0;
		protected var initialCameraPosition:Point = new Point;
		
		/**
		 * Start quaking the screen!
		 *  
		 * @param intensity The amount of pixels the screen will be moved
		 * @param duration Time in seconds before the screen stops quaking
		 */		
		public function start(intensity:Number=0.5, duration:Number=0.5):void
		{
			initialCameraPosition = new Point(FP.camera.x, FP.camera.y);
			stop();
			this.intensity = intensity * 0.05;
			timer = duration;
		}
		
		/**
		 * Immediatly stop quaking.
		 */		
		public function stop():void
		{
			FP.camera.x = initialCameraPosition.x;
			FP.camera.y = initialCameraPosition.y;
			intensity = 0;
			timer = 0;
		}
		
		/**
		 * Call this every frame. You could add it on Engine.update or World.update. 
		 */		
		public function update():void
		{
			if(timer > 0)
			{
				timer -= FP.elapsed;
				if(timer <= 0)
				{
					stop();
				}
				else
				{
					FP.camera.x = initialCameraPosition.x + (Math.random()*intensity*FP.width*2-intensity*FP.width)*0.5;
					FP.camera.y = initialCameraPosition.y + (Math.random()*intensity*FP.height*2-intensity*FP.height)*0.5;
					trace(FP.camera.x, FP.camera.y);
				}
			}
		}
	}
}