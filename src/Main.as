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
			//FP.screen = new ScreenRetro;
			//FP.screen.scale = 3;
			
			FP.screen.color = 0x000000;
			FP.console.enable();
			
			Log.Play();
			GeoIP.Lookup(SetPlayerCountry);
			
			FP.world = new GameWorld2;
		}
		
		public function SetPlayerCountry(country:Object, response:Object):void
		{
			if(response.Success)
			{
				// we have the country data
				FP.console.log("Player is from " + country.Code + " / " + country.Name);
			}
			else
			{
				FP.console.log("request failed", response.ErrorCode);
			}
		}
	}
}