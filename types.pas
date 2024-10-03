unit types;

interface

type Tmunition = record
	nbRebonds,Vx,Vy,x,y:integer;
end;

Type tank = record
	nomT: String;
	Vx,Vy,degats,Pv,x,y :integer;
	Munition:Tmunition;
	end;
	
type obstacle = record
	x,y:integer;
	end;
	
type carte = record
	Largeur,hauteur: integer;
	Tobstacles: array of array of obstacle;
	end;
	
type joueur=record
	nom:string;
	t:tank;
	score:integer
	end;

type Ttank = array [1..3] of tank;

procedure iniT(var T:Ttank);

procedure iniScore(var j1,j2:joueur);

implementation

procedure iniT(var T:Ttank);

BEGIN
	T[1].nomT:='Vic';
	T[1].degats:=50;
	T[1].Pv:=150;
	T[2].nomT:='JM';
	T[2].degats:=80;
	T[2].Pv:=110;
	T[3].nomT:='Tom';
	T[3].degats:=100;
	T[3].Pv:=60;
END;

procedure iniScore(var j1,j2:joueur);

begin
	j1.score:=0;
	j2.score:=0;
end;



end.
