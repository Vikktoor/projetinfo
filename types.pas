
unit types;

interface

uses SDL2, SDL2_image, SysUtils;

var  SDL_Rect: TSDL_Rect;

type Mun=record
    nbRebonds,x,y:integer;
    direction,posx,posy:Real;
    visible:boolean;
    vitesse:real;
end;

type Tabmunition = array[1..5] of Mun;
	


Type tank = record
	nomT: String;
	degats,Pv,x,y:integer;
	posx,posy:real;
	Vitesse:Real;
	direction:real;
	Munitions:Tabmunition;
	visible:boolean;
	end;
	


type tobst= array[1..30] of TSDL_Rect;



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

type tankTextures = array[0..15] of PSDL_Texture;

procedure iniT(var T:Ttank);

procedure iniScore(var j1,j2:joueur);

procedure iniMun(j:joueur);
procedure iniobst1(var car:tobst);
procedure iniobst2(var car:tobst);
procedure iniobst3(var car:tobst);



implementation

procedure iniT(var T:Ttank);

BEGIN
	T[1].nomT:='Vic';
	T[1].degats:=50;
	T[1].Pv:=200;
	T[1].Vitesse:=2;
	T[2].nomT:='JM';
	T[2].degats:=70;
	T[2].Pv:=150;
	T[2].Vitesse:=2.25;  //initialisation des valeurs des tanks
	T[3].nomT:='Tom';
	T[3].degats:=90;
	T[3].Pv:=100;
	T[3].Vitesse:=2.5;
END;

procedure iniScore(var j1,j2:joueur);
 
begin
	j1.score:=0;
	j2.score:=0;       //initialisation des scores
end;

procedure iniMun(j:joueur);
var i:integer;
begin
	for i:=1 to 5 do
		j.t.munitions[i].visible:= false
end;



procedure iniobst1(var car:tobst);// on initialise les obstacles de la carte 1
var i:integer;
begin
	for i:=1 to 24 do
		begin
			car[i].w := 100;
			car[i].h := 100;
		end;
	car[1].x:=0;
	car[1].y:=0;
	car[2].x:=100;
	car[2].y:=0;
	car[3].x:=1100;
	car[3].y:=0;
	car[4].x:=500;
	car[4].y:=100;
	car[5].x:=600;
	car[5].y:=100;
	car[6].x:=300;
	car[6].y:=200;
	car[7].x:=400;
	car[7].y:=200;
	car[8].x:=700;
	car[8].y:=200;
	car[9].x:=800;
	car[9].y:=200;
	car[10].x:=100;
	car[10].y:=300;
	car[11].x:=100;
	car[11].y:=400;
	car[12].x:=1000;
	car[12].y:=300;
	car[13].x:=1000;
	car[13].y:=400;
	car[14].x:=300;
	car[14].y:=500;
	car[15].x:=400;
	car[15].y:=500;
	car[16].x:=500;
	car[16].y:=600;
	car[17].x:=600;
	car[17].y:=600;
	car[18].x:=700;
	car[18].y:=500;
	car[19].x:=800;
	car[19].y:=500;
	car[20].x:=0;
	car[20].y:=600;
	car[21].x:=0;
	car[21].y:=700;
	car[22].x:=100;
	car[22].y:=700;
	car[23].x:=1100;
	car[23].y:=600; 
	car[24].x:=1100;
	car[24].y:=700;
	
		
end;

procedure iniobst2(var car:tobst);// on initialise les obstacles de la carte 2
var i:integer;
begin
	for i:=1 to 24 do
		begin
			car[i].w := 100;
			car[i].h := 100;
		end;
	car[1].x:=100;
	car[1].y:=100;
	car[2].x:=200;
	car[2].y:=100;
	car[3].x:=200;
	car[3].y:=200;
	car[4].x:=300;
	car[4].y:=200;
	car[5].x:=400;
	car[5].y:=200;
	car[6].x:=500;
	car[6].y:=200;
	car[7].x:=500;
	car[7].y:=100;
	car[8].x:=1000;
	car[8].y:=100;
	car[9].x:=1000;
	car[9].y:=200;
	car[10].x:=900;
	car[10].y:=300;
	car[11].x:=900;
	car[11].y:=200;
	car[12].x:=100;
	car[12].y:=400;
	car[13].x:=100;
	car[13].y:=500;
	car[14].x:=100;
	car[14].y:=600;
	car[15].x:=200;
	car[15].y:=600;
	car[16].x:=400;
	car[16].y:=400;
	car[17].x:=500;
	car[17].y:=400;
	car[18].x:=600;
	car[18].y:=400;
	car[19].x:=700;
	car[19].y:=400;
	car[20].x:=700;
	car[20].y:=500;
	car[21].x:=1000;
	car[21].y:=1000;
	car[22].x:=1100;
	car[22].y:=1000;
	car[23].x:=1100;
	car[23].y:=1100; 
	car[24].x:=1000;
	car[24].y:=1100;
		
end;

procedure iniobst3(var car:tobst);// on initialise les obstacles de la carte 3
var i:integer;
begin
	for i:=1 to 29 do
		begin
			car[i].w := 100;
			car[i].h := 100;
		end;
	car[1].x:=500;
	car[1].y:=0;
	car[2].x:=600;
	car[2].y:=0;
	car[3].x:=900;
	car[3].y:=0;
	car[4].x:=900;
	car[4].y:=100;
	
	car[5].x:=100;
	car[5].y:=100;
	car[6].x:=200;
	car[6].y:=100;
	car[7].x:=300;
	car[7].y:=100;
	car[8].x:=900;
	car[8].y:=100;
	
	car[9].x:=100;
	car[9].y:=200;
	car[10].x:=200;
	car[10].y:=200;
	car[11].x:=600;
	car[11].y:=200;
	
	car[12].x:=500;
	car[12].y:=300;
	car[13].x:=600;
	car[13].y:=300;
	car[14].x:=900;
	car[14].y:=300;
	car[15].x:=1000;
	car[15].y:=300;
	
	car[16].x:=100;
	car[16].y:=400;
	car[17].x:=200;
	car[17].y:=400;
	car[18].x:=300;
	car[18].y:=400;
	car[19].x:=400;
	car[19].y:=400;
	car[20].x:=500;
	car[20].y:=400;
	
	car[21].x:=0;
	car[21].y:=600;
	car[22].x:=100;
	car[22].y:=600;
	car[23].x:=400;
	car[23].y:=600; 
	car[24].x:=500;
	car[24].y:=600;
	car[25].x:=600;
	car[25].y:=600;
	car[26].x:=700;
	car[26].y:=600;
	car[27].x:=800;
	car[27].y:=600;
	car[28].x:=900;
	car[28].y:=600;
	
	car[29].x:=0;
	car[29].y:=700;
		
end;

end.
