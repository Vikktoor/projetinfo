program carte1;

uses SDL2, SDL2_image;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlRectangle: TSDL_Rect;
  sdlSurface1, sdlSurface2, sdlSurface3:PSDL_Surface;
  sdlTexture1, sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6,sdlTexture7:PSDL_Texture;
  i:integer;
  event: TSDL_Event;
  isRunning:Boolean;

begin

  // Initialisation de la video du sous-système
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(1200, 800, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;
    
  // Creer des surfaces à partir de fichiers d'images
  sdlSurface1 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\glace2.bmp');
  if sdlSurface1 = nil then
    Halt;
    
  sdlSurface2 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\caisse1.bmp');
  if sdlSurface2 = nil then
	Halt;
	
  sdlSurface3 := SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\blocglace.bmp');
  if sdlSurface2 = nil then
	Halt;
	    
  // Creer une texture à partir de surfaces
  
  sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
  if sdlTexture1 = nil then
    Halt;
    
  sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface2);
  if sdlTexture2 = nil then
    Halt;

  sdlTexture3 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\flocon.png');
  if sdlTexture3 = nil then 
	Halt;

  sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface3);
  if sdlTexture4 = nil then
    Halt;
    
  sdlTexture5 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\boule_de_neige.png');
  if sdlTexture5 = nil then 
	Halt;

  sdlTexture6 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\etoile_glace2.png');
  if sdlTexture6 = nil then 
	Halt;   

  sdlTexture7 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\baton_glace.png');
  if sdlTexture7 = nil then 
	Halt;   
	 
  //affichage des textures
  
  //fond
  SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);
  
  // 2 caisses en haut à gauche
  
   	for i:=0 to 100 do
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
		
  // Caisse en haut à droite
   sdlRectangle.x:=1100;
   sdlRectangle.y:=0;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
   
   // 2 caisses au milieu
   
   	for i:=500 to 600 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=100;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
				end
		end;

	// 2 caisse au milieu à droite

   	for i:=700 to 800 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=200;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
				end
		end; 

	// 2 caisse au milieu à gauche

   	for i:=300 to 400 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=200;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
				end
		end; 

	// 2 caisses verticales à droite

   	for i:=300 to 400 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=1000;
					sdlRectangle.y:=i;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
					SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);
				end
		end;

	// 2 caisses verticales à gauche

   	for i:=300 to 400 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=100;
					sdlRectangle.y:=i;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
				end
		end; 

	// 2 caisses milieu en bas

   	for i:=500 to 600 do
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

	// 2 caisses milieu en bas à droite

   	for i:=700 to 800 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=500;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
				end
		end;

	// 2 caisses milieu en bas à gauche
	
   	for i:=300 to 400 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=500;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle);
				end
		end;
		
	// 2 caisses en bas à droite

   	for i:=600 to 700 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=1100;
					sdlRectangle.y:=i;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
				end
		end; 

	// 3 caisses en bas à gauche 

   	for i:=0 to 100 do
		begin
			if (i mod 100=0) then
				begin
				    sdlRectangle.x:=i;
					sdlRectangle.y:=700;
					sdlRectangle.w:=100;
					sdlRectangle.h:=100;
					SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
				end
		end;

   sdlRectangle.x:=0;
   sdlRectangle.y:=600;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);
   SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);//affichage boule de neige sur la caisse

	// Affichage de la couronnecentrale de flocons de neige
	
   sdlRectangle.x:=500;
   sdlRectangle.y:=300;
   sdlRectangle.w:=220;
   sdlRectangle.h:=220;
   SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle);	
   
   // Affichage des boules de neige
  
  //boule de neige en haut à gauche
  
   sdlRectangle.x:=0;
   sdlRectangle.y:=0;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);	
   
   //boule de neige caisse du milieu à gauche
   
   sdlRectangle.x:=100;
   sdlRectangle.y:=400;
   sdlRectangle.w:=100;
   sdlRectangle.h:=100;
   SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);
   
   //Affichage des flocons
   
   //flocon en haut à gauche
   
   sdlRectangle.x:=400;
   sdlRectangle.y:=100;
   sdlRectangle.w:=60;
   sdlRectangle.h:=60;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle); 
   
   //flocon en haut à droite 	
     
   sdlRectangle.x:=900;
   sdlRectangle.y:=50;
   sdlRectangle.w:=80;
   sdlRectangle.h:=80;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);  
   
   //flocon en bas à droite
   
   sdlRectangle.x:=900;
   sdlRectangle.y:=650;
   sdlRectangle.w:=40;
   sdlRectangle.h:=40;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);
   
   //flocon en bas à gauhe
   
   sdlRectangle.x:=300;
   sdlRectangle.y:=710;
   sdlRectangle.w:=70;
   sdlRectangle.h:=70;
   SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle);  
   
   //Affichage bâtons de glace
   
   //baton milieu à droite
   
   sdlRectangle.x:=920;
   sdlRectangle.y:=400;
   sdlRectangle.w:=60;
   sdlRectangle.h:=60;
   SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
   
   //baton en bas à gauche
           
   sdlRectangle.x:=210;
   sdlRectangle.y:=580;
   sdlRectangle.w:=80;
   sdlRectangle.h:=80;
   SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
   
   //baton en haut à gauche
   
   sdlRectangle.x:=110;
   sdlRectangle.y:=180;
   sdlRectangle.w:=35;
   sdlRectangle.h:=35;
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
  
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow (sdlWindow1);
  SDL_DestroyTexture(sdlTexture1);
  SDL_DestroyTexture(sdlTexture2);
  SDL_DestroyTexture(sdlTexture3);
  SDL_DestroyTexture(sdlTexture4);
  SDL_DestroyTexture(sdlTexture5);
  SDL_DestroyTexture(sdlTexture6); 
  SDL_DestroyTexture(sdlTexture7);   
  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  // ferme la SDL2
  SDL_Quit;
end.

