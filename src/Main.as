package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		[SWF(width="640", height="480", backgroundColor="#000000")]		
		public function Main():void 
		{
			super(640, 480, 60, true);
			FP.screen.scale = 1;
			FP.screen.color = 0xa0d0f0;		
			FP.console.enable();	
		}
		
		override public function init():void
		{
			FP.world = new Game;
		}		
	}
	
}