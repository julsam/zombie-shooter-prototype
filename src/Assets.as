package  
{
	import flash.utils.Dictionary;
	
	public class Assets
	{
		[Embed(source = '../assets/levels/zlt4.oel',  mimeType = "application/octet-stream")] 
		public static const TEST1:Class;
		
		/*** GFX ***/
		
		[Embed(source = '../assets/gfx/tileset2.png')] 
		public static const TILESET:Class;
		
		[Embed(source = '../assets/gfx/floor.png')] 
		public static const FLOOR_BG:Class;
		
		[Embed(source = '../assets/gfx/player.png')] 
		public static const PLAYER:Class;
		
		[Embed(source = '../assets/gfx/actors/monster1.png')] 
		public static const MONSTER1:Class;
		
		[Embed(source = '../assets/gfx/light.png')] 
		public static const LIGHT:Class;
		
		[Embed(source = '../assets/gfx/shadowSpot.png')] 
		public static const SHADOW:Class;
		
		[Embed(source = '../assets/gfx/explosion.png')] 
		public static const EXPLOSION:Class;
		
		[Embed(source = '../assets/gfx/healthBar2.png')] 
		public static const HEALTHBAR:Class;
		
		[Embed(source = '../assets/gfx/healthBarPlaceHolder2.png')] 
		public static const HEALTHBAR_PLACEHOLDER:Class;
		
		/*** SFX ***/
		
		[Embed(source="../assets/sfx/AlienShooter/pistol_shot.mp3")]
		public static const SFX_PISTOL_SHOT:Class;
		[Embed(source="../assets/sfx/AlienShooter/miss_hit_v2.mp3")]
		public static const SFX_MISS_HIT:Class;
				
		[Embed(source="../assets/sfx/tests/til.mp3")]
		public static const XGAMEOVER:Class;
	}
}