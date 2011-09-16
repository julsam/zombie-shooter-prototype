package entities
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Ease;
	
	import utils.Utils;
	
	public class Explosion extends Entity
	{		
		public var emitter:Emitter;
		private var particle_count:Number = 30;
		private var timer:Number = 0;
		
		public function Explosion(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			this.layer = -1;
			this.type = "Explosion";
			
			this.emitter = new Emitter(this.particle, 6, 6);
			this.emitter.newType('explode', [0, 0,0, 0, 1, 1,1, 1, 2, 2, 3, 3, 4, 5, 6]);
			this.emitter.setColor('explode', 0xFF9900, 0xFFFF55, Ease.backOut);
			this.emitter.setMotion('explode', 0, 10, 0.9, 360, 20, 0.8, Ease.expoOut);
			//this.emitter.setAlpha("explode", 1, 0.5, Ease.circOut);
			this.emitter.setGravity('explode', 0.1);
			this.graphic = this.emitter;
			this.emitter.newType('explode2', [0, 0,0, 0, 1, 1,1, 1, 2, 2, 3, 3, 4, 5, 6]);
			this.emitter.setColor('explode2', 0xFFFF00, 0xFFFFFF, Ease.backOut);
			this.emitter.setMotion('explode2', 0, 0, 0.9, 360, 20, 0.8, Ease.expoOut);
			//this.emitter.setAlpha("explode2", 1, 0.5, Ease.circOut);
			this.emitter.setGravity('explode2', 0.1);
			this.graphic = this.emitter;
			
			explode(0, 0);
		}
		
		private function get particle():Class
		{
			var data:Class = Assets.EXPLOSION;
			return data;
		}
		
		override public function update():void
		{
			this.timer += FP.elapsed;
			if (this.timer > 1.2) // total duration before remove()
			{
				FP.world.remove(this);
			}
		}
		
		private function explode(x:Number, y:Number):void
		{
			trace("explosion");
			var a:Array = new Array('explode', 'explode2');
			for(var i:int = 0; i < this.particle_count; i++) {
				this.emitter.emit(FP.choose(a), x, y);
			}
		}
	}
}