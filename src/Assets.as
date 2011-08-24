package  
{
	import flash.utils.Dictionary;
	
	public class Assets
	{
		[Embed(source = '../assets/levels/test1.oel',  mimeType = "application/octet-stream")] 
		public static const TEST1:Class;
		
		
		//tilesets
		[Embed(source = '../assets/gfx/tileset.png')] 
		public static const TILESET:Class;
		
		
		[Embed(source = '../assets/gfx/playerStart.png')] 
		public static const PLAYER:Class;
	}
}