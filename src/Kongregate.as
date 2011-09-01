package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	
	public class Kongregate
	{
		public static var api:* = null;
		
		public static function connect(obj:DisplayObjectContainer):void
		{
			// Pull the API path from the FlashVars
			var paramObj:Object = LoaderInfo(obj.root.loaderInfo).parameters;
			
			// The API path. The "shadow" API will load if testing locally. 
			var apiPath:String = paramObj.api_path || 
				"http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			// Allow the API access to this SWF
			Security.allowDomain(apiPath);
			
			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			obj.addChild(loader);
		}
		
		public static function submit(statisticName:String, value:Number):Boolean
		{
			if (api) 
			{
				api.stats.submit(statisticName, value);
				return true;
			}
			
			return false
		}
		
		public static function getUsername():String
		{
			if (api) 
			{
				return api.services.getUsername();
			}
			
			return "";
		}
		
		// This function is called when loading is complete
		private static function loadComplete(event:Event):void
		{
			// Save Kongregate API reference
			api = event.target.content;
			
			// Connect to the back-end
			api.services.connect();
		}
	}
}