package
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import flash.display.BitmapData;
	
	public class Solid extends Entity
	{		
		public function Solid(_x:int, _y:int, _w:int=32, _h:int=32) 
		{
			x = _x;
			y = _y;	
			graphic	= new Image(new BitmapData(_w, _h, false, 0x000000));
			
			type = "Solid";
			setHitbox(_w, _h);
			
			// don't need to be updated or rendered
			active = false;
			visible = false;
		}
	}
}