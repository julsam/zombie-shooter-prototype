package  
{
	import entities.Player;
	
	import flash.utils.Dictionary;
	
	public class G
	{		
		public static var
			time:int = 0,
			deaths:int = 0,
			pause:Boolean = false,
			restartLevel:Boolean = false,
			lightingEnabled:Boolean = true,
			slowMotionActivated:Boolean = false,
			
			player:Player,
			camera:Camera,
			lighting:Lighting,
			level:Level;
		
		public static const grid:int = 8;
		public static const TILE_SIZE:int = 16;
		
		public static const windowWidth:int = 640;
		public static const windowHeight:int = 480;
		
		public static const TILESET_NB_COLUMNS:int = 2;
		
		public static var volumeMusic:Number = 1;
		public static var volumeSound:Number = 0.1;
	}
}