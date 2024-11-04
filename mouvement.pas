unit mouvement;


interface
uses crt,math,types; 


	
var 
touche:char;

procedure InitialiserTank(var j: joueur; initX, initY: Integer; initAngle: Real);
procedure affich(j1,j2:joueur);
procedure avancer(var j:joueur;sens:integer);
procedure TournerGauche(var j:joueur);
procedure TournerDroite(var j:joueur);


implementation 

procedure InitialiserTank(var j:joueur; initX, initY: Integer; initAngle: Real);
begin
  j.t.x := initX;
  j.t.y := initY;
  j.t.posx:= initX;
  j.t.posy:= initY;
  j.t.direction:= initAngle;
end;

procedure affich(j1,j2:joueur); {actualiser la position du tank}
begin
	ClrScr;
	GotoXY(j1.t.x,j1.t.y);
	write('x');
	GotoXY(j2.t.x,j2.t.y);
	write('o');
end;

procedure avancer(var j:joueur;sens:integer);
var anglerad:real;newx,newy:real;
begin
anglerad:=j.t.direction*Pi/180;

newx:= j.t.coefVit * cos(anglerad)*sens;
newy:= j.t.coefVit * sin(anglerad);

	j.t.posx:=j.t.posx+newx;
	j.t.posy:=j.t.posy+newy;

j.t.x := Trunc(j.t.posx);
j.t.y := Trunc(j.t.posy);

  if j.t.x < 1 
  then j.t.x := 1;
  if j.t.y < 1 
  then j.t.y := 1;
	if j.t.x>ScreenWidth  {ne pas sortir de l'écran}
	then j.t.x:=ScreenWidth;
	if j.t.y>ScreenHeight
	then j.t.y:=ScreenHeight;
end;

procedure TournerGauche(var j: joueur);
begin
  j.t.direction := j.t.direction - 22.5;
  if j.t.direction < 0 then
    j.t.direction := j.t.direction + 360;
end;

procedure TournerDroite(var j: joueur);
begin
  j.t.direction := j.t.direction + 22.5;
  if j.t.direction >= 360 then
    j.t.direction := j.t.direction - 360;
end;

end.
