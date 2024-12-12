unit mouvement;


interface
uses crt,math,types,SDL2, SDL2_image,SysUtils;

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
  
  tankTextures: array[0..15] of PSDL_Texture;  // 16 images pour 360° (pas de 22.5°)
  tankTextures1: array[0..15] of PSDL_Texture;  // 16 images pour 360° (pas de 22.5°)
  tankTextures2: array[0..15] of PSDL_Texture;  // 16 images pour 360° (pas de 22.5°)


//procédures

procedure avancer(var j: joueur; sens: integer; obstacles: tobst);

procedure InitialiserTank(var j: joueur; initX, initY: Integer; initAngle: Real);

procedure TournerGauche(var j:joueur);

procedure TournerDroite(var j:joueur);

procedure ChargerTexturesT1(sdlRenderer: PSDL_Renderer);

procedure ChargerTexturesT2(sdlRenderer: PSDL_Renderer);

procedure ChargerTexturesT3(sdlRenderer: PSDL_Renderer);

procedure AfficherTank(var j: joueur; sdlRenderer: PSDL_Renderer);

//fonctions

function RectanglesSeChevauchent(rect1, rect2: TSDL_Rect): Boolean;

function TankEnCollisionAvecObstacles(var tankRect: TSDL_Rect; obstacles: tobst): Boolean;

function GetTextureIndex(angle: Real): Integer;


implementation 

function RectanglesSeChevauchent(rect1, rect2: TSDL_Rect): Boolean;
begin
  RectanglesSeChevauchent:= (rect1.x < rect2.x + rect2.w) and (rect1.x + rect1.w > rect2.x) and
            (rect1.y < rect2.y + rect2.h) and (rect1.y + rect1.h > rect2.y);
end;

function TankEnCollisionAvecObstacles(var tankRect: TSDL_Rect; obstacles: tobst): Boolean;
var
  i: Integer;
begin
  TankEnCollisionAvecObstacles := False;
  for i := 1 to High(obstacles) do
  begin
    if RectanglesSeChevauchent(tankRect, obstacles[i]) then
    begin
      TankEnCollisionAvecObstacles:= True;
      Exit;  // Arrête la vérification dès qu'on trouve une collision
    end;
  end;
end;

procedure InitialiserTank(var j:joueur; initX, initY: Integer; initAngle: Real);
begin
  j.t.x := initX;
  j.t.y := initY;
  j.t.posx:= initX;
  j.t.posy:= initY;
  j.t.direction:= initAngle;
end;

procedure avancer(var j: joueur; sens: integer; obstacles: tobst);
var
  anglerad: real;
  newRect: TSDL_Rect;
begin
  anglerad := j.t.direction * Pi / 180;
  
  // Calcule la position future du tank
  newRect.x := Round(j.t.posx + sens * j.t.vitesse * Cos(anglerad));
  newRect.y := Round(j.t.posy + sens * j.t.vitesse * Sin(anglerad));
  newRect.w := 60;  // Largeur du tank
  newRect.h := 60;  // Hauteur du tank

  // Vérifie si cette nouvelle position entre en collision
  if not TankEnCollisionAvecObstacles(newRect, obstacles) then
  begin
    j.t.posx := newRect.x;
    j.t.posy := newRect.y;
    j.t.x := Round(j.t.posx);
    j.t.y := Round(j.t.posy);
  end;
  
    // Limiter les coordonnées aux dimensions de l'écran
  if j.T.posx < 0 then
    j.T.posx := 0
  else if j.T.posx > 1140 then // 1200 - largeur du tank (40 pixels)
    j.T.posx := 1140;

  if j.T.posy < 0 then
    j.T.posy := 0
  else if j.T.posy > 740 then // 800 - hauteur du tank (40 pixels)
    j.T.posy := 740;
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
  if j.T.direction > 360 then
    j.T.direction := j.T.direction - 360;
end;

procedure ChargerTexturesT1(sdlRenderer: PSDL_Renderer);
begin
	begin
		tankTextures[0]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-.png');
		tankTextures[1]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-22.5.png');
		tankTextures[2]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-45.png');
		tankTextures[3]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-67.5.png');
		tankTextures[4]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-90.png');
		tankTextures[5]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-112.5.png');
		tankTextures[6]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-135.png');
		tankTextures[7]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-157.5.png');
		tankTextures[8]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-180.png');
		tankTextures[9]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-202.5.png');
		tankTextures[10]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-225.png');
		tankTextures[11]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-247.5.png');
		tankTextures[12]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-270.png');
		tankTextures[13]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-292.5.png');
		tankTextures[14]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-315.png');
		tankTextures[15]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-337.5.png');
	
	end;
end;

procedure ChargerTexturesT2(sdlRenderer: PSDL_Renderer);
begin
	begin
		tankTextures1[0]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-.png');
		tankTextures1[1]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-22.5.png');
		tankTextures1[2]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-45.png');
		tankTextures1[3]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-67.5.png');
		tankTextures1[4]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-90.png');
		tankTextures1[5]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-112.5.png');
		tankTextures1[6]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-135.png');
		tankTextures1[7]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-157.5.png');
		tankTextures1[8]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-180.png');
		tankTextures1[9]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-202.5.png');
		tankTextures1[10]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-225.png');
		tankTextures1[11]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-247.5.png');
		tankTextures1[12]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-270.png');
		tankTextures1[13]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-292.5.png');
		tankTextures1[14]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-315.png');
		tankTextures1[15]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-337.5.png');
	
	end;
end;

procedure ChargerTexturesT3(sdlRenderer: PSDL_Renderer);
begin
	begin
		tankTextures2[0]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-.png');
		tankTextures2[1]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-22.5.png');
		tankTextures2[2]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-45.png');
		tankTextures2[3]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-67.5.png');
		tankTextures2[4]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-90.png');
		tankTextures2[5]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-112.5.png');
		tankTextures2[6]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-135.png');
		tankTextures2[7]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-157.5.png');
		tankTextures2[8]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-180.png');
		tankTextures2[9]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-202.5.png');
		tankTextures2[10]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-225.png');
		tankTextures2[11]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-247.5.png');
		tankTextures2[12]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-270.png');
		tankTextures2[13]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-292.5.png');
		tankTextures2[14]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-315.png');
		tankTextures2[15]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-337.5.png');
	
	end;
end;

function GetTextureIndex(angle: Real): Integer;
begin
  GetTextureIndex := Round(angle / 22.5) mod 16;  // 16 textures, chaque 22.5°
end;

procedure AfficherTank(var j: joueur; sdlRenderer: PSDL_Renderer);
var
  textureIndex: Integer;
  tankRect: TSDL_Rect;
begin
  textureIndex := GetTextureIndex(j.T.direction);  // Récupère l'indice de la texture

  tankRect.x := Round(j.T.posx);  // Position X
  tankRect.y := Round(j.T.posy);  // Position Y
  tankRect.w := 60;  // Largeur du tank
  tankRect.h := 60;  // Hauteur du tank
  
    if j.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, tankTextures[textureIndex], nil, @tankRect);  // Affiche la texture
    if j.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, tankTextures1[textureIndex], nil, @tankRect);  // Affiche la texture
    if j.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, tankTextures2[textureIndex], nil, @tankRect);  // Affiche la texture
end;


end.
