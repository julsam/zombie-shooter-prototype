package entities
{
	import net.flashpunk.Entity;
	
	public class BaseWeapon extends Entity
	{
		protected var chamber:int;
		protected var damage:Number;
		protected var fireRate:Number;
		protected var reloadDuration:Number;
		
		public function BaseWeapon(x:Number=0, y:Number=0)
		{
			super(x, y);
		}
		
		public function fire():void
		{
			
		}
	}
}