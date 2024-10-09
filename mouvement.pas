unit mouvement;


interface
uses types,interaction,crt,math;

	

procedure affich(Tank1,Tank2:tank); {actualiser la position du tank}


procedure avancer(var T:tank;angledeg:real; newx,newy: integer);



implementation

procedure affich(Tank1,Tank2:tank); {lactualiser la position du tank}
begin
	ClrScr;
	GotoXY(Tank1.x,Tank1.y);
	write('x');
	GotoXY(Tank2.x,Tank2.y);
	write('o');
end;


procedure avancer(var T:tank;angledeg:real; newx,newy: integer);
var anglerad:real;
begin
anglerad:=angledeg*Pi/180;
newx:=round(cos(anglerad));
newy:=round(sin(anglerad));
	T.x:=T.x+newx;
	T.y:=T.y+newy;
	
	if T.x>ScreenWidth  {ne pas sortir de l'écran}
	then T.x:=ScreenWidth;
	if T.y>ScreenHeight
	then T.y:=ScreenHeight;
end;


BEGIN
	
	
END.
