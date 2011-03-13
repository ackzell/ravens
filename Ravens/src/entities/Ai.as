package entities
{
	import collections.HashMap;
	/**
	 * ...
	 * @author ...
	 */
	public class  AI
	{
		var tablero:Array;
		var turno:int;
		var esquinas:Array;
		var max:int;
		var min:int;
		var tope:int;
		var map:HashMap;
		public function AI(board:Array,mapa:HashMap)
		{
			tablero = board;
			turno = 0;
			esquinas = new Array();
			max = 8;
			min = -1;
			tope = 3;
			map = mapa;
		}
		
		public function cuervo()
		{
			if (turno <= 8)
			{
				for (var x:int = 1; x <= 5 ; x++ )
				{
					if (tablero[x] == 0)
						break;
				}
				tablero[x] = 1;
			}
			else
			{
				busqueda(0,0,tablero,0);
			}
			turno++;
		}
		
		public function buitre()
		{
			if (turno == 1)
				tablero[Math.floor(Math.random() * (10)) + 1] = 2;
			else
				busqueda(0, 1, tablero, 1);
			turno++;
		}
		
		public function busqueda(nivel:int, jugador:int, estado:Array, tipo:int)
		{
			var valor:int;
			var des:int;
			if(nivel%2 == 0	)
				valor = min;
			else
				valor = max;
			if (estado[0] == 3)
			{
				if (tipo == 0)
					return min;
				else
					return max;
			}
			var x:int;
			for (x = 1; x <= 10; x++ )
			{
				if (estado[x] == 2)
				{
					caminos:Array = mapa.getValues(x);
					var y:int;
					for (y = 0; y < caminos.lenght; x++ )
					{
						if (estado[caminos[y]] == 0)
							break;
					}
					if (y == caminos.lenght)
					{
						if (tipo == 0)
							return max;
						else
							return min;
					}
					break;
				}
			}
			if(nivel == tope)
				return evaluacion(estado);
			arreglo:Array = new Array();
			if (jugador == 1) // Buitre
			{
				caminos:Array = mapa.getValues(x);
				for (var y:int = 0; y < caminos.lenght; x++ )
				{
					if (estado[caminos[y]] == 0)
					{
						nuevo:Array = new Array();
						for (var z:int = 0; z <= 10; z++ )
						{
							nuevo[z] = estado[z];
						}
						nuevo[caminos[y]] = 2;
						nuevo[x] = 0;
						var tmp:int = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);
						if (nivel % 2 == 1)
						{
							if (tmp < valor)
							{
								valor = tmp;
								des = caminos[y];
							}
						}
						else
						{
							if (tmp > valor)
							{
								valor = tmp;
								des = caminos[y];
							}
						}
					}
				}
			}
			else // Cuervo
			{
				for (var x:int = 1; x <= 10; x++ )
				{
					if (estado[x] == 1)
					{
						caminos:Array = mapa.getValues(x);
						for (var y:int = 0; y < caminos.lenght; x++ )
						{
							if (estado[caminos[y]] == 0)
							{
								nuevo:Array = new Array();
								for (var z:int = 0; z <= 10; z++ )
								{
									nuevo[z] = estado[z];
								}
								nuevo[caminos[y]] = 1;
								nuevo[x] = 0;
								var tmp:int = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);
								if (nivel % 2 == 1)
								{
									if (tmp < valor)
									{
										valor = tmp;
										des = caminos[y];
									}
								}
								else
								{
									if (tmp > valor)
									{
										valor = tmp;
										des = caminos[y];
									}
								}
							}
						}
						break;
					}
				}
			}
		}
		if(nivel > 0)
			return valor;
		else
			return dest;
	}
	
	public function evaluacion(estado:Array)
	{
		var k:int = 0;
		var n:int = 0;
		for (x = 1; x <= 10; x++ )
		{
			if (estado[x] == 2)
			{
				caminos:Array = mapa.getValues(x);
				var y:int;
				for (y = 0; y < caminos.lenght; x++ )
				{
					if (estado[caminos[y]] == 0)
						k++;
				}
			}
		}
		for (x = 1; x <= 10; x++ )
		{
			if (estado[x] == 1)
			{
				n++;
			}
		}
	}
	return n - k;	
}