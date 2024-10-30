program mouvements;
uses crt,math; 

Type tank = record
x,y :integer;
posx,posy:real;
vitesse:real;
direction:real; {angle multiple de 22,5}
end;
	
var 
T1,T2: tank;
touche:char;

procedure InitialiserTank(var T: tank; initX, initY: Integer; initAngle: Real);
begin
  T.x := initX;
  T.y := initY;
  T.posX := initX;
  T.posY := initY;
  T.direction:= initAngle;
end;

procedure affich(Tank1,Tank2:tank); {lactualiser la position du tank}
begin
	ClrScr;
	GotoXY(Tank1.x,Tank1.y);
	write('x');
	GotoXY(Tank2.x,Tank2.y);
	write('o');
end;

procedure avancer(var T:tank;sens:integer);
var anglerad:real;newx,newy:real;
begin
anglerad:=T.direction*Pi/180;

newx:= T.vitesse * cos(anglerad)*sens;
newy:= T.vitesse * sin(anglerad);

	T.posx:=T.posx+newx;
	T.posy:=T.posy+newy;

T.x := Trunc(T.posx);
T.y := Trunc(T.posy);

  if T.x < 1 
  then T.x := 1;
  if T.y < 1 
  then T.y := 1;
	if T.x>ScreenWidth  {ne pas sortir de l'écran}
	then T.x:=ScreenWidth;
	if T.y>ScreenHeight
	then T.y:=ScreenHeight;
end;

procedure TournerGauche(var T: tank);
begin
  T.direction := T.direction - 22.5;
  if T.direction < 0 then
    T.direction := T.direction + 360;
end;

procedure TournerDroite(var T: tank);
begin
  T.direction := T.direction + 22.5;
  if T.direction >= 360 then
    T.direction := T.direction - 360;
end;

begin
	ClrScr;
	T1.vitesse := 1.5; 
	T2.vitesse := 1.0; 
	
	{ Initialisation des tanks avec position de départ et angle initial }
  InitialiserTank(T1, ScreenWidth div 4, ScreenHeight div 2, 0);
  InitialiserTank(T2, (ScreenWidth div 4) * 3, ScreenHeight div 2, 180);
	affich(T1,T2);
	
	repeat
		if KeyPressed then 
			begin
				touche:= ReadKey; {lire la touche appuyée}
				case touche of
				'z': avancer(T1,1);
				's': avancer(T1,-1);
				'd':TournerDroite(T1);
				'q':TournerGauche(T1);
				#0:
				begin
					touche:=Readkey;
					case touche of
					#72: avancer(T2,1);  {touche up and down table ascii}
					#80: avancer(T2,-1);
					#77: TournerDroite(T2);
					#75: TournerGauche(T2);
				end;
			end;
end; 
affich(T1,T2);
end;
until touche= #27;  {touche échap table ascii}
ClrScr;
end.
