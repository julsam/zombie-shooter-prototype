package hud 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	public class HUD extends Entity 
	{
		static public const HUD_LAYER:int = -FP.height;
		public var healthBar:HealthBarEntity;
		
		public function HUD() 
		{
			FP.world.add(healthBar = new HealthBarEntity(10, 10));
		}
		
		override public function update():void
		{
		}
	}
}