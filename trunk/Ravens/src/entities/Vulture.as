package entities
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class Vulture extends Sprite
	{
		public var targetNumber:int;
		
		public function Vulture()
		{
			// creating a new shape instance
			var circle:Shape = new Shape( ); 
			// starting color filling
			circle.graphics.beginFill( 0x000000 );
			
			//circle.graphics.lineStyle( 1, 0, 0, true );
			circle.graphics.lineStyle(1,0,1,false);
			// drawing circle 
			circle.graphics.drawCircle(0,0, 25);
			// repositioning shape
			//circle.x = 40;                                 
			//circle.y = 40;
			
			// adding displayobject to the display list
			addChild( circle ); 
		
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp); 
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			this.startDrag();
			this.parent.setChildIndex(this, this.parent.numChildren -1);
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			this.stopDrag();
			
			//trace("sobre->",Object(this.dropTarget.parent).constructor);
			if(Object(this.dropTarget.parent).constructor == "[class Target]")
			{
				//trace("ip");
				this.x = this.dropTarget.parent.x;
				this.y = this.dropTarget.parent.y;
				this.targetNumber = Target(this.dropTarget.parent).getNumber();
			//	Target(this.dropTarget.parent).setOccupant("Vulture");
				//trace(" sobre-> ",Object(this.dropTarget.parent).constructor);
				trace("Vulture on: ", this.targetNumber);
				Board(this.parent).updateBoard();
			}
		}
	}
}