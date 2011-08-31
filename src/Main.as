package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.ScreenRetro;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	public class Main extends Engine
	{
		public function Main():void 
		{
			super(320, 240, 60, false);
			FP.screen = new ScreenRetro;
			FP.screen.scale = 2;
			//super(213, 160, 60, false);
			//FP.screen = new ScreenRetro;
			//FP.screen.scale = 3;
			
			FP.screen.color = 0x000000;
			FP.console.enable();
		}
		
		override public function init():void
		{
			FP.world = new GameWorld2;
		}		
	}
	
}