package
{	
	import Playtomic.Log;
	
	import entities.*;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx2;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	import net.flxpunk.FlxEntity;
	import net.flxpunk.FlxPath;
	import net.flxpunk.FlxPathFinding;
	
	public class Game2 extends World
	{
		public var grid:Grid;
		public var pf:FlxPathFinding;
		public var unit:Zombie;
		public var unit2:Zombie;
		
		private var timer:Number = 0;
		
		public var tileset:Tilemap;
		public var tilesRoof:Tilemap;
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
			
			add(G.level = new Level(Assets.TEST1));
			
			add(G.lighting = new Lighting());
			
			G.level.load();
			
			// create an unit
			unit = new Zombie(400, 200);
			add(unit);
			unit2 = new Zombie(200, 200);
			add(unit2);
		}
		
		override public function update():void
		{
			super.update();
		}
		
	}
}