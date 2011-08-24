package
{
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Game extends World
	{
		public var tileset:Tilemap;
		
		override public function begin():void
		{
			// level size
			FP.width = G.windowWidth;
			FP.height = G.windowHeight;
						
			Input.define("Left", Key.LEFT, Key.Q);
			Input.define("Right", Key.RIGHT, Key.D);
			Input.define("Up", Key.UP, Key.Z);
			Input.define("Down", Key.DOWN, Key.S);
			Input.define("Run", Key.SHIFT);
			
			//add(G.player = new Player());
			
			loadLevel();
		}
		
		override public function update():void
		{			
			super.update();
		}
		
		public function loadLevel():void 
		{
			var file:ByteArray = new Assets.TEST1;
			var str:String = file.readUTFBytes( file.length );
			var xml:XML = new XML(str);
			
			var e:Entity;
			var o:XML;
			var n:XML;
			
			// Level size
			FP.width = xml.width;
			FP.height = xml.height;
			
			
			add(new Entity(0, 0, tileset = new Tilemap(Assets.TILESET, FP.width, FP.height, G.grid, G.grid)));
			
			// Player
			add(G.player = new Player(xml.objects[0].playerStart.@x, xml.objects[0].playerStart.@y));
						
			// Camera
			//add(Global.camera = new Camera(Global.player as Entity));
			
			// Tiles Above
			for each (o in xml.tilesAbove[0].tile) {
				// 17 = number of column
				tileset.setTile(o.@x / G.grid, o.@y / G.grid, (2 * (o.@ty/G.grid)) + (o.@tx/G.grid));
			}
			
			// Solids
			for each (o in xml.solids[0].rect) {
				add(new Solid(o.@x, o.@y, o.@w, o.@h));
			}
			
			// Tiles Above Deco
			if (xml.tilesAboveDeco[0])
			{
				for each (o in xml.tilesAboveDeco[0].tile) {
					// 17 = number of column
					tileset.setTile(o.@x / G.grid, o.@y / G.grid, (17 * (o.@ty/G.grid)) + (o.@tx/G.grid));
				}
			}
		}
	}
}