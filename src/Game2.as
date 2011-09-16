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
			Input.define("Pause", Key.SPACE);
			
			add(G.level = new Level(Assets.TEST1));
			
			add(G.lighting = new Lighting());
			
			G.level.load();
			
			add(new Zombie(400, 200));
			add(new Zombie(200, 200));
		}
		
		override public function update():void
		{
			if (Input.released("Pause"))
			{
				G.pause = !G.pause;
			}
			
			if (!G.pause)
			{
				super.update();
			}
			else
			{
				var ea:Array = [];
				FP.world.getType("EmitterEntity", ea);
				for each (var _ee:EmitterEntity in ea)
				{
					_ee.emitter.active = false;
					_ee.emitter
				}
				
				var List:Array = [];
				FP.world.getType("menu", List);
				for each (var _menu:* in List)
				{
					_menu.update();
				}
			}
		}
		
	}
}