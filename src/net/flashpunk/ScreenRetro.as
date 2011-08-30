package net.flashpunk 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import net.flashpunk.Screen;
	
	// freeing memory
	public class ScreenRetro extends Screen
	{
		// PATTERNS	
		public static const NONE:Array 		= 	[];
		
		public static const HORIZONTAL:Array = 	[[1], [0]];
		
		public static const VERTICAL:Array = 	[[1, 0]];
		
		public static const DIAGONAL:Array = 	[[0, 0, 1],
												 [0, 1, 0],									
												 [1, 0, 0]];
											
		public static const INV_DIAGONAL:Array =[[1, 0, 0],
												 [0, 1, 0],									
												 [0, 0, 1]];
		
		public static const GRID:Array 	= 		[[1, 0],
												 [0, 1]];
		
		public static const GRID2:Array = 		[[2, 1, 0],
												 [1, 0, 2],
												 [0, 2, 1]];
		
		public static const DOUBLE_GRID:Array = [[1, 0, 0, 1],
												 [0, 1, 1, 0],			 
											 	 [0, 1, 1, 0],
											 	 [1, 0, 0, 1]];
											
		public static const RGB_FLAG:Array 	= 	[[0, 1, 2],
												 [0, 1, 2],
												 [0, 1, 2]];
		
		// create your own pattern here
		
		
		
		// COLORS
		private const BLACK:Array		= [0x40000000, 0x00FFFFFF];
		private const RGB:Array			= [0x40CC0000, 0x4000CC00, 0x400000CC];		
		// create your own colors list here [c1,c2]		
		
		// Private vars
		private var _scanlines:Sprite			= new Sprite;
		private var _blendmode:String;
		private var _scanlinesPattern:Array 	= GRID; 		// default value
		private var _scanlinesColors:Array 		= BLACK;		// default value
		
		public function ScreenRetro() 
		{
			scanlinesDraw();
			FP.engine.addChild( _scanlines );
		}
		
		//If you want that retro screen use the transformation when you do : FP.screen.scale = 2;
		//add the folowing methods into the the net.flashpunk.screen.as file 
		//after the lines : public function get mouseX():int { return (FP.stage.mouseX - _x) / (_scaleX * _scale); }
		
		/* - - - - - - - - - - - - - - - - - - - - - - - - - - - -
		public function get matrix():Matrix { return _matrix; }		
		public function set matrix(value:Matrix):void 
		{
		_matrix = value;
		}
		- - - - - - - - - - - - - - - - - - - - - - - - - - - - */
		
		// then uncomment the followig method		
		
		override public function update():void
		{
		super.update();
		_scanlines.transform.matrix = matrix;
		}
		
		
		
		// -- PUBLIC
		public function get scanlinesPattern():Array { return _scanlinesPattern; }		
		public function set scanlinesPattern(value:Array):void 
		{
			_scanlinesPattern = value;
			scanlinesDraw();
		}
		
		public function get scanlinesColors():Array { return _scanlinesColors; }		
		public function set scanlinesColors(value:Array):void 
		{
			_scanlinesColors = value;
			scanlinesDraw();
		}
		
		public function get scanlinesBlendMode():String { return _blendmode; }		
		public function set scanlinesBlendMode( blendmode:String ):void 
		{
			_blendmode = blendmode
			_scanlines.blendMode = blendmode;
		}		
		
		public function scanlinesClear():void
		{
			_scanlinesPattern = [];
			scanlinesDraw();
		}
		// -- PRIVATE
		private function scanlinesDraw():void
		{
			_scanlines.graphics.clear();
			if (scanlinesPattern.length>0) {			
				var dat:BitmapData = build( scanlinesPattern, scanlinesColors );			
				_scanlines.graphics.beginBitmapFill( dat );
				_scanlines.graphics.drawRect(0, 0, FP.width, FP.height);			
				_scanlines.graphics.endFill();
			}
		}
		
		private function build( pattern:Array, colors:Array ):BitmapData 
		{
			var bitmapW:int = pattern[0].length;			
			var bitmapH:int = pattern.length;			
			var bmd:BitmapData = new BitmapData(bitmapW, bitmapH, true, 0x0);			
			for (var yy:int = 0; yy < bitmapH; yy++) {				
				for (var xx:int = 0; xx < bitmapW; xx++) {
					var color:int = colors[pattern[yy][xx]];
					bmd.setPixel32(xx, yy, color);
				}
			}
			return bmd;
		}
		
	}
	
}