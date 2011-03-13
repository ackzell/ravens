package entities
{
	import mx.core.INavigatorContent;

	public class compu_chafa
	{
		public var estrella:Array = new Array(new Number);
		public var no_cue:int;
		public var cont:int = 1;
		
		public function compu_chafa (estrella:Array,no_cue:int){
			this.estrella=estrella;
			this.no_cue=no_cue;
		}
		
		public function coloca_cuervo():Array{
			for(var x:int=1;x<=10;x++){
				if(estrella[x]==1){
					cont++;	
				}
			}						
			if(cont<=no_cue){
				trace("cuervo recibe: "+estrella);
				var i:int = asigna(estrella);
				estrella[i]=1;
			}
			else{
				var mov_cuervo:Array;
				trace("cuervo recibe: "+estrella);
				mov_cuervo = mueve_cuervo(estrella);
				estrella[mov_cuervo[0]]=0;
				estrella[mov_cuervo[1]]=1;
			}
					
			return estrella;
		}
		public function coloca_buitre():Array{
			var bEn:int;
			for(var x:int=1;x<=10;x++){
				if(estrella[x]==2){
					cont++;
					bEn=x;
				}
			}
			if(cont<=1){
				trace("buitre recibe: "+estrella);
				var i:int = asigna(estrella);
				estrella[i]=2;
			}
			else{
				var mov_buitre:Array;
				trace("buitre recibe: "+estrella+" con buitre en: "+bEn);
				mov_buitre = mueve_buitre(estrella,bEn);
			//	trace("mov_buitre[0]: "+mov_buitre[0]+"\n"+"mov_buitre[1]: "+mov_buitre[1]+"\n"+"mov_buitre[2]: "+mov_buitre[2]);
				if(mov_buitre[2]==11){
					estrella[mov_buitre[0]]=0;
					estrella[mov_buitre[1]]=2;
				}
				else{
					estrella[mov_buitre[0]]=0;
					estrella[mov_buitre[2]]=2;
					estrella[mov_buitre[1]]=0;
					
					estrella[20]=mov_buitre[0];
					estrella[21]=mov_buitre[1];
					estrella[22]=mov_buitre[2];
					
					estrella[23]=true;
				}
								
			} 
			return estrella;
		}
		public function sigue_comiendo(estados:Array,array:Array):Array{
			var i:int=estados[0];
			var j:int=estados[1];
			var k:int=estados[2];
			array[23]=false;
			
			if(i==1){
				if(array[10]==1){
					if(k==8 && array[2]==0){
						i=8;
						j=10;
						k=2;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
					else if(k==9 && array[5]==0){
						i=9;
						j=10;
						k=5;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
				}
			}
			if(i==2){
				if(array[6]==1){
					if(k==7 && array[3]==0){
						i=7;
						j=6;
						k=3;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
					else if(k==8 && array[1]==0){
						i=8;
						j=6;
						k=1;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
				}
			}
			if(i==3){
				if(array[9]==1){
					if(k==7 && array[2]==0){
						i=7;
						j=9;
						k=2;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
					else if(k==10 && array[4]==0){
						i=10;
						j=9;
						k=4;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
				}
			}
			if(i==4){
				if(array[8]==1){
					if(k==6 && array[5]==0){
						i=6;
						j=8;
						k=5;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
					else if(k==10 && array[3]==0){
						i=10;
						j=8;
						k=3;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
				}
			}
			if(i==5){
				if(array[7]==1){
					if(k==6 && array[1]==0){
						i=6;
						j=7;
						k=1;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
					else if(k==9 && array[4]==0){
						i=9;
						j=7;
						k=4;
						array[23]=true;
						array[i]=0;
						array[k]=2;
						array[j]=0;
						
						array[20]=i;
						array[21]=j;
						array[22]=k;
						return[array];
					}
				}
			}
			if(i==6){
				if(k==4 && array[9]==1 && array[10]==0){
					i=4;
					j=9;
					k=10;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
				if(k==5 && array[10]==1 && array[9]==0){
					i=5;
					j=10;
					k=9;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
			}
			if(i==7){
				if(k==2 && array[10]==1 && array[8]==0){
					i=2;
					j=10;
					k=8;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
				if(k==3 && array[8]==1 && array[10]==0){
					i=3;
					j=8;
					k=10;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
			}
			if(i==8){
				if(k==1 && array[7]==1 && array[9]==0){
					i=1;
					j=7;
					k=9;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
				if(k==2 && array[9]==1 && array[7]==0){
					i=2;
					j=9;
					k=7;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
			}
			if(i==9){
				if(k==1 && array[6]==1 && array[8]==0){
					i=1;
					j=6;
					k=8;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
				if(k==5 && array[8]==1 && array[6]==0){
					i=5;
					j=8;
					k=6;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
			}
			if(i==10){
				if(k==3 && array[6]==1 && array[7]==0){
					i=3;
					j=6;
					k=7;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
				if(k==4 && array[7]==1 && array[6]==0){
					i=4;
					j=7;
					k=6;
					array[23]=true;
					array[i]=0;
					array[k]=2;
					array[j]=0;
					
					array[20]=i;
					array[21]=j;
					array[22]=k;
					return[array];
				}
			}
			array[23]=false;
			array[i]=0;
			array[k]=2;
			array[j]=0;
			
			array[20]=i;
			array[21]=j;
			array[22]=k;
			return[array];
		}
		public function rand():int{
			var i:int;
			i= Math.round((Math.random()*10));
			if(i==0){
				return rand();
			}
			else{
				return i;
			}
		}
		public function rand_acot(lowNumber:int,highNumber:int):int{
			var thisNumber:int = highNumber - lowNumber; 
			var randomUnrounded:Number = Math.random() * thisNumber;
			var randomNumber:int = Math.round(randomUnrounded); 
			randomNumber += lowNumber;
			return randomNumber;
		} 
		
		public function asigna(array:Array):int{
			var i:int=rand();
			if(array[i]==0){
				return i;
			}
			else{
				return asigna(array);
			}
		}
		public function mueve_buitre(array:Array,x:int):Array{
			var i:int=x;
			var j:int;
			var k:int=11;
			
			if(i==1){
				j = rand_acot(1,2);
				if(j==1){
					j=7;
					if(array[j]==1){
						if(array[9]==0){
							return [i,j,9];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==2){
					j=6;
					if(array[j]==1){
						if(array[8]==0){
							return [i,j,8];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
			
			if(i==2){
				j = rand_acot(1,2);
				if(j==1){
					j=9;
					if(array[j]==1){
						if(array[7]==0){
							return [i,j,7];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==2){
					j=10;
					if(array[j]==1){
						if(array[8]==0){
							return [i,j,8];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];					
			}
			if(i==3){
				j = rand_acot(1,2);
				if(j==1){
					j=8;
					if(array[j]==1){
						if(array[10]==0){
							return [i,j,10];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==2){
					j=6;
					if(array[j]==1){
						if(array[7]==0){
							return [i,j,7];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
			if(i==4){
				j = rand_acot(1,2);
				if(j==1){
					j=7;
					if(array[j]==1){
						if(array[6]==0){
							return [i,j,6];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==2){
					j=9;
					if(array[j]==1){
						if(array[10]==0){
							return [i,j,10];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
			if(i==5){
				j = rand_acot(1,2);
				if(j==1){
					j=10;
					if(array[j]==1){
						if(array[9]==0){
							return [i,j,9];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==2){
					j=8;
					if(array[j]==1){
						if(array[6]==0){
							return [i,j,6];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
			if(i==6){
				j = rand_acot(1,4);
				if(j==1){
					j=1;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==2){
					j=8;
					if(array[j]==1){
						if(array[5]==0){
							return [i,j,5];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==3){
					j=3;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==4){
					j=7
					if(array[j]==1){
						if(array[4]==0){
							return [i,j,4];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
			if(i==7){
				j = rand_acot(1,4);
				if(j==1){
					j=1;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==2){
					j=9;
					if(array[j]==1){
						if(array[2]==0){
							return [i,j,2];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==3){
					j=6;
					if(array[j]==1){
						if(array[3]==0){
							return [i,j,3];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==4){
					j=4;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				return [i,j,k];
			}
			if(i==8){
				j = rand_acot(1,4);
				if(j==1){
					j=5;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==2){
					j=6;
					if(array[j]==1){
						if(array[1]==0){
							return [i,j,1];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==3){
					j=3;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==4){
					j=10
					if(array[j]==1){
						if(array[2]==0){
							return [i,j,2];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
			if(i==9){
				j = rand_acot(1,4);
				if(j==1){
					j=10;
					if(array[j]==1){
						if(array[5]==0){
							return [i,j,5];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==2){
					j=2;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==3){
					j=7;
					if(array[j]==1){
						if(array[1]==0){
							return [i,j,1];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==4){
					j=4;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				return [i,j,k];
			}
			else{
				j = rand_acot(1,4);
				if(j==1){
					j=5;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==2){
					j=2;
					if(array[j]==0){
						return [i,j,k];
					}
					else{
						return mueve_buitre(array,x);
					}
				}
				else if(j==3){
					j=8;
					if(array[j]==1){
						if(array[3]==0){
							return [i,j,3];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				else if(j==4){
					j=9
					if(array[j]==1){
						if(array[4]==0){
							return [i,j,4];
						}
						else{
							return mueve_buitre(array,x);
						}
					}
					else{
						return [i,j,k];
					}
				}
				return [i,j,k];
			}
		}
		public function mueve_cuervo(array:Array):Array{
			var i:int=rand();
			var j:int;
			if(array[i]==0 || array[i]==2){
				return mueve_cuervo(array);
			}
			else{
				if(i==1){
					j = rand_acot(1,2);
					if(j==1){
						j=7;
					}
					else if(j==2){
						j=6;
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==2){
					j = rand_acot(1,2);
					if(j==1){
						j=9;
					}
					else if(j==2){
						j=10;
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];					
				}
				if(i==3){
					j = rand_acot(1,2);
					if(j==1){
						j=8;
					}
					else if(j==2){
						j=6;
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==4){
					j = rand_acot(1,2);
					if(j==1){
						j=7;
					}
					else if(j==2){
						j=9;
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==5){
					j = rand_acot(1,2);
					if(j==1){
						j=10;
					}
					else if(j==2){
						j=8;
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==6){
					j = rand_acot(1,4);
					if(j==1){
						j=1;
					}
					else if(j==2){
						j=8;
					}
					else if(j==3){
						j=3;
					}
					else if(j==4){
						j=7
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==7){
					j = rand_acot(1,4);
					if(j==1){
						j=1;
					}
					else if(j==2){
						j=9;
					}
					else if(j==3){
						j=6;
					}
					else if(j==4){
						j=4
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==8){
					j = rand_acot(1,4);
					if(j==1){
						j=5;
					}
					else if(j==2){
						j=6;
					}
					else if(j==3){
						j=3;
					}
					else if(j==4){
						j=10
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				if(i==9){
					j = rand_acot(1,4);
					if(j==1){
						j=10;
					}
					else if(j==2){
						j=2;
					}
					else if(j==3){
						j=7;
					}
					else if(j==4){
						j=4
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
				else{
					j = rand_acot(1,4);
					if(j==1){
						j=5;
					}
					else if(j==2){
						j=2;
					}
					else if(j==3){
						j=8;
					}
					else if(j==4){
						j=9
					}
					if(array[j]==1 || array[j]==2){
						return mueve_cuervo(array);
					}
					return [i,j];
				}
			}
		}
	}
}