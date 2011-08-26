package  
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Lighting extends Entity
	{
		
		public var canvas:BitmapData;
		public var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1);
		
		public var lights:Vector.<Light> = new Vector.<Light>();
		public var light:Image = new Image(Assets.LIGHT);
		
		public var renderTo:Point = new Point(0, 0);
		
		public function Lighting() 
		{
			//make us above everything
			layer = -100;
			
			//create the canvas
			canvas = new BitmapData(FP.width, FP.height, false, 0xFFFFFF);
			
			//set the light render position to the center
			light.centerOO();
		}
		
		public function add(l:Light):void
		{
			//add a new light to be displayed
			lights.push(l);
		}
		
		public function remove(l:Light):void
		{
			//find the one we should remove
			for (var i:int = 0; i < lights.length; i ++)
			{
				//is this the one we should remove?
				if (l == lights[i])
				{
					//it is, so set the removed value to true
					lights[i].removed = true;
					
					//then take it out of the vector (array)
					lights.splice(i, 1);
				}
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			//redraw the canvas
			canvas.fillRect(canvas.rect, 0xFFFFFF);
			
			//go through each light and render it to the canvas
			for (var i:int; i < lights.length; i ++)
			{
				//if this is removed, skip it
				if (lights[i].removed) { continue; }
				
				//set the light image scale and alpha properties
				light.scale = lights[i].scale;
				light.alpha = lights[i].alpha;
				
				//render the light to the canvas
				renderTo.x = lights[i].x;
				renderTo.y = lights[i].y;
				light.render(canvas, renderTo, FP.camera);
			}
			
			// render the canvas to the screen, with
			FP.buffer.draw(canvas, null, colorTransform, BlendMode.SUBTRACT);
			
		}	
	}	
}