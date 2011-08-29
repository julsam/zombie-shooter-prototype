package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import flashx.textLayout.debug.assert;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Zombie extends Entity 
	{
		private var speed:Number;

		private var image:Image;
		private var sprite:Spritemap;
		
		public function Zombie(x:int, y:int)
		{
			this.x = x;
			this.y = y;
			
			setHitbox(8, 8, 4, 4);
			image = new Image(new BitmapData(8, 8, false, 0xffff00));
			graphic = image;
			
			type = "Monster";
			
			image.centerOO();
		}
		override public function update():void
		{
			
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}	
	}
}