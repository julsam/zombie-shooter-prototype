package
{	
	import Playtomic.Log;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx2;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import net.flxpunk.FlxEntity;
	import net.flxpunk.FlxPath;
	import net.flxpunk.FlxPathFinding;
	
	import entities.*;
	
	public class Game2 extends World
	{
		public var grid:Grid;
		public var pf:FlxPathFinding;
		public var unit:Zombie;
		public var unit2:Zombie;
		
		private var timer:Number = 0;
		
		public var tileset:Tilemap;
		public var tilesRoof:Tilemap;
		public var level:Level;
		public var roof:Entity;
		
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
			Input.define("Shoot", Key.SPACE);
			
			loadLevel();
			
			// create an unit
			unit = new Zombie(400, 200);
			add(unit);	
			unit2 = new Zombie(200, 200);
			add(unit2);	
						
			//create a pathfinding object. Pass him our collison grid
			pf = new FlxPathFinding(grid);
			
			var path:FlxPath;
			path = pf.findPath(unit.flx.getMidpoint(), new Point(150, 200), false);
			// let's moving an unit now!
			// with speed: 30 pixels per second 
			// and move from the start of the path to the end then turn around and go back to the start, over and over.
			unit.flx.followPath(path, 30, FlxPath.PATH_YOYO);
		}
		
		override public function update():void
		{
			super.update();
			
			timer += FP.elapsed;
			if( timer > 0.5 ) // total duration before remove()
			{
				//Log.CustomMetric("mousePressedTest");
				//Log.LevelCounterMetric("clickCount", "level1");
				var path:FlxPath;
				path = pf.findPath(unit.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
				unit.flx.followPath(path, 60);
				path = pf.findPath(unit2.flx.getMidpoint(), G.player.flx.getMidpoint(), true);
				unit2.flx.followPath(path, 30);
				timer = 0;
			}
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
			roof.layer = -FP.height;
			FP.world.add(roof);
			
			// Tiles
			add(new Entity(0, 0, tileset = new Tilemap(Assets.TILESET, FP.width, FP.height, G.grid, G.grid)));
			
			// Player
			add(G.player = new Player(xml.objects[0].playerStart.@x, xml.objects[0].playerStart.@y));
			
			// Camera
			add(G.camera = new Camera(G.player as Entity));
			
			// Tiles Above
			for each (o in xml.cave[0].tile) {
				// 8 = number of column
				tileset.setTile(o.@x / G.grid, o.@y / G.grid, (8 * (o.@ty/G.grid)) + (o.@tx/G.grid));
			}
			
			grid = new Grid(FP.width, FP.height, G.grid, G.grid);
			
			// Solids
			for each (o in xml.solids[0].rect) {
				add(new Solid(o.@x, o.@y, o.@w, o.@h));
				grid.setRect(o.@x / G.grid, o.@y / G.grid, o.@w / G.grid, o.@h / G.grid, true);
			}
			
			// lights
			/*
			if (G.lightingEnabled)
			{
				for each (o in xml.objects[0].fire) {
					lighting.addLight(new Light(o.@x, o.@y, 1.3, 0.95));
				}
				for each (o in xml.objects[0].shadowSpot) {
					lighting.addShadow(new Shadow(o.@x, o.@y, 1.3, 0.95));
				}
			}
			*/
			
			// Tiles Above Deco
			if (xml.roof[0])
			{
				for each (o in xml.roof[0].tile) {
					// 8 = number of column
					tilesRoof.setTile(o.@x / G.grid, o.@y / G.grid, (8 * (o.@ty/G.grid)) + (o.@tx/G.grid));
				}
			}
		}
	}
}