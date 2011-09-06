package net.flashpunk 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * Sound effect object used to play embedded sounds.
	 */
	public class Sfx2
	{
		/**
		 * Optional callback function for when the sound finishes playing.
		 */
		public var complete:Function;
		
		protected var leading:Number = 0;
		protected var trailing:Number = 0;
		protected var modified_length:Number = 0;
		protected var timer:Timer = null;
		
		/**
		 * Creates a sound effect from an embedded source. Store a reference to
		 * this object so that you can play the sound using play() or loop().
		 * @param	source		The embedded sound class to use.
		 * @param	complete	Optional callback function for when the sound finishes playing.
		 */
		public function Sfx2(source:Class, leading:Number = 0, trailing:Number = 0, complete:Function = null) 
		{
			_sound = _sounds[source];
			if (!_sound) _sound = _sounds[source] = new source;
			this.complete = complete;
			
			this.leading = leading;
			this.trailing = trailing;
			modified_length = this.length * 1000 - leading - trailing;
			trace('Modified Length: ' + modified_length);
		}
		
		/**
		 * Plays the sound once.
		 * @param	vol		Volume factor, a value from 0 to 1.
		 * @param	pan		Panning factor, a value from -1 to 1.
		 */
		public function play(vol:Number = 1, pan:Number = 0, first_time:Boolean = true):void
		{
			if (_channel) stop();
			_vol = _transform.volume = vol < 0 ? 0 : vol;
			_pan = _transform.pan = pan < -1 ? -1 : (pan > 1 ? 1 : pan);
			_channel = _sound.play(leading, 0, _transform); //change the play function to start at the leading position
			if (first_time) {
				trace('Running first time');
				timer = new Timer(modified_length - 100, 1);
				first_time = false;
			} else {
				timer = new Timer(modified_length, 1);
			}
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			timer.start();
			//_channel.addEventListener(Event.SOUND_COMPLETE, onComplete); // removing this line because it will not be used.
			_looping = false;
			_position = 0;
		}
		
		/**
		 * Plays the sound looping. Will loop continuously until you call stop(), play(), or loop() again.
		 * @param	vol		Volume factor, a value from 0 to 1.
		 * @param	pan		Panning factor, a value from -1 to 1.
		 */
		public function loop(vol:Number = 1, pan:Number = 0, first_time:Boolean = true):void {
			play(vol, pan, first_time);
			_looping = true;
		}
		
		/**
		 * Stops the sound if it is currently playing.
		 * @return
		 */
		public function stop():Boolean
		{
			if (!_channel) return false;
			_position = _channel.position;
			_channel.removeEventListener(Event.SOUND_COMPLETE, onComplete);
			_channel.stop();
			_channel = null;
			return true;
		}
		
		/**
		 * Resumes the sound from the position stop() was called on it.
		 */
		public function resume():void
		{
			_channel = _sound.play(_position, 0, _transform);
			_channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
			_position = 0;
		}
		
		private function timerComplete(e:TimerEvent = null):void {
			trace('Timer Firing');
			if (_looping) loop(_vol, _pan, false);
			else stop();
			_position = 0;
			if (complete != null) complete();
		}
		
		/** @private Event handler for sound completion. */
		protected function onComplete(e:Event = null):void
		{
			if (_looping) loop(_vol, _pan);
			else stop();
			_position = 0;
			if (complete != null) complete();
		}
		
		/**
		 * Alter the volume factor (a value from 0 to 1) of the sound during playback.
		 */
		public function get volume():Number { return _vol; }
		public function set volume(value:Number):void
		{
			if (value < 0) value = 0;
			if (!_channel || _vol == value) return;
			_vol = _transform.volume = value;
			_channel.soundTransform = _transform;
		}
		
		/**
		 * Alter the panning factor (a value from -1 to 1) of the sound during playback.
		 */
		public function get pan():Number { return _pan; }
		public function set pan(value:Number):void
		{
			if (value < -1) value = -1;
			if (value > 1) value = 1;
			if (!_channel || _pan == value) return;
			_pan = _transform.pan = value;
			_channel.soundTransform = _transform;
		}
		
		/**
		 * If the sound is currently playing.
		 */
		public function get playing():Boolean { return _channel != null; }
		
		/**
		 * Position of the currently playing sound, in seconds.
		 */
		public function get position():Number { return (_channel ? _channel.position : _position) / 1000; }
		
		/**
		 * Length of the sound, in seconds.
		 */
		public function get length():Number { return _sound.length / 1000; }
		
		// Sound infromation.
		/** @private */ protected var _vol:Number = 1;
		/** @private */ protected var _pan:Number = 0;
		/** @private */ protected var _sound:Sound;
		/** @private */ protected var _channel:SoundChannel;
		/** @private */ protected var _transform:SoundTransform = new SoundTransform;
		/** @private */ protected var _position:Number = 0;
		/** @private */ protected var _looping:Boolean;
		
		// Stored Sound objects.
		/** @private */ protected static var _sounds:Dictionary = new Dictionary;
	}
}