program carte1;

uses SDL2, SDL2_image;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlRectangle: TSDL_Rect;
  sdlSurface1, sdlSurface2, sdlSurface3, sdlSurface4, sdlSurface5:PSDL_Surface;
  sdlTexture1, sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6, sdlTexture7, sdlTexture8:PSDL_Texture;
  i:integer;
  event: TSDL_Event;
  isRunning:Boolean;

begin

  // Initialisation de la video du sous-système
  
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(1200, 800, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;
    
  // Creer des surfaces à partir de fichiers d'images
  
  sdlSurface1 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\herbe.bmp');
  if sdlSurface1 = nil then
    Halt;

  sdlSurface2 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\pierre_craque.bmp');
  if sdlSurface2 = nil then
	Halt;
	
  sdlSurface3 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\pierre_mossy.bmp');
  if sdlSurface2 = nil then
	Halt;

  sdlSurface4 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\or.bmp');
  if sdlSurface2 = nil then
	Halt;

  sdlSurface5 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\pierre_gris.bmp');
  if sdlSurface2 = nil then
	Halt;

  // Creer une texture à partir de surfaces
  
  sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
  if sdlTexture1 = nil then
    Halt;

  sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface2);
  if sdlTexture2 = nil then
    Halt;

  sdlTexture3 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface3);
  if sdlTexture3 = nil then
    Halt;

  sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface4);
  if sdlTexture4 = nil then
    Halt;

  sdlTexture5 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface5);
  if sdlTexture5 = nil then
    Halt;

  sdlTexture6 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\liane.png');
  if sdlTexture6 = nil then 
	Halt;

  sdlTexture7 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\trefle.png');
  if sdlTexture7 = nil then 
	Halt;	

  sdlTexture8 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\fleur.png');
  if sdlTexture8 = nil then 
	Halt;
  //fond
  SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);
  
  //mur en haut gauche
  
  //Pierre moussues craquelée
  
   sdlRectangle.x:=200;
   sdlRectangle.y:=100;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
   
  //pierre craqulée
  
   sdlRectangle.x:=100;
   sdlRectangle.y:=100;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
  
   for i:=200 to 500 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=200;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
			end
	end;
	
	//bloc en or
	
   sdlRectangle.x:=500;
   sdlRectangle.y:=100;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
   
   //mur en bas à gauche
   
   //bloc en pierre craquelée
   
   sdlRectangle.x:=100;
   sdlRectangle.y:=400;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
   
   //bloc en or

   sdlRectangle.x:=100;
   sdlRectangle.y:=500;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
   
   //pierre moussues craquelée

   for i:=100 to 200 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=600;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
			end
	end;   
   
   //mur du milieu
   
   //pierre craqueleé
   
   for i:=400 to 700 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=400;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
			end
	end;
	
	//pierre moussues craquelée
	
   sdlRectangle.x:=700;
   sdlRectangle.y:=500;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
   
   //mur en haut à droite
   
   //pierre craquelée
   
   sdlRectangle.x:=900;
   sdlRectangle.y:=300;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
   
   //bloc en or
   
   sdlRectangle.x:=900;
   sdlRectangle.y:=200;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
   
   //pierre mossues craquelée
   
   for i:=100 to 200 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=1000;
				sdlRectangle.y:=i;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
			end
	end;
	
   //mur en bas à droite
   
   for i:=1000 to 1100 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=600;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
			end
	end;

   for i:=1000 to 1100 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=700;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
			end
	end;

	//lianes
	
	//mur en haut à gauche
	
   for i:=300 to 400 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=200;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
			end
	end;
	
   sdlRectangle.x:=100;
   sdlRectangle.y:=100;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
   
   //mur en bas à gauche
   
   sdlRectangle.x:=100;
   sdlRectangle.y:=600;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);

	//mur du milieu

   sdlRectangle.x:=400;
   sdlRectangle.y:=400;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
   
   sdlRectangle.x:=700;
   sdlRectangle.y:=400;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
   
   //mur en haut à droite
   
   sdlRectangle.x:=900;
   sdlRectangle.y:=200;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
   
   //mur en bas à droite

   sdlRectangle.x:=1100;
   sdlRectangle.y:=700;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
   
   for i:=1000 to 1100 do
	begin
		if (i mod 100=0) then
			begin
				sdlRectangle.x:=i;
				sdlRectangle.y:=600;
				sdlRectangle.w:=100;
				sdlRectangle.h:=100;
				SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
			end
	end;
		
	//trefles
	
	//milieu en bas
	
   sdlRectangle.x:=500;
   sdlRectangle.y:=600;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
   
   //milieu à droite
   
   sdlRectangle.x:=1080;
   sdlRectangle.y:=420;
   sdlRectangle.w:=70;
   sdlRectangle.h:=70;
   SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);  
   
   //haut à gauche

   sdlRectangle.x:=300;
   sdlRectangle.y:=30;
   sdlRectangle.w:=130;
   sdlRectangle.h:=130;
   SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
   
   //fleurs
   
   //haut à gauche
   
   sdlRectangle.x:=200;
   sdlRectangle.y:=330;
   sdlRectangle.w:=50;
   sdlRectangle.h:=50;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);  
   
   //bas à gauche
   
   sdlRectangle.x:=100;
   sdlRectangle.y:=700;
   sdlRectangle.w:=30;
   sdlRectangle.h:=30;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
   
   sdlRectangle.x:=130;
   sdlRectangle.y:=730;
   sdlRectangle.w:=50;
   sdlRectangle.h:=50;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);  
   
   //milieu en haut
   
   sdlRectangle.x:=700;
   sdlRectangle.y:=100;
   sdlRectangle.w:=80;
   sdlRectangle.h:=80;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);  
   
   //haut à droite
   
   sdlRectangle.x:=1130;
   sdlRectangle.y:=100;
   sdlRectangle.w:=30;
   sdlRectangle.h:=30;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle); 

   
   sdlRectangle.x:=1150;
   sdlRectangle.y:=130;
   sdlRectangle.w:=40;
   sdlRectangle.h:=40;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
   
   //bas à droite
   
   
   sdlRectangle.x:=800;
   sdlRectangle.y:=700;
   sdlRectangle.w:=80;
   sdlRectangle.h:=80;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);

   sdlRectangle.x:=880;
   sdlRectangle.y:=730;
   sdlRectangle.w:=40;
   sdlRectangle.h:=40;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
   
   sdlRectangle.x:=790;
   sdlRectangle.y:=690;
   sdlRectangle.w:=25;
   sdlRectangle.h:=25;
   SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
  
  // Afficher à l'écran jusqu'à ce que l'utilisateur décide de quitter la fenêtre
  SDL_RenderPresent(sdlRenderer);
  
  isRunning:=True;
  
  while isRunning do // boucle vérifiant à chaque instant si l'utilisateur quitte la fenêtre ou non
  begin
	while SDL_PollEvent(@event)<>0 do // vériifie si il y a eu un évenement (ex: clic de souris)
	begin
		if event.type_=SDL_QUITEV then // si l'utilisateur clic surla croix de la fenêtre
			isRunning:=False;
	end;
  end;

	//vide la mémoire
  
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow (sdlWindow1);
  SDL_DestroyTexture(sdlTexture1);
  SDL_DestroyTexture(sdlTexture2);
  SDL_DestroyTexture(sdlTexture3);
  SDL_DestroyTexture(sdlTexture4);
  SDL_DestroyTexture(sdlTexture5);
  SDL_DestroyTexture(sdlTexture6); 
  SDL_DestroyTexture(sdlTexture7); 
  SDL_DestroyTexture(sdlTexture8);    
  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  // ferme la SDL2
  SDL_Quit;
end.
