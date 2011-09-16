package utils
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import net.flashpunk.FP;
	
	public final class Utils
	{
		public static var quake:Quake = new Quake;
		public static var flash:Flash = new Flash;
		
		public static function openURL(url:String):void
		{
			navigateToURL(new URLRequest(url));
		}
		
		/**
		 * Return a pan value based on the x position of an object. 
		 * Useful if you want some sort of Pseudo-3D sound.
		 */
		public static function pan(centerX:Number):Number
		{
			return ((centerX-FP.camera.x) / FP.width) * 2 - 1;
		}
		
		public static function rand(min:int, max:int):int
		{
			return Math.random() * (max - min + 1) + min;
		}		
		
		public static function checkDomain(allowed:*):Boolean
		{
			var url:String = FP.stage.loaderInfo.url;
			var startCheck:int = url.indexOf('://' ) + 3;
			
			if (url.substr(0, startCheck) == 'file://') return true;
			
			var domainLen:int = url.indexOf('/', startCheck) - startCheck;
			var host:String = url.substr(startCheck, domainLen);
			
			if (allowed is String) allowed = [allowed];
			for each (var d:String in allowed)
			{
				if (host.substr(-d.length, d.length) == d) return true;
			}
			
			return false;
		}
	}
}