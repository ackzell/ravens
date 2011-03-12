package entities
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class Raven extends Sprite
	{
		
		public var targetNumber:int = 0;
		
		public function Raven()
		{
			// creating a new shape instance
			var circle:Shape = new Shape( ); 
			// starting color filling
			circle.graphics.beginFill(0xffffff,0.5);
			//circle.graphics.lineStyle( 1, 0, 0, true );
			circle.graphics.lineStyle(1,0,1,false);
			// drawing circle 
			circle.graphics.drawCircle(0,0, 25);
			// adding displayobject to the display list
			addChild( circle ); 
		
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp); 
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			this.startDrag();
			this.parent.setChildIndex(this, this.parent.numChildren -1);
			
			//trace("raven on: ",this.targetNumber);
			
			if(Board(this.parent).getPhase() == 2)
				Board(this.parent).showTargets(this);
		}
		
		
		private function mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
			
			if(Object(this.dropTarget.parent).constructor == "[class Target]")
			{
				//trace("ip");
				this.x = this.dropTarget.parent.x;
				this.y = this.dropTarget.parent.y;
				this.targetNumber = Target(this.dropTarget.parent).getNumber();
			//	Target(this.dropTarget.parent).setOccupant("Raven");
				//trace(" sobre-> ",Object(this.dropTarget.parent).constructor);
				//trace("raven on: ", this.targetNumber);
				Board(this.parent).updateBoard();
				
			}
			
			
		}
	}
}