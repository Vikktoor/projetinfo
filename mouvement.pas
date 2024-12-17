unit mouvement;


interface
uses crt,math,types,SDL2, SDL2_image,SysUtils;

var // Variables SDL
	sdlWindow1: PSDL_Window;
	sdlRenderer: PSDL_Renderer;
	sdlKeyboardState: PUInt8;
	sdlSurface1, sdlSurface2, sdlSurface3: PSDL_Surface;
	sdlTexture1,sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6, sdlTexture7, sdlTexture8: PSDL_Texture;
	sdlRectangle: TSDL_Rect;

	// Autres variables 
	i: integer;
	event: TSDL_Event;
	isRunning: Boolean;
	lastRotationTime1: UInt32;
	lastRotationTime2: UInt32;
	rotationDelay: UInt32 = 100;
	T1,T2: tank; 
	touche:char;
	tankTextures1: array[0..15] of PSDL_Texture;  // 16 images pour 360° (pas de 22.5°)
	tankTextures2: array[0..15] of PSDL_Texture;  // 16 images pour 360° (pas de 22.5°)
	tankTextures3: array[0..15] of PSDL_Texture;  // 16 images pour 360° (pas de 22.5°)

// Procédures

procedure avancer(var j: joueur; sens: integer; obstacles: tobst);

procedure InitialiserTank(var j: joueur; initX, initY: Integer; initAngle: Real);

procedure TournerGauche(var j:joueur);

procedure TournerDroite(var j:joueur);

procedure ChargerTexturesT1(sdlRenderer: PSDL_Renderer);

procedure ChargerTexturesT2(sdlRenderer: PSDL_Renderer);

procedure ChargerTexturesT3(sdlRenderer: PSDL_Renderer);

procedure AfficherTank(var j: joueur; sdlRenderer: PSDL_Renderer);

// Fonctions

function RectanglesSeChevauchent(rect1, rect2: TSDL_Rect): Boolean;

function TankEnCollisionAvecObstacles(var tankRect: TSDL_Rect; obstacles: tobst): Boolean;

function GetTextureIndex(angle: Real): Integer;


implementation 

// Retourne un boolean si deux rectangles se chevauchent 
function RectanglesSeChevauchent(rect1, rect2: TSDL_Rect): Boolean;
begin
	RectanglesSeChevauchent:= (rect1.x < rect2.x + rect2.w) and (rect1.x + rect1.w > rect2.x) and (rect1.y < rect2.y + rect2.h) and (rect1.y + rect1.h > rect2.y);
end;


// Permet de vérifier si un tank rentre en collision avec un obstacle de la carte
function TankEnCollisionAvecObstacles(var tankRect: TSDL_Rect; obstacles: tobst): Boolean;
var i: Integer;
begin
	TankEnCollisionAvecObstacles := False;
	for i := 1 to High(obstacles) do
	begin
		if RectanglesSeChevauchent(tankRect, obstacles[i]) then
		begin
			TankEnCollisionAvecObstacles:= True;
			Exit; // Arrête la vérification dès qu'on trouve une collision
		end;
	end;
end;

// Permet de repositionner les tanks sur la carte
procedure InitialiserTank(var j:joueur; initX, initY: Integer; initAngle: Real);
begin
	j.t.x := initX;
	j.t.y := initY;
	j.t.posx:= initX;
	j.t.posy:= initY;
	j.t.direction:= initAngle;
end;

// Permet de faire avancer les tanks uniquement si il n'entre pas en collision avec un obstacle
procedure avancer(var j: joueur; sens: integer; obstacles: tobst);
var anglerad: real;
	futurRect: TSDL_Rect;
begin
	anglerad := j.t.direction * Pi / 180;
	
	// Calcule la position future du tank	
	futurRect.x := Round(j.t.posx + sens * j.t.vitesse * Cos(anglerad));
	futurRect.y := Round(j.t.posy + sens * j.t.vitesse * Sin(anglerad));
	futurRect.w := 60;  // Largeur du tank
	futurRect.h := 60;  // Hauteur du tank

	// Vérifie si cette nouvelle position entre en collision avec un obstacle
	if not TankEnCollisionAvecObstacles(futurRect, obstacles) then
	// Si ce n'est pas le cas, la position du tank est mise à jour grâce à la position future calculé avant
	begin
		j.t.posx := futurRect.x;
		j.t.posy := futurRect.y;
		j.t.x := Round(j.t.posx);
		j.t.y := Round(j.t.posy);
	end;
	 
    // Limiter les coordonnées aux dimensions de l'écran
	if j.T.posx < 0 then
		j.T.posx := 0
	else if j.T.posx > 1140 then // 1200 - largeur du tank (60 pixels)
		j.T.posx := 1140;

	if j.T.posy < 0 then
		j.T.posy := 0
	else if j.T.posy > 740 then // 800 - hauteur du tank (60 pixels)
		j.T.posy := 740;
