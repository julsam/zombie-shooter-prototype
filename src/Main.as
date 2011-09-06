package
{
	import flash.display.*;
	import flash.ui.ContextMenu;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.ScreenRetro;
	
	import Playtomic.*;
	
	public class Main extends Engine
	{
		public function Main():void 
		{
			super(320, 240, 60, false);
			//super(213, 160, 60, false);
		}
		
		override public function init():void
		{
			FP.screen = new ScreenRetro;
			
			FP.screen.scale = 2;
			//FP.screen.scale = 3;
			
			FP.screen.color = 0x000000;
			FP.console.enable();
			
			Log.Play();
			
			FP.world = new Game;
		}
	}
}