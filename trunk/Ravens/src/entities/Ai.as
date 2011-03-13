package entities
{
	import collections.HashMap;
	/**
	 * ...
	 * @author ...
	 */
	public class  Ai
	{
		public var tablero:Array;
		public var turno:int;
		public var max:int;
		public var min:int;
		public var tope:int;
		public var map:HashMap;
		public var a:int;
		public var Cuervos:Array;
		public var Buitre:Vulture;
		public var Vmap:HashMap;
		
		public function Ai(board:Array, mapa:HashMap, arreglo:Array, wey:Vulture, vmap:HashMap)
		{
			tablero = board;
			turno = 0;
			max = 8;
			min = -1;
			tope = 3;
			map = mapa;
			this.Cuervos = arreglo;
			this.Buitre = wey;
			this.Vmap = vmap;
		}
		
		public function cuervo():Array
		{
			var res:Array = new Array();
			res[0] = busqueda(0,0,tablero,0);
			res[1] = a;
			return res;
		}
		
		public function buitre():int
		{
			var res:int;			
			res = busqueda(0, 1, tablero, 1);
			return res;
		}
		
		public function busqueda(nivel:int, jugador:int, estado:Array, tipo:int):int
		{
			var dest:int;
			dest = -1;
			var valor:int;
			if(nivel%2 == 0	)
				valor = min;
			else
				valor = max;
			if (estado[0] >= 3)
			{
				if (tipo == 0)
					return min;
				else
					return max;
			}
			var x:int;
			var y:int;
			var z:int;
			if(ganador(estado)==true)
			{
				if (tipo == 0)
					return max;
				else
					return min;
			}
			if(nivel == tope)
			{
				var t:int = evaluacion(estado);
				if(tipo==0)
					return t;
				else
					return 8-t;
			}
			var caminos:Array;
			if (jugador == 1) // Buitre
			{
				if(turno == 1)
				{
					for (x = 1; x <= 10; x++ )
					{
						if(estado[x]==0)
						{
							var nuevo:Array = new Array();
							for ( z = 0; z <= 10; z++ )
							{
								nuevo[z] = estado[z];
							}
							nuevo[x]=2;
							var tmp:int = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);
							if (nivel % 2 == 1)
							{
								if (tmp <= valor)
								{
									valor = tmp;
									dest = x;
								}
							}
							else
							{
								if (tmp >= valor)
								{
									valor = tmp;
									dest = x;
								}
							}
						}
					}
				}
				else
				{
					for (x = 1; x <= 10; x++ )
					{
						if (estado[x] == 2)
						{						
							caminos = map.getValue(x);
							for ( y = 0; y < caminos.length; y++ )
							{
								if (estado[caminos[y]] == 0)
								{
									nuevo = new Array();
									for ( z = 0; z <= 10; z++ )
									{
										nuevo[z] = estado[z];
									}
									nuevo[caminos[y]] = 2;
									nuevo[x] = 0;
									tmp = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);
									if (nivel % 2 == 1)
									{
										if (tmp <= valor)
										{
											valor = tmp;
											dest = caminos[y];
										}
									}
									else
									{
										if (tmp >= valor)
										{
											valor = tmp;
											dest = caminos[y];
										}
									}
								}							
							}	
							var brincos:Array = Vmap.getValue(x);
							for( y = 0; y < brincos.length; y++)
							{
								if(estado[brincos[y][1]]==0&&estado[brincos[y][0]]==1)
								{
									nuevo = new Array();
									for ( z = 0; z <= 10; z++ )
									{
										nuevo[z] = estado[z];
									}
									nuevo[0]++;
									nuevo[brincos[y][1]] = 2;
									nuevo[x] = 0;
									nuevo[brincos[y][0]] = 0;
									tmp = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);
									if (nivel % 2 == 1)
									{
										if (tmp <= valor)
										{
											valor = tmp;
											dest = brincos[y][1];
										}
									}
									else
									{
										if (tmp >= valor)
										{
											valor = tmp;
											dest = brincos[y][1];
										}
									}
								}
							}
						}
					}
				}
			}
			else // Cuervo
			{
				if(turno+nivel<14)
				{
					for ( x = 1; x <= 10; x++ )
					{
						if(estado[x]==0)
						{
							nuevo = new Array();
							for ( z = 0; z <= 10; z++ )
							{
								nuevo[z] = estado[z];
							}
							nuevo[x] = 1;
							tmp = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);
							if (nivel % 2 == 1)
							{
								if (tmp <= valor)
								{
									valor = tmp;
									dest = x;
									a = 0;
								}
							}
							else
							{
								if (tmp >= valor)
								{
									valor = tmp;
									dest = x;
									a = 0;
								}
							}
						}
					}
				}
				else
				{
					for ( x = 1; x <= 10; x++ )
					{
						if (estado[x] == 1)
						{
							caminos = map.getValue(x);
							for ( y = 0; y < caminos.length; y++ )
							{
								if (estado[caminos[y]] == 0)
								{
									nuevo = new Array();
									for ( z = 0; z <= 10; z++ )
									{
										nuevo[z] = estado[z];
									}
									nuevo[caminos[y]] = 1;
									nuevo[x] = 0;
									tmp = busqueda(nivel + 1, (jugador + 1) % 2, nuevo, tipo);									
									if (nivel % 2 == 1)
									{
										if (tmp <= valor)
										{
											valor = tmp;
											dest = caminos[y];
											a = x;
										}
									}
									else
									{
										if (tmp >= valor)
										{
											valor = tmp;
											dest = caminos[y];
											a = x;
										}
									}
								}
							}
						}
					}
				}
			}
			if(nivel > 0)
				return valor;
			else
			{
				if(dest == -1)
					trace(turno," dest = 0: ",estado);
				return dest;
			}
		}
	
		public function evaluacion(estado:Array):int
		{
			var k:int = 0;
			var n:int = 0;
			for (var x:int = 1; x <= 10; x++ )
			{
				if (estado[x] == 2)
				{
					var caminos:Array = map.getValue(x);
					var y:int;
					for (y = 0; y < caminos.length; y++ )
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
			return n - k;	
		}
		public function ganador(estado:Array):Boolean
		{
			var x:int;
			for (x = 1; x <= 10; x++ )
			{
				if (estado[x] == 2)
				{
					var caminos:Array = map.getValue(x);
					var y:int;
					for (y = 0; y < caminos.length; y++ )
					{
						if (estado[caminos[y]] == 0)
							return false;
					}
					var brincos:Array = Vmap.getValue(x);
					for( y = 0; y < brincos.length; y++)
					{
						if(estado[brincos[y][1]]==0&&estado[brincos[y][0]]==1)
						{
							return false;							
						}
					}
					break;
				}				
			}
			if(x<11)
				return true;
			else
				return false;
		}	
	}
}