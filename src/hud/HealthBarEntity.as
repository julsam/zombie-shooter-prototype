package hud
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
    
    public class HealthBarEntity extends Entity
    {
        public var bar:Image = new Image(Assets.HEALTHBAR);
		public var placeholder:Image = new Image(Assets.HEALTHBAR_PLACEHOLDER);
		protected var xOffset:Number;
		protected var yOffset:Number;
        
        public function HealthBarEntity(xOffset:Number, yOffset:Number) 
        {
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			layer = HUD.HUD_LAYER;
			
			bar.x = 3;
			bar.y = 3;
            this.graphic = new Graphiclist(placeholder, bar);
			
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			this.x = this.xOffset;
			this.y = this.yOffset;
        }
        
        override public function update():void 
        {
			bar.clear();
            bar.updateBuffer();
        }
		
		public function setHealth(remainingValuePercent:Number):void
		{
			var remainingBarPercent:Number = bar.width * (remainingValuePercent / 100);
			bar.clipRect.width = FP.clamp(remainingBarPercent, 0, bar.width);
		}
    }
}