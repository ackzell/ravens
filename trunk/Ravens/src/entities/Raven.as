package entities
{
	import com.greensock.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	
	public class Raven extends Sprite
	{
		/**
		 * El target (la casilla) en la que se encuentra el buitre actualmente.
		 * */
		public var currentTarget:int = 0;
		
		/**
		 * Determina si el cuervo se puede mover. (ser arrastrado)
		 * 
		 * */
		public var canMove:Boolean = true;
		
		/**
		 * Arreglo de targets (casillas) a las que se puede mover el arreglo.
		 * */
		public var validTargets:Array = new Array();
		
		/**
		 * Constructor de la clase.
		 * Dibuja el cuervo en el stage.
		 * Agrega los listeners al objeto para que pueda ser arrastrado.
		 * 
		 * */
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
		
			//adding some event listeners so we can drag it
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}
		
		/**
		 * Mientras el mouse está presionado.
		 * Sólo permite arrastrar, y se trae encima de todos los elementos en el stage. 
		 * */
		private function mouseDown(e:MouseEvent):void
		{
			
			//si el cuervo está en posición de moverse
			if(this.canMove == true)
			{
				//if(Board(this.parent).turno == 1)
				//{
					//se arrastra
					this.startDrag();
					//trayendo encima de todo
					this.parent.setChildIndex(this, this.parent.numChildren -1);
					//cambiando el turno para que le toque al buitre
				//}
			}
			
			//trace("raven on: ",this.currentTarget);
			
		}
		
		/**
		 * Cuando el puntero pasa por encima del cuervo.
		 * Muestra los lugares a los que se puede mover el cuervo.
		 * */
		private function mouseOver(e:MouseEvent):void
		{
		//	if(Board(this.parent).turno == 1)
			//determinando si estamos en la fase de mover
			if(Board(this.parent).getPhase() == 2)
			{
				//actualizando la lista de casillas disponibles y legales
				this.setValidTargets();
				//haciendo que se muestren en la parte gráfica
				Board(this.parent).showTargets(this);
			}
		}
		
		/**
		 * Cuando el mouse se libera.
		 * */
		private function mouseUp(e:MouseEvent):void
		{
			
			var newX:Number;
			var newY:Number;
			
			var found:Boolean = false;
			
			this.stopDrag();
			
			//estoy sobre un target
			if(Object(this.dropTarget.parent).constructor == "[class Target]")
			{
				//Estoy en fase 2	
				if((Board(this.parent).getPhase() == 2))
				{
					Board(this.parent).updateBoard();
					this.setValidTargets();
					
					//recorriendo los targets válidos del cuervo actual	
					for(var u:int = 0; u < this.validTargets.length; u++)
					{
						//si lo encuentra en válido
						if(Target(this.dropTarget.parent).getNumber() == validTargets[u])
						{
							//trace("target numero: ", Target(this.dropTarget.parent).getNumber(), "valid targets[",u,"]",validTargets[u]);
							//trace("FASE 2 \ntarget encontrado en válidos.... soltando...");
							//lo acomoda y actualiza el target que tiene el cuervo
							this.currentTarget = Target(this.dropTarget.parent).getNumber();
							this.x = this.dropTarget.parent.x;
							this.y = this.dropTarget.parent.y;
							found = true;		
							Board(this.parent).turno--;
							trace(Board(this.parent).turno);
							
							break;
						}
						
						
					}
					//si nunca lo encontró
					if(found == false)
					{
						//regresa al target de donde vino
						//trace("FASE 2 \ntarget NO encontrado ... regresa...");
						newX = Target(Board(this.parent).targetArr[this.currentTarget - 1]).x;
						newY = Target(Board(this.parent).targetArr[this.currentTarget - 1]).y;
						
						TweenLite.to(this, 0.5, {x: newX, y: newY});
					}
				}
				else//estoy en fase 1
				{
					
				//	trace("FASE 1 \nsólo acomodo... soltando...");
					this.currentTarget = Target(this.dropTarget.parent).getNumber();
					this.x = this.dropTarget.parent.x;
					this.y = this.dropTarget.parent.y;
					
					Board(this.parent).turno--;
					trace(Board(this.parent).turno);
				}
		
			}//estoy sobre un target
			else //NO estoy sobre un target
			{
				//estoy en fase 2, regreso a la posición de donde vengo
				if((Board(this.parent).getPhase() == 2))
				{
					newX = Target(Board(this.parent).targetArr[this.currentTarget - 1]).x;
					newY = Target(Board(this.parent).targetArr[this.currentTarget - 1]).y;
					
					TweenLite.to(this, 0.5, {x: newX, y: newY});
				}
			}
			
			//Board(this.parent).checkState();
			
		}//function mouseUp
	
		
		/**
		 * le guarda al raven los targets que puede llegar
		 * */
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
		
		/**
		 * mueve el cuervo a un target deseado.
		 * @param target la casilla donde se quiere colocar el cuervo
		 * 
		 * */
		public function moveToTarget(target:int):void
		{
			var newX:Number;
			var newY:Number;
			
			newX = Target(Board(this.parent).targetArr[target-1]).x;
			newY = Target(Board(this.parent).targetArr[target-1]).y;
			
			TweenLite.to(this, 0.5, {x: newX, y: newY});
			this.currentTarget = target;
			
		}
		
	}//class Raven
}//package
