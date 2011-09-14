package
{
	import entities.*;
	
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	import net.flxpunk.FlxPathFinding;
	
	public class Level extends Entity
	{
		public var aboveTiles:Tilemap;
		public var levelTiles:Tilemap;
		public var belowTiles:Tilemap;
		
		public var grid:Grid;
		public var pathFinding:FlxPathFinding;
		
		protected var xml:XML;
		public var data:Class;
		
		public function Level(data:Class):void
		{
			var file:ByteArray = new data;
			var str:String = file.readUTFBytes(file.length);
			xml = new XML(str);
			
			FP.width = xml.width;
			FP.height = xml.height;
			
			FP.world.addGraphic(new Backdrop(Assets.FLOOR_BG, true, true));
			
			belowTiles = createTilemap(belowTiles, FP.height);
			levelTiles = createTilemap(levelTiles, 0);
			aboveTiles = createTilemap(aboveTiles, -FP.height);
			
			grid = new Grid(FP.width, FP.height, G.grid, G.grid);
		}
		
		private function createTilemap(tilemap:Tilemap, layer:int):Tilemap
		{
			var tilemapEntity:Entity = new Entity();
			tilemap = new Tilemap(Assets.TILESET, FP.width, FP.height, G.grid, G.grid);
			tilemapEntity.graphic = tilemap;
			tilemapEntity.layer = layer;
			FP.world.add(tilemapEntity);
			return tilemap;
		}
		
		public function load():void
		{
			var o:XML;
			
			// Player
			FP.world.add(G.player = new Player(xml.objects[0].playerStart.@x, xml.objects[0].playerStart.@y));
			
			// Camera
			FP.world.add(G.camera = new Camera(G.player as Entity));
			
			// Tiles Above
			for each (o in xml.cave[0].tile)
			{
				levelTiles.setTile(o.@x / G.grid, o.@y / G.grid, (G.TILESET_NB_COLUMNS * (o.@ty/G.grid)) + (o.@tx/G.grid));
			}
			
			// Solids
			for each (o in xml.solids[0].rect)
			{
				FP.world.add(new Solid(o.@x, o.@y, o.@w, o.@h));
				grid.setRect(o.@x / G.grid, o.@y / G.grid, o.@w / G.grid, o.@h / G.grid, true);
			}
			
			// Lights
			if (G.lightingEnabled)
			{
				for each (o in xml.objects[0].fire) {
					G.lighting.addLight(new Light(o.@x, o.@y, 1.3, 0.95));
				}
				for each (o in xml.objects[0].shadowSpot) {
					G.lighting.addShadow(new Shadow(o.@x, o.@y, 1.3, 0.95));
				}
			}
			
			// Tiles Above Deco
			if (xml.roof[0])
			{
				for each (o in xml.roof[0].tile) 
				{
					aboveTiles.setTile(o.@x / G.grid, o.@y / G.grid, (G.TILESET_NB_COLUMNS * (o.@ty/G.grid)) + (o.@tx/G.grid));
				}
			}
			
			pathFinding = new FlxPathFinding(grid);
		}
	}
}