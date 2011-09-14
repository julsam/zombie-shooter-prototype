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
		public var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 0.25);
		
		public var lights:Vector.<Light> = new Vector.<Light>();
		public var shadows:Vector.<Shadow> = new Vector.<Shadow>();
		public var light:Image = new Image(Assets.LIGHT);
		public var shadow:Image = new Image(Assets.SHADOW);
		
		public var renderTo:Point = new Point(0, 0);
		
		public function Lighting() 
		{
			//make us above everything
			layer = -FP.height;
			
			//create the canvas
			canvas = new BitmapData(FP.width, FP.height, false, 0xFFFFFF);
			
			//set the light render position to the center
			light.centerOO();
			shadow.centerOO();
		}
		
		override public function render():void 
		{
			super.render();
			
			//redraw the canvas
			canvas.fillRect(canvas.rect, 0xFFFFFF);
			
			//go through each light and render it to the canvas
			for (var i:int; i < lights.length; i++)
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
			
			for (i = 0; i < shadows.length; i++)
			{
				//if this is removed, skip it
				if (shadows[i].removed) { continue; }
				
				//set the light image scale and alpha properties
				shadow.scale = shadows[i].scale;
				shadow.alpha = shadows[i].alpha;
				
				//render the light to the canvas
				renderTo.x = shadows[i].x;
				renderTo.y = shadows[i].y;
				shadow.render(canvas, renderTo, FP.camera);
			}
			
			// temp hack : player's light
			light.scale = 1.3;
			light.alpha = 0.95;
			renderTo.x = G.player.x;
			renderTo.y = G.player.y - 5;
			light.render(canvas, renderTo, FP.camera);			

			
			// render the canvas to the screen, with
			FP.buffer.draw(canvas, null, colorTransform, BlendMode.SUBTRACT);			
		}
		
		public function addLight(l:Light):void
		{
			//add a new light to be displayed
			lights.push(l);
		}
		
		public function addShadow(s:Shadow):void
		{
			shadows.push(s);
		}
		
		public function removeLight(l:Light):void
		{
			//find the one we should remove
			for (var i:int = 0; i < lights.length; i++)
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
		
		public function removeShadow(s:Shadow):void
		{
			for (var i:int = 0; i < shadows.length; i++)
			{
				if (s == shadows[i])
				{
					shadows[i].removed = true;
					
					shadows.splice(i, 1);
				}
			}
		}
	}	
}