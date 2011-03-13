package entities
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.filters.DropShadowFilter;
	
	public class Target extends Sprite
	{
		public var colorT:uint;
		private var number:int;
		
		public function Target(number:int, colorT:uint = 0x666666)
		{
			this.number = number;
			this.colorT = colorT;
			drawTarget();
		}
		
		public function getNumber():int
		{
			return this.number;
		}
		
		public function setColor(newColor:uint):void
		{
			this.colorT = newColor;
			this.drawTarget();
		}
		
		public function drawTarget():void
		{
			// creating a new shape instance
			var circle:Shape = new Shape( ); 
			// starting color filling
			circle.graphics.beginFill( colorT );
			
			circle.graphics.lineStyle( 1, 0, 0, true );
			
			// drawing circle 
			circle.graphics.drawCircle(0,0, 25);
			// repositioning shape
			//circle.x = 40;                                 
			//circle.y = 40;
			
			var myShadow:DropShadowFilter = new DropShadowFilter();
			myShadow.distance = 1;
			myShadow.color = 0x333333;
			myShadow.blurX = 7;
			myShadow.blurY = 7;
			myShadow.quality = 3;
			circle.filters = [myShadow];
			
			// adding displayobject to the display list
			addChild( circle ); 
		}
		

	}
}