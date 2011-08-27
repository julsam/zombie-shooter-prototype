package  
{
	public class Shadow
	{		
		public var x:int = 0;
		public var y:int = 0;
		public var scale:Number = 1;
		public var alpha:Number = 1;
		public var removed:Boolean = false;
		
		public function Shadow(x:int, y:int, scale:Number = 1, alpha:Number = 1) 
		{
			this.x = x;
			this.y = y;
			this.scale = scale;
			this.alpha = alpha;
		}
	}
}