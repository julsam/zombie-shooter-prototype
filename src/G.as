package  
{
	import flash.utils.Dictionary;
	
	public class G
	{		
		public static var
			time:int = 0,
			deaths:int = 0,
			restartLevel:Boolean = false,
			lightingEnabled:Boolean = true,
			
			player:Player,
			camera:Camera;
		
				
		public static const grid:int = 8;
		
		public static const windowWidth:int = 640;
		public static const windowHeight:int = 480;
		
		public static const FIXED_FRAME_TIME:Number = 1.0 / 60.0;
		
		public static var volumeMusic:Number = 1;
		public static var volumeSound:Number = 0.5;
	}
}