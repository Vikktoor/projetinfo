unit types;

interface

uses SDL2, SDL2_image, SysUtils;

const MAX_MUNITION = 5;
	  MAX_OBTSACLES = 30;
	  MAX_TANK = 3;
	  MAX_TEXTURE = 15;
	  
var  SDL_Rect: TSDL_Rect;

// Type munition
type Mun=record
    nbRebonds,x,y:integer;
    direction,posx,posy:Real;
    visible:boolean;
    vitesse:real;
end;

// Tableau de munition (limité à 5 par joueur)
type Tabmunition = array[1..MAX_MUNITION] of Mun;
	
// type tank	
Type tank = record
	nomT: String;
	degats,Pv,x,y:integer;
	posx,posy:real;
	Vitesse:Real;
	direction:real;
	Munitions:Tabmunition; // Munitions du tank
	visible:boolean; //Tank visible ou non
	end;

// Tableau d'obstacles en fonction des cartes
type tobst= array[1..MAX_OBTSACLES] of TSDL_Rect;

// Type carte
type carte = record
	Largeur,hauteur: integer;
	Tob: tobst
	end;

// Type joueur
type joueur=record
	nom:string;
	t:tank;
	score:integer
	end;

// Tableau de tank (il y en a 3 en tout)
type Ttank = array [1..MAX_TANK] of tank;

// Tableau des différentes textures des tanks en fonction de leur orientation
type tankTextures = array[0..MAX_TEXTURE] of PSDL_Texture;

// Procedures

procedure iniT(var T:Ttank);

procedure iniScore(var j1,j2:joueur);

procedure iniMun(var j:joueur);

procedure iniobst1(var car:tobst);

procedure iniobst2(var car:tobst);

procedure iniobst3(var car:tobst);


implementation

// Initialise les caractéristiques des tanks
procedure iniT(var T:Ttank);
begin
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
end;

// Initialise les scores
procedure iniScore(var j1,j2:joueur);
begin
	j1.score:=0;
	j2.score:=0;  
end;

// Initialise les munitions des tanks
procedure iniMun(var j:joueur);
var i:integer;
begin
	for i:=1 to 5 do
		j.t.munitions[i].visible:= false
end;

// Initialise les obstacles de la carte 1
procedure iniobst1(var car:tobst);
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

// Initialise les obstacles de la carte 2
procedure iniobst2(var car:tobst);
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
	car[21].y:=600;
	car[22].x:=1100;
	car[22].y:=600;
	car[23].x:=1100;
	car[23].y:=700; 
	car[24].x:=1000;
	car[24].y:=700;
end;

// Initialise les obstacles de la carte 3
procedure iniobst3(var car:tobst);
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
