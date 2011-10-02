package
{
	import Playtomic.*;
	
	import flash.display.*;
	import flash.ui.ContextMenu;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.ScreenRetro;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Main extends Engine
	{
		public function Main():void 
		{
			super(320, 240, 60, false);   // 640x480 x2
			//super(213, 160, 60, false); // 640x480 x3
			
			//super(400, 300, 60, false); // 800x600 x2
			//super(266, 200, 60, false); // 800x600 x3
		}
		
		override public function init():void
		{
			FP.screen = new ScreenRetro;
			
			FP.screen.scale = 2;
			//FP.screen.scale = 3;
			
			FP.screen.color = 0x000000;
			FP.console.enable();
			
			Log.Play();
			
			FP.world = new Game2;
		}
	}
}