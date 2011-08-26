package  
{
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Light
	{
		
		/*
		* This class is basically just to hold the different sizes and scales
		* of all the lights. Every light added through the lighting will be rendered
		* to the screen as a light. */
		
		public var x:int = 0;
		public var y:int = 0;
		public var scale:Number = 1;
		public var alpha:Number = 1;
		public var removed:Boolean = false;
		
		public function Light(x:int, y:int, scale:Number = 1, alpha:Number = 1) 
		{
			this.x = x;
			this.y = y;
			this.scale = scale;
			this.alpha = alpha;
		}
	}
}