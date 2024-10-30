program Carte1;

uses SDL2, SDL2_image;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlSurface1, sdlSurface2, sdlSurface3: PSDL_Surface;
  sdlTexture1,sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6, sdlTexture7, sdlTexture8: PSDL_Texture;
  sdlRectangle: TSDL_Rect;
  i:integer;
  event: TSDL_Event;
  isRunning:Boolean;

begin

  // Initialisation de la video du sous-système
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(1200, 800, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;

  // Creer des surfaces à partir de fichiers d'images
  sdlSurface1 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\sable.bmp');
  if sdlSurface1 = nil then
    Halt;
    
  sdlSurface2 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\caisse1.bmp');
  if sdlSurface2 = nil then
	Halt;
	
  sdlSurface3 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\caisse2.bmp');
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
    
  sdlTexture4 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\troue1.png');
  if sdlTexture4 = nil then 
	Halt;

  sdlTexture5 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\liane.png');
  if sdlTexture5 = nil then 
	Halt;	

  sdlTexture6 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\etoile.png');
  if sdlTexture6 = nil then 
	Halt;
	
     sdlTexture7 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\coquillage.png');
  if sdlTexture7 = nil then 
	Halt;
	
     sdlTexture8 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\coquillage2.png');
  if sdlTexture8 = nil then 
	Halt;
	
   // première caisse du bas
    
   sdlRectangle.x:=0;
   sdlRectangle.y:=600;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;

  // Affiche la texture à l'endroit et de la taille du rectangle définit précédement
	SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);
	SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
	
	// deuxième caisse du bas
	
   sdlRectangle.x:=0; // position en x
   sdlRectangle.y:=700; // position en y
   sdlRectangle.w:=100; // largeur du rectangle
   sdlRectangle.h:=100; // hauteur du rectangle
   
   	SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
   	
   	// troisème caisse du bas
   	
   sdlRectangle.x:=100;
   sdlRectangle.y:=600;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;	

   	SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
   	
   	// boucle pour afficher la ligne d'obstacle du bas y=600 et x=400 à 900
   	
   	for i:=400 to 900 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=600;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
				end
		end;
		
	// boucle pour afficher la ligne du milieu y=400 et x=100 à 500
		
   	for i:=100 to 500 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=400;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
				end
		end;
	
	// boucle pour afficher les deux caisse en y=300 et x=500 à 600
		
   	for i:=500 to 600 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=300;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
				end
		end;
		
	// afficher caisse partie du milieu ratachée aux caisses de la boucle précedente
	
	sdlRectangle.x:=600;
	sdlRectangle.y:=200;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;		
	SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);	


	// boucle pour afficher les deux caisse à droite au milieu
	
   	for i:=900 to 1000 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=300;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
				end
		end;	
		
	// boucle pour afficher les 2 caisses à gauche en haut
	
   	for i:=100 to 200 do
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
	
	// boucle pour afficher les 3 caisses à droite au milieu reliées à celles de la boucle précedente
	
   	for i:=100 to 300 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=100;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
				end
		end;

	// boucle pour afficher les 2 caisses en haut au milieu
	
   	for i:=500 to 600 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=0;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
				end
		end;
		
	// boucle pour afficher les 2 caisses verticales en haut à droite
	
   	for i:=0 to 100 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=900;
					sdlRectangle.y:=i;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);
				end
		end;
	
	// affichage troue sur la carte
	
	// troue au milieu à gauche
	
	sdlRectangle.x:=300;
	sdlRectangle.y:=200;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;	
	SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);	
	
	// troue en haut a droite	
	
	sdlRectangle.x:=1000;
	sdlRectangle.y:=0;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;	
	SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
	
	// troue en bas à droite	
	
	sdlRectangle.x:=1100;
	sdlRectangle.y:=500;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;	
	SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);	
	
	// affichage lianes
	
	// liane en haut à gauche
	
	sdlRectangle.x:=100;
	sdlRectangle.y:=100;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);
	
	// lianes pour les caisses du milieu

	sdlRectangle.x:=100;
	sdlRectangle.y:=400;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);

	sdlRectangle.x:=200;
	sdlRectangle.y:=400;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);

	sdlRectangle.x:=500;
	sdlRectangle.y:=300;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);
	
	// lianes sur la ligne du bas
	
	sdlRectangle.x:=400;
	sdlRectangle.y:=600;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);	

	sdlRectangle.x:=600;
	sdlRectangle.y:=600;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);
	
	// liane en haut à droite
	
	sdlRectangle.x:=900;
	sdlRectangle.y:=100;
	sdlRectangle.w:=100;
	sdlRectangle.h:=100;
	SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);
	
	// affichage des 2 étoiles de mer
	
	sdlRectangle.x:=500;
	sdlRectangle.y:=520;
	sdlRectangle.w:=40;
	sdlRectangle.h:=40;
	SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);

	sdlRectangle.x:=730;
	sdlRectangle.y:=40;
	sdlRectangle.w:=50;
	sdlRectangle.h:=50;
	SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
	
	// affichage coquillages
	
	// deux petits coquillages en hat à gauche
	
	sdlRectangle.x:=0;
	sdlRectangle.y:=200;
	sdlRectangle.w:=25;
	sdlRectangle.h:=25;
	SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
	
	sdlRectangle.x:=40;
	sdlRectangle.y:=210;
	sdlRectangle.w:=30;
	sdlRectangle.h:=40;
	SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
	
	// coquillage en bas à gauche
	
	sdlRectangle.x:=210;
	sdlRectangle.y:=600;
	sdlRectangle.w:=50;
	sdlRectangle.h:=70;
	SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);	
	
	// coquillage en bas au milieu
	
	sdlRectangle.x:=580;
	sdlRectangle.y:=710;
	sdlRectangle.w:=60;
	sdlRectangle.h:=60;
	SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
	
	// coquillages en haut à droite
	
	sdlRectangle.x:=1100;
	sdlRectangle.y:=200;
	sdlRectangle.w:=50;
	sdlRectangle.h:=60;
	SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
	
	sdlRectangle.x:=1140;
	sdlRectangle.y:=230;
	sdlRectangle.w:=30;
	sdlRectangle.h:=30;
	SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);					
		
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
  // boucle pour afficher indéfiniement l'écran
  

  // vide la mémoire
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
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow (sdlWindow1);

  // ferme la SDL2
  SDL_Quit;
  
end.  
