package
{
	import net.flashpunk.Sfx;
	
	public final class SoundMgr
	{		
		//[Embed(source="somesoundeffect.mp3")] public static const SOME_SOUND_EFFECT:Class;
		
		//[Embed(source="../assets/sfx/chrushedout.mp3")] public static const SOME_MUSIC:Class;
		
		//public static var some_music:Sfx = new Sfx(SOME_MUSIC);
		
		public static var sfx_pistol_shot:Sfx = new Sfx(Assets.SFX_PISTOL_SHOT);
		public static var sfx_miss_hit:Sfx = new Sfx(Assets.SFX_MISS_HIT);
		
		private static var _currentMusic:Sfx;
				
		public static function get currentMusic():Sfx
		{
			return _currentMusic;
		}
		
		public static function setCurrentMusic(music:Sfx):void
		{
			if(_currentMusic != music)
			{
				if(_currentMusic) _currentMusic.stop();
				_currentMusic = music;
				_currentMusic.volume = G.volumeMusic;
				_currentMusic.loop(G.volumeMusic);
			}
		}
		
		public static function playSound(sound:Sfx, pan:Number=0, callback:Function=null):void
		{
			sound.stop();
			sound.play(G.volumeSound, pan);
		}
	}
}