package entities
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class Raven extends Sprite
	{
		
		public var currentTarget:int = 0;
		public var canMove:Boolean = true;
		public var validTargets:Array = new Array();
		
		public function Raven()
		{
			// creating a new shape instance
			var circle:Shape = new Shape( ); 
			// starting color filling
			circle.graphics.beginFill(0xffffff);
			circle.graphics.lineStyle(1,0,1,false);
			// drawing circle 
			circle.graphics.drawCircle(0,0, 25);
			// adding displayobject to the display list
			addChild( circle ); 
		
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			if(this.canMove == true)
			{
				this.startDrag();
				
				this.parent.setChildIndex(this, this.parent.numChildren -1);
			}
			
			//trace("raven on: ",this.currentTarget);
			
		}
		
		private function mouseOver(e:MouseEvent):void
		{
			if(Board(this.parent).getPhase() == 2)
			{
				this.setValidTargets();
				Board(this.parent).showTargets(this);
			}
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			var lastX:Number = this.x;
			var lastY:Number = this.y;
			var lastTarget:int = this.currentTarget;
			
			this.stopDrag();

			if(Object(this.dropTarget.parent).constructor == "[class Target]")
			{
				this.currentTarget = Target(this.dropTarget.parent).getNumber();
				//trace("soltando en un target... nuevo target: ", this.currentTarget);
			//	trace("movimiento legal, me acomodo en nuevo target...");
				//trace("ip");
				this.x = this.dropTarget.parent.x;
				this.y = this.dropTarget.parent.y;
				
				//trace("raven on: ",this.currentTarget);
				//	Target(this.dropTarget.parent).setOccupant("Raven");
				//trace(" sobre-> ",Object(this.dropTarget.parent).constructor);
				//trace("raven on: ", this.currentTarget);
			
				Board(this.parent).updateBoard();
				
				if(Board(this.parent).getPhase() == 2)
					validateMove(lastTarget, lastX, lastY);
				
			}//estoy sobre un target
		}//function mouseUp
	
		private function validateMove(lastTarget:int, lastX:Number, lastY:Number):void
		{
			this.setValidTargets();
		}
		
		public function setValidTargets():void
		{
			this.validTargets = [];
			Board(this.parent).updateBoard();
			var availableTargets:Array = Board(this.parent).map.getValue(this.currentTarget);
			
			for(var i:int = 0; i < availableTargets.length; i++)
			{
				if(Board(this.parent).board[availableTargets[i]] == 0)
				{
					this.validTargets.push(availableTargets[i]);					
				}
			}
			trace("valid targets: ",this.validTargets);
		}
		
	}//class Raven
}//package
