package  
{
	import flash.utils.Dictionary;
	
	public class Assets
	{
		[Embed(source = '../assets/levels/zlt1.oel',  mimeType = "application/octet-stream")] 
		public static const TEST1:Class;
		
		
		//tilesets
		[Embed(source = '../assets/gfx/tilesetCave.png')] 
		public static const TILESET:Class;
		
		
		[Embed(source = '../assets/gfx/playerStart.png')] 
		public static const PLAYER:Class;
		
		[Embed(source = '../assets/gfx/light.png')] 
		public static const LIGHT:Class;
	}
}