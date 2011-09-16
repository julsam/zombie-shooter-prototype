package utils
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
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
			if (this.active)
			{
				this.timer -= FP.elapsed;
				this.rateTimer -= FP.elapsed;
				
				if (this.rateTimer < 0 && this.mode == 0)
				{
					this.image.color = 0xAA3333;
					this.image.alpha = 0.75;
					this.rateTimer = rate;
					this.mode = 1;
				}
				else if (rateTimer < 0 && mode == 1)
				{					
					this.restoreImage();
					this.rateTimer = rate;
					this.mode = 0;
				}
				
				if (this.timer < 0)
				{
					this.restoreImage();
					this.active = false;
					this.timer = duration;
				}
			}
		}
		
		protected function restoreImage():void
		{
			this.image.color = 0xFFFFFF;
			this.image.alpha = 1;			
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
			this.timer = duration;
		}
		
		public function stop():void
		{
			this.restoreImage();
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