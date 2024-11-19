unit mouvement;


interface
uses crt,math,types,SDL2, SDL2_image;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlKeyboardState: PUInt8;
  sdlSurface1, sdlSurface2, sdlSurface3: PSDL_Surface;
  sdlTexture1,sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6, sdlTexture7, sdlTexture8: PSDL_Texture;
  sdlRectangle: TSDL_Rect;
  
  i: integer;
  event: TSDL_Event;
  isRunning: Boolean;
   lastRotationTime1: UInt32;
    lastRotationTime2: UInt32;
  rotationDelay: UInt32 = 100;
T1,T2: tank;

touche:char;

procedure avancer(var j:joueur;sens:integer);
procedure InitialiserTank(var j: joueur; initX, initY: Integer; initAngle: Real);
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


procedure avancer(var j: joueur; sens: integer);
var
  anglerad: real;
  newx, newy: real;
begin
  anglerad := j.T.direction * Pi / 180;
  newx := j.T.vitesse * cos(anglerad) * sens;
  newy := j.T.vitesse * sin(anglerad) * sens;

  // Mettre à jour les positions 
  j.T.posx := j.T.posx + newx;
  j.T.posy := j.T.posy + newy;

  // Limiter les coordonnées aux dimensions de l'écran
  if j.T.posx < 0 then
    j.T.posx := 0
  else if j.T.posx > 1160 then // 1200 - largeur du tank (40 pixels)
    j.T.posx := 1160;

  if j.T.posy < 0 then
    j.T.posy := 0
  else if j.T.posy > 760 then // 800 - hauteur du tank (40 pixels)
    j.T.posy := 760;

  // Mettre à jour les coordonnées entières
  j.T.x := Trunc(j.T.posx);
  j.T.y := Trunc(j.T.posy);
end;


procedure TournerGauche(var j: joueur);
begin
  j.T.direction := j.T.direction - 22.5;
  if j.T.direction < 0 then
    j.T.direction := j.T.direction + 360;
end;

procedure TournerDroite(var j: joueur);
begin
  j.T.direction := j.T.direction + 22.5;
  if j.T.direction >= 360 then
    j.T.direction := j.T.direction - 360;
end;


end.
