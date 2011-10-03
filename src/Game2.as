package
{	
	import hud.HUD;
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
	
	import utils.Utils;
	
	public class Game2 extends World
	{
		public var grid:Grid;
		public var pf:FlxPathFinding;
		public var iMonster:int = 0; // debug monster path queue
		
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
			Input.define("Pause", Key.P);
			Input.define("Mute", Key.M);
			Input.define("SlowMotion", Key.A);
			
			add(G.level = new Level(Assets.TEST1));
			
			if (G.lightingEnabled)
				add(G.lighting = new Lighting());
			
			G.level.load();
			
			add(G.hud = new HUD());
			
			//add(new Zombie(400, 200));
			//add(new Zombie(300, 250));
			var z:*;
			for (var j:int = 0; j < 10; j++)
			{
				add(z = new Zombie(FP.rand(FP.width), FP.rand(FP.height)));
				//add(z = new Zombie(300, 250));
				//G.monsters.push(z);
			}
		}
		
		override public function update():void
		{
			if (Input.pressed("SlowMotion"))
			{
				G.slowMotionActivated = !G.slowMotionActivated;
				FP.rate = FP.rate == 1 ? 0.5 : 1;
			}
			if (Input.released("Pause"))
			{
				if (G.pause)
					this.unpause();
				else
					this.pause();				
			}
			
			if (!G.pause)
			{
				super.update();
				
				// Update Flash FX
				Utils.flash.update();
			}
			else
			{
				var List:Array = [];
				FP.world.getType("menu", List);
				for each (var _menu:* in List)
				{
					_menu.update();
				}
			}
			// if entity.onCamera()
			/*
			if (G.monsters.length > 3)
			{	
				if (iMonster >= G.monsters.length)
					iMonster = 0;
				G.monsters[iMonster].updateRayPath();
				iMonster += 1;
			}
			else
			{
				if (iMonster >= G.monsters.length)
					iMonster = 0;
				G.monsters[iMonster].updateRayPath();
				iMonster += 1;
			}
			*/					
		}
		
		public static function removeMonsterFromPathList(m:BaseMonster):void
		{
			/*
			for (var i:int = 0; i < G.monsters.length; i++)
			{
				if (m == G.monsters[i])
				{
					//G.monsters[i].removed = true;
					G.monsters.splice(i, 1);
				}
			}
			*/
		}
		
		public function pause():void
		{			
			G.pause = true;			
			this.setEmittersActive("EmitterEntity", false);
			this.setEmittersActive("Explosion", false);
		}
		
		public function unpause():void
		{
			G.pause = false;			
			this.setEmittersActive("EmitterEntity", true);			
			this.setEmittersActive("Explosion", true);
		}
		
		override public function focusGained():void
		{
			//this.unpause();
		}
		
		override public function focusLost():void
		{
			//this.pause();
			
			// Fix sticking keys problem when focus is lost
			Input.clear();
		}
		
		public function setEmittersActive(typeName:String, isActive:Boolean):void
		{
			var list:Array = [];
			FP.world.getType(typeName, list);
			for each (var el:* in list)
			{
				el.emitter.active = isActive;
			}
		}
		
		override public function render():void
		{
			super.render();
			Utils.flash.render();
		}
		
	}
}