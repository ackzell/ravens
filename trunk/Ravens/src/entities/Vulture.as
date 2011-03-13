package entities
{
	import com.greensock.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class Vulture extends Sprite
	{
		public var currentTarget:int;
		
		/**
		 * Determina si el cuervo se puede mover. (ser arrastrado)
		 * 
		 * */
		public var canMove:Boolean = true;
		
		
		public var victims:Array = new Array();
		/**
		 * Arreglo de targets (casillas) a las que se puede mover el arreglo.
		 * */
		public var validTargets:Array = new Array();
		
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
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}
		
		/**
		 * Cuando el puntero pasa por encima del cuervo.
		 * Muestra los lugares a los que se puede mover el cuervo.
		 * */
		private function mouseOver(e:MouseEvent):void
		{
			//if(Board(this.parent).turno == 0)
			//{	
				//determinando si estamos en la fase de mover
				if(Board(this.parent).getPhase() == 2)
				{
					//actualizando la lista de casillas disponibles y legales
					this.setVictims();
					//haciendo que se muestren en la parte gráfica
					Board(this.parent).showVictims();
				}
			//}
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			//si el cuervo está en posición de moverse
			if(this.canMove == true)
			{
			//	if(Board(this.parent).turno == 0)
			//	{
					//se arrastra
					this.startDrag();
					//trayendo encima de todo
					this.parent.setChildIndex(this, this.parent.numChildren -1);
			//	}	
				
			}
			
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
				this.currentTarget = Target(this.dropTarget.parent).getNumber();
			//	Target(this.dropTarget.parent).setOccupant("Vulture");
				//trace(" sobre-> ",Object(this.dropTarget.parent).constructor);7
				Board(this.parent).turno++;
				trace(Board(this.parent).turno);
				
				trace("Vulture on: ", this.currentTarget);
				Board(this.parent).updateBoard();
			}
		}
		
		public function moveToTarget(target:int):void
		{
			var newX:Number;
			var newY:Number;
			
			newX = Target(Board(this.parent).targetArr[target-1]).x;
			newY = Target(Board(this.parent).targetArr[target-1]).y;
			
			TweenLite.to(this, 0.5, {x: newX, y: newY});
			
		}
		
		/**
		 * Actualiza las casillas disponibles para el buitre
		 * 
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
			//trace("valid targets: ",this.validTargets);
		}
		*/
		public function setVictims():void
		{
			Board(this.parent).updateBoard();
			
			//reseteando el arreglo de posibles víctimas
			this.victims = [];
			
			//var adjacencies:Array = Board(this.parent).map.getValue(this.currentTarget);
			var hops:Array = Board(this.parent).Vmap.getValue(this.currentTarget);
			
			var candidate1:Array = hops[0];
			var candidate2:Array = hops[1];
			
			if((Board(this.parent).board[candidate1[0]] == 1) && Board(this.parent).board[candidate1[1]] == 0)
				this.victims.push(candidate1[0]);
			
			if((Board(this.parent).board[candidate2[0]] == 1) && Board(this.parent).board[candidate2[1]] == 0)
				this.victims.push(candidate2[0]);
			
			trace("puedo comer a--> ",this.victims);
		}
		
		public function eatRaven():void
		{
			
		}
	}
}