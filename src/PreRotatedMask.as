package
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Masklist;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/* @author Biggles */	
	
	public class PreRotatedMask extends Mask
	{
		// this is where we store each PixelMask
		// so to access frame x's mask, we just do mask = animatedMaskList.pixelmask[x];
		public var pixelmasks:Array = new Array();
		
		/**
		 * Current angle to fetch the pre-rotated frame from.
		 */
		private var _frameAngle:Number = 0;
		private var _size:uint;
		
		public var bitmaps:Array = [];
		
		// constructor takes the same bitmap as your spritemap, and needs to know frame width & height
		public function PreRotatedMask(source:*, frameCount:uint = 36, clone:Boolean = false) 
		{
			if(!clone){
				var r:BitmapData;// = _rotated[source];
				
				_frame = new Rectangle();// 0, 0, _sizeOf[source], _sizeOf[source]);
				_frameCount = frameCount;
				//if (!r)
				
				// produce a rotated bitmap strip
				var temp:BitmapData = (source is Class) ? (new source).bitmapData : source,
					size:uint = _size = Math.ceil(FP.distance(0, 0, temp.width, temp.height)); // = _sizeOf[source] =
				_frame.width = _frame.height = size;
				
				r = new BitmapData(_frame.width, _frame.height, true, 0);
				var m:Matrix = FP.matrix,
					a:Number = 0,
					aa:Number = (Math.PI * 2) / -frameCount,
					ox:uint = temp.width / 2,
					oy:uint = temp.height / 2,
					o:uint = _frame.width / 2,
					x:uint = 0,
					y:uint = 0,
					frame_number:int = 0;
				
				while (frame_number < frameCount)
				{
					m.identity();
					m.translate(-ox, -oy);
					m.rotate(a);
					m.translate(o, o);
					r.fillRect(_frame, 0);
					r.draw(temp, m, null, null, null, false);
					a += aa;
					
					frame_number += 1;
					
					pixelmasks.push(new Pixelmask(r));			
					bitmaps.push(new Image(r));
				}}
		}
		
		override protected function update():void 
		{
			assignParent();
			super.update();
		}
		
		public function assignParent(p:Entity = null):void
		{
			p = p ? p : parent;
			
			for each (var pm:Pixelmask in pixelmasks)
			pm.parent = parent;
		}
		
		public function set x(x:Number):void
		{
			_x = x;
			for each (var pm:Pixelmask in pixelmasks)
			pm.x = x;
		}
		public function set y(y:Number):void
		{
			_y = y;
			for each (var pm:Pixelmask in pixelmasks)
			pm.y = y;
			
		}
		public function get x():Number { return _x; }
		public function get y():Number { return _y; }
		override public function collide(mask:Mask):Boolean 
		{
			return currentMask.collide(mask);
		}		
		
		public function getMask(index:uint):Pixelmask
		{
			return pixelmasks[index];
		}
		
		public function get currentMask():Pixelmask
		{
			return getMask(maskIndex);
		}
		
		public function get maskIndex():uint 
		{	
			return uint(_frameCount * (_frameAngle / 360));
		}
		
		public function get width():Number
		{
			return currentMask.width;
		}
		
		public function get height():Number
		{
			return currentMask.height;
		}
		
		public function set frameAngle(angle:Number):void
		{			
			_frameAngle = angle;
			_frameAngle %= 360;
			if (_frameAngle < 0) _frameAngle += 360;
		}
		
		public function get size():uint { return _size; }
		
		// Rotation information.
		/** @private */ private var _source:BitmapData;
		/** @private */ private var _width:uint;
		/** @private */ private var _frame:Rectangle;
		/** @private */ private var _frameCount:uint;
		/** @private */ private var _last:int = -1;
		/** @private */ private var _current:int = -1;
		private var _x:Number;
		private var _y:Number;
		
		
		// Global information.
		///** @private */ private static var _rotated:Dictionary = new Dictionary;
		///** @private */ private static var _sizeOf:Dictionary = new Dictionary;
		
		public function clone():PreRotatedMask
		{
			var p:PreRotatedMask = new PreRotatedMask(null, 36, true);
			p.bitmaps = this.bitmaps.slice();
			p.pixelmasks = pixelmasks.slice();
			return p;
		}
	}
	
}