package 
{
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class Level extends Entity
	{
		public var tilemap:Tilemap;
		public var aboveLayer:Tilemap;
		public var belowLayer:Tilemap;
		public var grid:Grid;
		
		public function Level():void
		{
			
		}
		
		public function load(data:Class):void
		{
			var file:ByteArray = new data;
			var str:String = file.readUTFBytes(file.length);
			var xml:XML = new XML(str);
			
			var e:Entity;
			var o:XML;			
		}
	}
}