package entities
{
	import collections.HashMap;
	
	import com.greensock.*;
	
	import flash.display.Shape;
	
	import mx.controls.Alert;
	import mx.core.UIComponent;
	import mx.graphics.RadialGradient;
	
	public class Board extends UIComponent
	{
		/**
		 * Mantiene el tablero lógico del juego.
		 * Cada posición del arreglo es una posición en el tablero.
		 * El arreglo puede guardar tres valores diferentes:
		 * 0 si la posición está vacía.
		 * 1 si hay un cuervo.
		 * 2 para el buitre.
		 */
		public var board:Array = new Array();
		/**
		 * Contiene las posiciones adyacentes en el tablero.
		 * Para la posición 1, se tiene el par (1, [6, 7]) dado que desde la posición 1 podría haber movimiento hacia la posición 6 o la 7.
		 * */
		public var map:HashMap;
		
		
		public var Vmap:HashMap;
		
		/**
		 * El arreglo que contiene a los cuervos.
		 * 
		 * @see entities.Raven 
		 */
		public var ravensArr:Array = new Array();
		
		/**
		 * Buitre
		 * @see entities.Vulture
		 * */
		public var vulture:Vulture = new Vulture();
		
		/**
		 * Fase en la que se encuentra el juego. Ya que el juego consta de dos fases, en concreto:
		 * Fase de acomodo: cuando no todos los cuervos han sido colocados en posición.
		 * Fase de movimiento: cuando los cuervos han sido acomodados y sólo pueden moverse de una casilla a otra.
		 * Se guarda una variable que permite guardar la fase en la que se encuentra el juego.
		 * */
		public var phase:int;
		
		/**
		 * Mantiene las casillas en el tablero.(Interfaz gráfica)
		 * */
		public var targetArr:Array = new Array();
		
		
		/**
		 * 1 para cuervos
		 * 0 para buitre
		 * */
		public var turno:int;
		
		public var inteligencia:Ai;
		
		/**
		 * Constructor de la clase.
		 * Coloca los "targets" en su posición en la interfaz gráfica.
		 * Crea la estrella para el tablero.
		 * Genera el mapa que contiene las adyacencias.
		 * Coloca los cuervos y el buitre fuera del tablero para poder comenzar con la fase 1 del juego (acomodar las fichas).
		 * @see entities.Raven
		 * @see entities.Vulture
		 * */
		public function Board()
		{
			/* fase de colocación de objetos*/
			phase = 1;
			
			/*empiezan cuervos */
			turno = 1;
			
			/* creando la estrella */
			var star:Shape = new Shape();
			addChild(star);
			
			star.graphics.lineStyle(4, 0x008080);
			star.graphics.moveTo(400, 52.312);
			star.graphics.lineTo(558.485, 547.688);
			star.graphics.lineTo(140.149, 239.308);
			star.graphics.lineTo(659.851, 239.308);
			star.graphics.lineTo(237.291, 547.688);
			star.graphics.lineTo(400, 52.312);
			
			//trace("poniendo targets");
			/* colocando los "targets" */
			var t1:Target = new Target(1);
			t1.x = 400;
			t1.y = 52.312;
			targetArr.push(t1);
			
			var t2:Target = new Target(2);
			t2.x = 558.485;
			t2.y = 547.688;
			
			targetArr.push(t2);
			
			var t3:Target = new Target(3);
			t3.x = 140.149;
			t3.y = 239.308;
			
			targetArr.push(t3);
			
			var t4:Target = new Target(4);
			t4.x = 659.851;
			t4.y = 239.308;
			targetArr.push(t4);
			
			var t5:Target = new Target(5);
			t5.x = 237.291;
			t5.y = 547.688;
			targetArr.push(t5);
			
			var t6:Target = new Target(6);
			t6.x = 338.652;
			t6.y = 240.673;
			targetArr.push(t6);
			
			var t7:Target = new Target(7);
			t7.x = 461.348;
			t7.y = 240.673;
			targetArr.push(t7);
			
			var t8:Target = new Target(8);
			t8.x = 299.930;
			t8.y = 357.102;
			targetArr.push(t8);
			
			var t9:Target = new Target(9);
			t9.x = 498.456;
			t9.y = 358.474;
			targetArr.push(t9);
			
			var t10:Target = new Target(10);
			t10.x = 400;
			t10.y = 429.907;
			targetArr.push(t10);
			
			
			for(var k:uint = 0; k < targetArr.length; k++)
			{
				var t:Target = new  Target(k+1);
				addChild(targetArr[k]);
				targetArr[k].drawTarget();
			}
			
			/*determinando casillas disponibles desde cada "vértice" */
			map = new HashMap();
			map.put(1, new Array(7, 6));
			map.put(2, new Array(9, 10));
			map.put(3, new Array(8, 6));
			map.put(4, new Array(7, 9));
			map.put(5, new Array(10, 8));
			map.put(6, new Array(7, 8, 1, 3));
			map.put(7, new Array(9,1,6,4));
			map.put(8, new Array(10,3,6,5));
			map.put(9, new Array(10,4,2,7));
			map.put(10, new Array(2,5,8,9));
			
			/*
			/*determinando casillas disponibles desde cada "vértice" 
			Vmap = new HashMap();
			Vmap.put(1 ,new Array(9,8));
			Vmap.put(2 ,new Array(7,8));
			Vmap.put(3 ,new Array(7,10));
			Vmap.put(4 ,new Array(10,6));
			Vmap.put(5 ,new Array(6,9));
			Vmap.put(6 ,new Array(4,5));
			Vmap.put(7 ,new Array(3,2));
			Vmap.put(8 ,new Array(1,2));
			Vmap.put(9 ,new Array(5,1));
			Vmap.put(10 ,new Array(3,4));

			*/
			
			// comida del buitre
			//par ([A, B], C) (de A a C se come a B)
			Vmap = new HashMap();
			Vmap.put([1,7], 9);
			Vmap.put([1,6], 8);
			Vmap.put([2,9], 7);
			Vmap.put([2,10],8);
			Vmap.put([3,6], 7);
			Vmap.put([3,8],10);
			Vmap.put([4,7], 6);
			Vmap.put([4,9],10);
			Vmap.put([5,8], 6);
			Vmap.put([5,10],9);
			Vmap.put([6,7], 4);
			Vmap.put([6,8], 5);
			Vmap.put([7,6], 3);
			Vmap.put([7,9], 2);
			Vmap.put([8,6], 1);
			Vmap.put([8,10],2);
			Vmap.put([9,7], 1);
			Vmap.put([9,10],5);
			Vmap.put([10,9],4);
			Vmap.put([10,8],3);
			
			
			
			/* Colocando los cuervos */
 			for(var i:int = 0; i < 7; i++)
			{
				ravensArr[i] = new Raven();
				ravensArr[i].x = 700;
				ravensArr[i].y = 300;
				
				addChild(ravensArr[i]);
				
				
			}
			
			/* colocando al buitre */
			vulture.x = 100;
			vulture.y = 300; 
			addChild(vulture);
			
			
			
			
			this.updateBoard();			
			
			PCvsPC();
			
			//inteligencia = new Ai();
			//ravensArr[1].moveToTarget(10);

		}
			
		/**
		 * Mantiene el estado del juego.
		 * Las posiciones de los cuervos y del buitre
		 * 
		 * */
		public function updateBoard():void
		{
			/* inicializando el arreglo lógico del tablero */
			for(i = 0; i <= 10; i++)
			{
				board[i] = 0;
			}
			//colocando un 1 en el arreglo si es que hay un cuervo
			for(var i:int = 0; i < 7; i++)
			{
				board[ravensArr[i].currentTarget] = 1;
				
			}
			//colocando un 2 en el arreglo donde está el buitre	
			board[vulture.currentTarget] = 2;
			
			//la primer posición del arreglo no se utiliza
			board[0] = 0;
			
		/*	for(i = 0; i <= 10; i++)
				trace("board[",i,"]: ",board[i]);
		*/	
				//trace("map goes like this --> ", map.getValue(j).sort(Array.NUMERIC));
			//}
		}
		
		public function getPhase():int
		{
		
			for(var x:int = 0; x < 7; x++)
				if(ravensArr[x].currentTarget == 0)
					return 1;
			return 2;
		}
		
		
		public function showTargets(bird:Object):void
		{
			var availableTargets:Array  = bird.validTargets; 
			
			bird.canMove = false;
			
			var timeline:TimelineMax = new TimelineMax();
			for(var i:int = 0; i < availableTargets.length; i++)
			{
					bird.canMove = true;
					timeline.insert(new TweenMax(targetArr[availableTargets[i]-1], 0.5 ,{glowFilter:{color:0xff0000, alpha:1, blurX:15, blurY:15}}));
					timeline.insert(new TweenMax(targetArr[availableTargets[i]-1], 0.5 ,{delay: 0.5,  glowFilter:{color:0xff0000, alpha:0, blurX:0, blurY:0}}));
			}
		}
		
		public function showVictims():void
		{
			trace(Vmap.getValue(this.vulture.currentTarget));
		}
		
		public function checkState():void
		{
			if (this.getPhase() == 2)
			{
				this.vulture.setVictims();
				//if((this.vulture.validTargets.length == 0) && (this.vulture.victims.length == 0))
				if((this.vulture.validTargets.length == 0))
					Alert.show("buitre pierde");
			}
		}
		
		public function PCvsPC():void
		{
			while(true)
			{
				if(getPhase()==1)//jugada cuervo
				{
					var x:int;
					for (x = 1; x <= 5 ; x++ )
					{
						if (board[x] == 0)
							break;
					}
					ravensArr[0].moveToTarget(x);
				}
				board[x] = 1;
				vulture.moveToTarget(inteligencia.cuervo());
			}
		}
	}
}