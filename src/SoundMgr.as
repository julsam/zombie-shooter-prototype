package
{
	import net.flashpunk.Sfx;
	import net.flashpunk.Sfx2;
	
	public final class SoundMgr
	{		
		//[Embed(source="somesoundeffect.mp3")] public static const SOME_SOUND_EFFECT:Class;
		
		//[Embed(source="../assets/sfx/chrushedout.mp3")] public static const SOME_MUSIC:Class;
		
		//public static var some_music:Sfx = new Sfx(SOME_MUSIC);
		
		public static var sfx_pistol_shot:Sfx = new Sfx(Assets.SFX_PISTOL_SHOT);
		public static var sfx_miss_hit:Sfx = new Sfx(Assets.SFX_MISS_HIT);
		
		private static var _currentMusic:Sfx2;
				
		public static function get currentMusic():Sfx2
		{
			return _currentMusic;
		}
		
		public static function setCurrentMusic(music:Sfx2, first_time:Boolean=false):void
		{
			if(_currentMusic != music)
			{
				if(_currentMusic) _currentMusic.stop();
				_currentMusic = music;
				_currentMusic.volume = G.volumeMusic;
				_currentMusic.loop(G.volumeMusic, 0, first_time);
			}
		}
		
		public static function playSound(sound:Sfx, pan:Number=0, callback:Function=null):void
		{
			sound.stop();
			sound.play(G.volumeSound, pan);
		}
	}
}