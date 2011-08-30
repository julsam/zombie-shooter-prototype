package
{
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;

	
	public class EmitterEntity extends Entity
	{		
		private var emitter:Emitter;
		private var particle_count:Number = 30;
		private var timer:Number = 0;
		
		public function EmitterEntity(x:Number, y:Number):void
		{
			this.x = x;
			this.y = y;
			layer = -1;
			emitter = new Emitter(this.particle);
			this.graphic = emitter;
			
			emitter.newType('explode', [0]);
			emitter.setMotion('explode', 0, 0, 0.2, 360, 20, 0.8, Ease.circOut);
			emitter.setAlpha("explode", 1, 0.5,Ease.circOut);
			emitter.setGravity('explode', 0.1);
			
			trace(x, y);
			explode(0, 0);
		}
		
		private function get particle():BitmapData
		{
			var data:BitmapData = new BitmapData(1,1,false,0xFF0000);
			return data;
		}
		
		override public function update():void
		{
			timer += FP.elapsed;
			if( timer > 1.2 ) // total duration before remove()
			{
				FP.world.remove(this);
			}
		}
		
		private function explode(x:Number, y:Number):void
		{
			trace("explosion");
			for(var i:int = 0; i < particle_count; i++) {
				emitter.emit('explode', x, y);
			}
		}
	}
}