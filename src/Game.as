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
		public var tilesRoof:Tilemap;
		public var roof:Entity;
		
		public var lighting:Lighting;
		public var lightMouse:Light
		
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
			
			//create the lighting
			add(lighting = new Lighting());
			
			loadLevel();
			
			//add the lights to the screen
			lighting.add(new Light(20, 20, 1, 1));
			lighting.add(lightMouse = new Light(0, 0, 4, 1));
			
			//also, just for the fun of it, lets through in a bunch of random alpha and scale
			for (var i:int = 0; i < 20; i ++)
			{
				//lighting.add(new Light(Math.random() * FP.width, Math.random() * FP.height, Math.random(), Math.random()));
			}
		}
		
		override public function update():void
		{
			super.update();
			
			lightMouse.x = G.player.x;
			lightMouse.y = G.player.y;
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
			
			// roofs
			roof = new Entity()
			tilesRoof = new Tilemap(Assets.TILESET, FP.width, FP.height, G.grid, G.grid);
			roof.graphic = tilesRoof;
			roof.layer = -8;
			FP.world.add(roof);
			
			// Tiles
			add(new Entity(0, 0, tileset = new Tilemap(Assets.TILESET, FP.width, FP.height, G.grid, G.grid)));
			
			// Player
			add(G.player = new Player(xml.objects[0].playerStart.@x, xml.objects[0].playerStart.@y));
						
			// Camera
			add(G.camera = new Camera(G.player as Entity));
			
			// Tiles Above
			for each (o in xml.cave[0].tile) {
				// 17 = number of column
				tileset.setTile(o.@x / G.grid, o.@y / G.grid, (8 * (o.@ty/G.grid)) + (o.@tx/G.grid));
			}
			
			// Solids
			for each (o in xml.solids[0].rect) {
				add(new Solid(o.@x, o.@y, o.@w, o.@h));
			}
			
			// lights
			if (G.lightingEnabled)
			{
				for each (o in xml.objects[0].fire) {
					lighting.add(new Light(o.@x, o.@y, 1.3, 0.95));
				}
			}
			
			// Tiles Above Deco
			if (xml.roof[0])
			{
				for each (o in xml.roof[0].tile) {
					// 17 = number of column
					tilesRoof.setTile(o.@x / G.grid, o.@y / G.grid, (8 * (o.@ty/G.grid)) + (o.@tx/G.grid));
				}
			}
		}
	}
}