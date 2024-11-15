unit types;

interface

type Mun=record
	nbRebonds,Vx,Vy,x,y:integer;
end;
type Tabmunition = array[1..5] of Mun;
	


Type tank = record
	nomT: String;
	degats,Pv,x,y:integer;
	posx,posy:real;
	Vitesse:Real;
	direction:real;
	Munitions:Tabmunition;
	end;
	


type tobst= array[1..12,1..8] of string;
type listecarte=array[1..3] of tobst;

type carte = record
	Largeur,hauteur: integer;
	Tob: tobst
	end;
	
type joueur=record
	nom:string;
	t:tank;
	score:integer
	end;

type Ttank = array [1..3] of tank;

procedure iniT(var T:Ttank);

procedure iniScore(var j1,j2:joueur);

procedure inicarte1(var car:tobst);
procedure inicarte2(var car:tobst);
procedure inicarte3(var car:tobst);

procedure inicartes(car1,car2,car3:tobst;var tabcar:listecarte);

implementation

procedure iniT(var T:Ttank);

BEGIN
	T[1].nomT:='Vic';
	T[1].degats:=50;
	T[1].Pv:=150;
	T[1].Vitesse:=0.5;
	T[2].nomT:='JM';
	T[2].degats:=80;
	T[2].Pv:=110;
	T[2].Vitesse:=0.75;  //initialisation des valeurs des tanks
	T[3].nomT:='Tom';
	T[3].degats:=100;
	T[3].Pv:=60;
	T[3].Vitesse:=1.0;
END;

procedure iniScore(var j1,j2:joueur);

begin
	j1.score:=0;
	j2.score:=0;       //initialisation des scores
end;

procedure inicarte1(var car:tobst);// on initialise les obstacles des cartes

begin
	car[1][1] := 'x';
	car[2][1] := 'x';
	car[12][1] := 'x';
	car[6][2] := 'x';
	car[7][2] := 'x';
	car[2][4] := 'x';
	car[11][4] := 'x';
	car[2][5] := 'x';
	car[11][5] := 'x';
	car[4][6] := 'x';
	car[5][6] := 'x';
	car[8][6] := 'x';
	car[9][6] := 'x';
	car[1][7] := 'x';
	car[6][7] := 'x';
	car[7][7] := 'x';
	car[12][7] := 'x';
	car[1][8] := 'x';
	car[2][8] := 'x';
	car[12][8] := 'x';
		
end;

procedure inicarte2(var car:tobst);

begin
	car[2][2] := 'x';
	car[3][2] := 'x';
	car[6][2] := 'x';
	car[11][2] := 'x';
	car[3][3] := 'x';
	car[4][3] := 'x';
	car[5][3] := 'x';
	car[6][3] := 'x';
	car[10][3] := 'x';
	car[11][3] := 'x';
	car[10][4] := 'x';
	car[2][5] := 'x';
	car[5][5] := 'x';
	car[6][5] := 'x';
	car[7][5] := 'x';
	car[8][5] := 'x';
	car[2][6] := 'x';
	car[8][6] := 'x';
	car[2][7] := 'x';
	car[3][7] := 'x';
	car[11][7] := 'x';
	car[12][7] := 'x';
	car[11][8] := 'x';
	car[12][8] := 'x';
end;

procedure inicarte3(var car:tobst);

begin
	car[6][1] := 'x';
	car[7][1] := 'x';
	car[10][1] := 'x';
	car[2][2] := 'x';
	car[3][2] := 'x';
	car[4][2] := 'x';
	car[10][2] := 'x';
	car[2][3] := 'x';
	car[3][3] := 'x';
	car[7][3] := 'x';
	car[6][4] := 'x';
	car[7][4] := 'x';
	car[10][4] := 'x';
	car[11][4] := 'x';
	car[2][5] := 'x';
	car[3][5] := 'x';
	car[4][5] := 'x';
	car[5][5] := 'x';
	car[6][5] := 'x';
	car[1][7] := 'x';
	car[2][7] := 'x';
	car[5][7] := 'x';
	car[6][7] := 'x';
	car[7][7] := 'x';
	car[8][7] := 'x';
	car[9][7] := 'x';
	car[10][7] := 'x';
	car[1][8] := 'x';
end;

procedure inicartes(car1,car2,car3:tobst;var tabcar:listecarte);

begin
	inicarte1(car1);
	inicarte2(car2);
	inicarte3(car3);
	tabcar[1]:=car1;
	tabcar[2]:=car2;
	tabcar[3]:=car3;
end;
end.


end.