end;


// Permet de tourner letank de 22,5° vers la gauche
procedure TournerGauche(var j: joueur);
begin
	j.T.direction := j.T.direction - 22.5;
	if j.T.direction < 0 then
		j.T.direction := j.T.direction + 360;
end;

// Permet de tourner letank de 22,5° vers la droite
procedure TournerDroite(var j: joueur);
begin
	j.T.direction := j.T.direction + 22.5;
	if j.T.direction > 360 then
		j.T.direction := j.T.direction - 360;
end;

// Charge les textures du tank 1 en fonction de son orientation
procedure ChargerTexturesT1(sdlRenderer: PSDL_Renderer);
begin
	tankTextures1[0]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-.png');
	tankTextures1[1]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-22.5.png');
	tankTextures1[2]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-45.png');
	tankTextures1[3]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-67.5.png');
	tankTextures1[4]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-90.png');
	tankTextures1[5]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-112.5.png');
	tankTextures1[6]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-135.png');
	tankTextures1[7]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-157.5.png');
	tankTextures1[8]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-180.png');
	tankTextures1[9]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-202.5.png');
	tankTextures1[10]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-225.png');
	tankTextures1[11]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-247.5.png');
	tankTextures1[12]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-270.png');
	tankTextures1[13]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-292.5.png');
	tankTextures1[14]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-315.png');
	tankTextures1[15]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT1/t1-337.5.png');;
end;

// Charge les textures du tank 2 en fonction de son orientation
procedure ChargerTexturesT2(sdlRenderer: PSDL_Renderer);
begin
	tankTextures2[0]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-.png');
	tankTextures2[1]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-22.5.png');
	tankTextures2[2]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-45.png');
	tankTextures2[3]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-67.5.png');
	tankTextures2[4]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-90.png');
	tankTextures2[5]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-112.5.png');
	tankTextures2[6]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-135.png');
	tankTextures2[7]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-157.5.png');
	tankTextures2[8]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-180.png');
	tankTextures2[9]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-202.5.png');
	tankTextures2[10]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-225.png');
	tankTextures2[11]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-247.5.png');
	tankTextures2[12]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-270.png');
	tankTextures2[13]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-292.5.png');
	tankTextures2[14]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-315.png');
	tankTextures2[15]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT2/t2-337.5.png');
end;

// Charge les textures du tank 3 en fonction de son orientation
procedure ChargerTexturesT3(sdlRenderer: PSDL_Renderer);
begin
	tankTextures3[0]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-.png');
	tankTextures3[1]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-22.5.png');
	tankTextures3[2]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-45.png');
	tankTextures3[3]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-67.5.png');
	tankTextures3[4]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-90.png');
	tankTextures3[5]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-112.5.png');
	tankTextures3[6]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-135.png');
	tankTextures3[7]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-157.5.png');
	tankTextures3[8]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-180.png');
	tankTextures3[9]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-202.5.png');
	tankTextures3[10]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-225.png');
	tankTextures3[11]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-247.5.png');
	tankTextures3[12]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-270.png');
	tankTextures3[13]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-292.5.png');
	tankTextures3[14]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-315.png');
	tankTextures3[15]:=IMG_LoadTexture(sdlRenderer, './Images/SpritesT3/t3-337.5.png');
end;

// Permet de récuperer la texture du tank en fonction de son angle de rotation
function GetTextureIndex(angle: Real): Integer;
begin
	GetTextureIndex := Round(angle / 22.5) mod 16;  // 16 textures, chaque 22.5°
end;

// Permet d'afficher le tank avec la texture en fonction de son orientation
procedure AfficherTank(var j: joueur; sdlRenderer: PSDL_Renderer);
var textureIndex: Integer;
	tankRect: TSDL_Rect;
begin
	textureIndex := GetTextureIndex(j.T.direction);  // Récupère l'indice de la texture

	tankRect.x := Round(j.T.posx);  // Position X
	tankRect.y := Round(j.T.posy);  // Position Y
	tankRect.w := 60;  // Largeur du tank
	tankRect.h := 60;  // Hauteur du tank
  
    if j.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, tankTextures1[textureIndex], nil, @tankRect);  // Affiche la texture du tank 1
    if j.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, tankTextures2[textureIndex], nil, @tankRect);  // Affiche la texture du tank 2
    if j.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, tankTextures3[textureIndex], nil, @tankRect);  // Affiche la texture du tank 3
end;

end.
