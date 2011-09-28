package net.flashpunk.graphics 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	/**
	 * Used to render tiles. Uses less data than the tilemap if you have large maps
	 * @author Noel Berry
	 */
	public class Tilegroup extends Graphic
	{
		// map information
		public var map:Vector.<Vector.<int>>;
		public var width:int;
		public var height:int;
		
		// tileset information
		public var tileset:BitmapData;
		public var tileWidth:int;
		public var tileHeight:int;
		
		// columns
		public var columns:int = 0;
		
		// rendering
		public var size:Rectangle;
		public var to:Point = new Point(0, 0);
		
		public function Tilegroup(source:*, width:int, height:int, tileWidth:int, tileHeight:int) 
		{
			
			// grab bitmapdata
			if (source is Class)
			{
				tileset = FP.getBitmap(source);
			}
			else if (source is BitmapData) 
			{
				tileset = source;
			}
			
			// size of the map
			this.width = width;
			this.height = height;
			columns = tileset.width / tileWidth;
			
			// grid
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			
			// size rectangle (re-usable)
			size = new Rectangle(0, 0, tileWidth, tileHeight);
			
			// create the array/map
			map = new Vector.<Vector.<int>>(width + 1, true)
			for (var i:int = 0; i < width + 1; i ++)
			{
				map[i] = new Vector.<int>(height + 1, true);
				for (var j:int = 0; j < height + 1; j ++)
				{
					map[i][j] = -1;
				}
			}
		}
		
		/**
		 * Places a new tile at the given position
		 * @param	x		the column to render at
		 * @param	y		the row to render at
		 * @param	tx		the tile x position
		 * @param	ty		the tile y position
		 */
		public function setTile(x:int, y:int, tx:int, ty:int):int
		{
			// grab the tile id
			var tile:int = (columns * ty) + tx;
			map[x][y] = tile;
			return tile;
		}
		
		override public function render(target:BitmapData, point:Point, camera:Point):void 
		{
			var renderLeft:int = 	Math.max(0, camera.x * scrollX / tileWidth - 1);
			var renderTop:int = 	Math.max(0, camera.y * scrollY / tileHeight - 1);
			var renderWidth:int = 	Math.min(width, (camera.x * scrollX / tileWidth) + (FP.width / tileWidth) + 1);
			var renderHeight:int = 	Math.min(height, (camera.y * scrollY / tileHeight) + (FP.height / tileHeight) + 1);
			
			// draw tiles on screen
			for (var i:int = renderLeft; i < renderWidth; i ++)
			{
				for (var j:int = renderTop; j < renderHeight; j ++)
				{
					// where do we render to
					to.x = point.x + int((i * tileWidth)) - camera.x * scrollX;
					to.y = point.y + int((j * tileHeight)) - camera.y * scrollY;
					
					// render tiles
					if (map[i][j] != -1) drawTile(target, to, map[i][j]);
				}
			}
		}
		
		/**
		 * Draws a tile (tile) at position (position) on the screen
		 * @param	position	the position to render to
		 * @param	tile		the tile id to render
		 */
		public function drawTile(target:BitmapData, position:Point, tile:int):void
		{
			if (!target) target = FP.buffer;
			
			// the tile we need
			size.x = (tile % columns) * tileWidth;
			size.y = uint(tile / columns) * tileHeight;
			
			// render to buffer
			target.copyPixels(tileset, size, position);
		}
	}
}