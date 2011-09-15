package utils
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Blink
	{
		public var image:Image;
		public var duration:Number;
		public var rate:Number = 0.25;
		protected var timer:Number;
		protected var rateTimer:Number;
		protected var mode:int = 0;
		public var active:Boolean = false;
		public var color:uint;
		
		public function Blink(image:Image=null, duration:Number=2, rate:Number=0.2)
		{
			this.image = image;
			this.duration = this.timer = duration;
			this.rate = this.rateTimer = rate;
		}
		
		public function update():void
		{
			if (active)
			{
				timer -= FP.elapsed;
				rateTimer -= FP.elapsed;
				
				if (rateTimer < 0 && mode == 0)
				{
					image.color = 0xAA3333;
					image.alpha = 0.75;
					rateTimer = rate;
					mode = 1;
				}
				else if (rateTimer < 0 && mode == 1)
				{					
					restoreImage();
					rateTimer = rate;
					mode = 0;
				}
				
				if (timer < 0)
				{
					restoreImage();
					active = false;
					timer = duration;
				}
			}
		}
		
		protected function restoreImage():void
		{
			image.color = 0xFFFFFF;
			image.alpha = 1;			
		}		
		
		public function isActive():Boolean
		{
			return (this.active ? true : false);
		}
		
		public function setActive():void
		{
			this.active = true;
		}
		
		public function reset():void
		{			
			timer = duration;
		}
		
		public function stop():void
		{
			restoreImage();
		}
		
		public function pause():void
		{
			// TODO
		}
		
		public function setColor(color:uint=0xAA3333):void
		{
			this.color = color;
		}
	}
}