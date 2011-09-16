package
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
	
	public class EmitterEntity extends Entity
	{		
		public var emitter:Emitter;
		private var particle_count:Number = 30;
		private var timer:Number = 0;
		
		public function EmitterEntity(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			this.layer = -1;
			this.type = "EmitterEntity";
			
			this.emitter = new Emitter(this.particle);
			this.emitter.newType('explode', [0]);
			this.emitter.setMotion('explode', 0, 0, 0.2, 360, 20, 0.8, Ease.circOut);
			this.emitter.setAlpha("explode", 1, 0.5, Ease.circOut);
			this.emitter.setGravity('explode', 0.1);
			this.graphic = this.emitter;
			
			explode(0, 0);
		}
		
		private function get particle():BitmapData
		{
			var data:BitmapData = new BitmapData(1, 1, false, 0xFF0000);
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
			for(var i:int = 0; i < this.particle_count; i++) {
				this.emitter.emit('explode', x, y);
			}
		}
	}
}