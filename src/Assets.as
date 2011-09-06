package  
{
	import flash.utils.Dictionary;
	
	public class Assets
	{
		/*** GFX ***/		
		
		[Embed(source = '../assets/levels/zlt1.oel',  mimeType = "application/octet-stream")] 
		public static const TEST1:Class;
		
		
		//tilesets
		[Embed(source = '../assets/gfx/tileset.png')] 
		public static const TILESET:Class;
		
		[Embed(source = '../assets/gfx/player.png')] 
		public static const PLAYER:Class;
		
		[Embed(source = '../assets/gfx/actors/monster1.png')] 
		public static const MONSTER1:Class;
		
		[Embed(source = '../assets/gfx/light.png')] 
		public static const LIGHT:Class;
		
		[Embed(source = '../assets/gfx/shadowSpot.png')] 
		public static const SHADOW:Class;
		
		/*** SFX ***/
		
		[Embed(source="../assets/sfx/AlienShooter/pistol_shot.mp3")]
		public static const SFX_PISTOL_SHOT:Class;
		[Embed(source="../assets/sfx/AlienShooter/miss_hit_v2.mp3")]
		public static const SFX_MISS_HIT:Class;
				
		[Embed(source="../assets/sfx/tests/til.mp3")]
		public static const XGAMEOVER:Class;
	}
}