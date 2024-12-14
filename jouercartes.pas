unit jouercartes;
interface
uses SDL2, SDL2_image,math,types,mouvement,collisionMun,tirs,interaction;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlKeyboardState: PUInt8;
  sdlSurface1, sdlSurface2, sdlSurface3, sdlSurface4, sdlSurface5: PSDL_Surface;
  sdlTexture1,sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6, sdlTexture7, sdlTexture8, sdlTexture9, sdlTexture10,sdlTexture11,backgroundTexture,TextureScore1,TextureScore2,TexturePv1,TexturePv2: PSDL_Texture;
  sdlRectangle: TSDL_Rect;
  i: integer;
  event: TSDL_Event;
  isRunning: Boolean;
  lastRotationTime1: UInt32;
  lastRotationTime2: UInt32;
  lastshotTime1: UInt32;
  lastshotTime2: UInt32;
  rotationDelay: UInt32 = 100;
  shotDelay: UInt32=500;
  car1,car2,car3:tobst;
  
procedure jouercarte1(var j1,j2:joueur);

procedure jouercarte2(var j1,j2: joueur);

procedure jouercarte3(var j1,j2:joueur);

implementation	

procedure jouercarte1(var j1,j2: joueur);

begin
lastRotationTime1 := SDL_GetTicks;
lastRotationTime2 := SDL_GetTicks;

 // Initialisation de la video du sous-système
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(1200, 800, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;
    
  // Creer des surfaces à partir de fichiers d'images
  sdlSurface1 := SDL_LoadBMP('./Images/glace2.bmp');
  if sdlSurface1 = nil then
    Halt;
    
  sdlSurface2 := SDL_LoadBMP('./Images/caisse1.bmp');
  if sdlSurface2 = nil then
	Halt;
	
  sdlSurface3 := SDL_LoadBMP('./Images/blocglace.bmp');
  if sdlSurface2 = nil then
	Halt;
	    
  // Creer une texture à partir de surfaces
  
  sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
  if sdlTexture1 = nil then
    Halt;
    
  sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface2);
  if sdlTexture2 = nil then
    Halt;

  sdlTexture3 := IMG_LoadTexture(sdlRenderer, './Images/flocon.png');
  if sdlTexture3 = nil then 
	Halt;

  sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface3);
  if sdlTexture4 = nil then
    Halt;
    
  sdlTexture5 := IMG_LoadTexture(sdlRenderer, './Images/Boule_de_neige.png');
  if sdlTexture5 = nil then 
	Halt;

  sdlTexture6 := IMG_LoadTexture(sdlRenderer, './Images/etoile_glace2.png');
  if sdlTexture6 = nil then 
	Halt;   

  sdlTexture7 := IMG_LoadTexture(sdlRenderer, './Images/baton_glace.png');
  if sdlTexture7 = nil then 
	Halt;   
	
  sdlTexture8 := IMG_LoadTexture(sdlRenderer, './Images/tank1.png');
  if sdlTexture7 = nil then 
	Halt;   
	
  sdlTexture9 := IMG_LoadTexture(sdlRenderer, './Images/tank2.png');
  if sdlTexture7 = nil then 
	Halt;  

  sdlTexture10 := IMG_LoadTexture(sdlRenderer, './Images/tank3.png');
  if sdlTexture7 = nil then 
	Halt;
	
  // Créer une texture de rendu de 1200x800 pixels pour pouvoir enregistrer la carte en tant que texture à la fin de sa création
  //On pourra ainsi la réafficher plus facilement lors des mouvements
  backgroundTexture := SDL_CreateTexture(sdlRenderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, 1200, 800);
  if backgroundTexture = nil then
  begin
    WriteLn('Erreur de création de la texture de rendu: ', SDL_GetError);
    Halt(1);
  end;    	
	 
InitialiserTank(j1, 250, 100, 0);
InitialiserTank(j2, 500, 300, 180);
iniobst1(car1);
chargerTexturesT1(sdlRenderer);
chargerTexturesT2(sdlRenderer);
chargerTexturesT3(sdlRenderer);
iniScore(j1,j2);

  // Boucle principale
  isRunning := True;
  sdlKeyboardState := SDL_GetKeyboardState(nil);

  while isRunning do
  begin
    SDL_PumpEvents;
    
  //affichage des textures

  // Définir cette texture comme cible de rendu
  SDL_SetRenderTarget(sdlRenderer, backgroundTexture);
  
  //fond
	sdlRectangle.x:=0;
	sdlRectangle.y:=0;
	sdlRectangle.w:=1200;
	sdlRectangle.h:=800;
  SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, @sdlRectangle);
  
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
   
   sdlRectangle.x:=0;
   sdlRectangle.y:=0;
   sdlRectangle.w:=100;
   sdlRectangle.h:=50;   
   SDL_RenderCopy(sdlRenderer, TextureScore1, nil, @sdlRectangle);
   
   sdlRectangle.x:=0;
   sdlRectangle.y:=50;
   sdlRectangle.w:=100;
   sdlRectangle.h:=50;   
   SDL_RenderCopy(sdlRenderer, TexturePv1, nil, @sdlRectangle);  

   sdlRectangle.x:=1100;
   sdlRectangle.y:=0;
   sdlRectangle.w:=100;
   sdlRectangle.h:=50;   
   SDL_RenderCopy(sdlRenderer, TextureScore2, nil, @sdlRectangle);

   sdlRectangle.x:=1100;
   sdlRectangle.y:=50;
   sdlRectangle.w:=100;
   sdlRectangle.h:=50;   
   SDL_RenderCopy(sdlRenderer, TexturePv2, nil, @sdlRectangle);  
     
   // Rétablir le renderer par défaut
   SDL_SetRenderTarget(sdlRenderer, nil);
   
    // Affichage des tanks
    // Tank Joueur 1
    if j1.t.visible then
    begin
    sdlRectangle.x := j1.t.x;
    sdlRectangle.y := j1.t.y;
    sdlRectangle.w := 60;
    sdlRectangle.h := 60;
    //Affiche différents tanks en fonction du choix
    if j1.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
    if j1.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, sdlTexture9, nil, @sdlRectangle);		
    if j1.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, sdlTexture10, nil, @sdlRectangle);
	end;	
	
    // Tank Joueur 2
    if j2.t.visible then
    begin
    sdlRectangle.x := j2.t.x;
    sdlRectangle.y := j2.t.y;
    sdlRectangle.w := 60;
    sdlRectangle.h := 60;
    //Affiche différents tanks en fonction du choix
    if j2.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, sdlTexture8, nil, @sdlRectangle);
    if j2.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, sdlTexture9, nil, @sdlRectangle);		
    if j2.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, sdlTexture10, nil, @sdlRectangle);
	end;
	
    // Mettre à jour la position du rectangle rouge

    if sdlKeyboardState[SDL_SCANCODE_W] = 1 then avancer(j1,1,car1);
    if sdlKeyboardState[SDL_SCANCODE_S] = 1 then avancer(j1,-1,car1);

    // Appliquer la nouvelle position au rectangle rouge
  
	if sdlKeyboardState[SDL_SCANCODE_D] = 1 then 
	begin  if SDL_GetTicks - lastRotationTime1 > rotationDelay then
      begin
        TournerDroite(j1);
        lastRotationTime1 := SDL_GetTicks;
      end;
    end
    
    else if sdlKeyboardState[SDL_SCANCODE_A] = 1 then
    begin if SDL_GetTicks - lastRotationTime1 > rotationDelay then
      begin
        TournerGauche(j1);
        lastRotationTime1 := SDL_GetTicks;
      end;
     end;
     
     // Contrôles du tank T2
    if sdlKeyboardState[SDL_SCANCODE_UP] = 1 then avancer(j2, 1, car1); // Avancer
    if sdlKeyboardState[SDL_SCANCODE_DOWN] = 1 then avancer(j2, -1,car1); // Reculer

    if sdlKeyboardState[SDL_SCANCODE_RIGHT] = 1 then // Rotations vers la droite
    begin if SDL_GetTicks - lastRotationTime2 > rotationDelay then
      begin
        TournerDroite(j2);
        lastRotationTime2 := SDL_GetTicks;
      end;
    end

    else if sdlKeyboardState[SDL_SCANCODE_LEFT] = 1 then //Rotation vers la droite
    begin if SDL_GetTicks - lastRotationTime2 > rotationDelay then
      begin
        TournerGauche(j2);
        lastRotationTime2 := SDL_GetTicks;
      end;
    end;
    

j1.t.visible:=true;
j2.t.visible:=true;
gererCollision(j2, j1); // Vérifie si T1 touche T2
gererCollision(j1, j2); // Vérifie si T2 touche T1

      
    // Afficher le rendu final
    
    SDL_RenderClear(sdlRenderer); //Supprime les textures du renderer
    SDL_RenderCopy(sdlRenderer, backgroundTexture, nil, nil); //Affiche la carte de nouveau

	//Affichage des  les nouvelles positions du tank
    AfficherTank(j1,sdlRenderer);
	AfficherTank(j2,sdlRenderer);
	
	          // tirer les munitions T1
      
iniMun(j1);
if (sdlKeyboardState[SDL_SCANCODE_SPACE] = 1) and (SDL_GetTicks - lastshotTime1 > shotDelay) then
begin
  for i := 1 to 5 do
  begin
    // Trouver une balle inactive et la tirer
    if not j1.t.munitions[i].visible then
    begin
      tirer(j1, i);
          lastshotTime1 := SDL_GetTicks;// Initialise les coordonnées, direction, 
      Break; // On sort après avoir activé une balle 
    end;
  end;
end;



avancerballe(j1,car1);


      
      // affichtirs T1
for i:=1 to 5 do
begin
  if j1.t.munitions[i].visible then
  begin
    SDL_SetRenderDrawColor(sdlRenderer,255 ,0 , 0, SDL_ALPHA_OPAQUE); // Jaune
    sdlRectangle.x :=j1.t.munitions[i].x;
    sdlRectangle.y :=j1.t.munitions[i].y;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;
    SDL_RenderFillRect(sdlRenderer, @sdlRectangle);
    end;
  end;

 
 // tirer les munitions T2
      
iniMun(j1);
if (sdlKeyboardState[SDL_SCANCODE_L] = 1) and (SDL_GetTicks - lastshotTime2 > shotDelay) then
begin
  for i := 1 to 5 do
  begin
    // Trouver une balle inactive et la tirer
    if not j2.t.munitions[i].visible then
    begin
      tirer(j2, i);
          lastshotTime2 := SDL_GetTicks;// Initialise les coordonnées, direction, etc.
      Break; // On sort après avoir activé une balle
    end;
  end;
end;
avancerballe(j2,car1);


      
      // affichtirs T2
for i:=1 to 5 do
begin
  if j2.t.munitions[i].visible then
  begin
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, SDL_ALPHA_OPAQUE); // Jaune
    sdlRectangle.x :=j2.t.munitions[i].x;
    sdlRectangle.y :=j2.t.munitions[i].y;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;
    SDL_RenderFillRect(sdlRenderer, @sdlRectangle);
    end;
  end;
    
	//Affichage rendu
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(20);

    // Gestion des événements pour quitter la boucle
    while SDL_PollEvent(@event) <> 0 do
    begin
      if event.type_ = SDL_QUITEV then
        isRunning := False;
    end;
  end;
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
  SDL_DestroyTexture(sdlTexture9); 
  SDL_DestroyTexture(sdlTexture10);     
  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  // ferme la SDL2
  SDL_Quit;

//Affiche le gagnant
if j1.score>j2.score then
	begin
   	writeln('===================================================');	
	writeln(j1.nom,' a gagne la partie !');
	end;
if j1.score<j2.score then
	begin
   	writeln('===================================================');	
	writeln(j2.nom,' a gagne la partie !');	
	end;
if j1.score=j2.score then
	begin
   	writeln('===================================================');	
	writeln('Egalite parfaite !');
	end;
	
end;
	  

procedure jouercarte2(var j1,j2: joueur);
begin
lastRotationTime1 := SDL_GetTicks;
lastRotationTime2 := SDL_GetTicks;

  // Initialisation de la video du sous-système
  
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(1200, 800, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;
    
  // Creer des surfaces à partir de fichiers d'images
  
  sdlSurface1 := SDL_LoadBMP('./Images/herbe.bmp');
  if sdlSurface1 = nil then
    Halt;

  sdlSurface2 := SDL_LoadBMP('./Images/pierre_craque.bmp');
  if sdlSurface2 = nil then
	Halt;
	
  sdlSurface3 := SDL_LoadBMP('./Images/pierre_mossy.bmp');
  if sdlSurface2 = nil then
	Halt;

  sdlSurface4 := SDL_LoadBMP('./Images/or.bmp');
  if sdlSurface2 = nil then
	Halt;

  sdlSurface5 := SDL_LoadBMP('./Images/pierre_gris.bmp');
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

  sdlTexture6 := IMG_LoadTexture(sdlRenderer, './Images/liane.png');
  if sdlTexture6 = nil then 
	Halt;

  sdlTexture7 := IMG_LoadTexture(sdlRenderer, './Images/trefle.png');
  if sdlTexture7 = nil then 
	Halt;	

  sdlTexture8 := IMG_LoadTexture(sdlRenderer, './Images/fleur.png');
  if sdlTexture8 = nil then 
	Halt;

  sdlTexture9 := IMG_LoadTexture(sdlRenderer, './Images/tank1.png');
  if sdlTexture7 = nil then 
	Halt;   
	
  sdlTexture10 := IMG_LoadTexture(sdlRenderer, './Images/tank2.png');
  if sdlTexture7 = nil then 
	Halt;  

  sdlTexture11 := IMG_LoadTexture(sdlRenderer, './Images/tank3.png');
  if sdlTexture7 = nil then 
	Halt;

  // Créer une texture de rendu de 1200x800 pixels pour pouvoir enregistrer la carte en tant que texture à la fin de sa création
  //On pourra ainsi la réafficher plus facilement lors des mouvements
  backgroundTexture := SDL_CreateTexture(sdlRenderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, 1200, 800);
  if backgroundTexture = nil then
  begin
    WriteLn('Erreur de création de la texture de rendu: ', SDL_GetError);
    Halt(1);
  end;
	
InitialiserTank(j1, 40, 40, 0);
InitialiserTank(j2, 900, 500, 180);
iniobst2(car2);
chargerTexturesT1(sdlRenderer);
chargerTexturesT2(sdlRenderer);
chargerTexturesT3(sdlRenderer);

 // Boucle principale
  isRunning := True;
  sdlKeyboardState := SDL_GetKeyboardState(nil);

  while isRunning do
  begin
    SDL_PumpEvents;


  // Définir cette texture comme cible de rendu
  SDL_SetRenderTarget(sdlRenderer, backgroundTexture);
    
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
   
   // Rétablir le renderer par défaut
   SDL_SetRenderTarget(sdlRenderer, nil);
  
    // Affichage des tanks
    // Tank T1 rouge
    if j1.t.visible then
    begin
    sdlRectangle.x := j1.t.x;
    sdlRectangle.y := j1.t.y;
    sdlRectangle.w := 60;
    sdlRectangle.h := 60;
    if j1.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, sdlTexture9, nil, @sdlRectangle);
    if j1.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, sdlTexture10, nil, @sdlRectangle);		
    if j1.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, sdlTexture11, nil, @sdlRectangle);
	end;
		
    // Tank T2 bleu
    if j2.t.visible then
    begin
    sdlRectangle.x := j2.t.x;
    sdlRectangle.y := j2.t.y;
    sdlRectangle.w := 60;
    sdlRectangle.h := 60;
    if j2.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, sdlTexture9, nil, @sdlRectangle);
    if j2.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, sdlTexture10, nil, @sdlRectangle);		
    if j2.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, sdlTexture11, nil, @sdlRectangle);
	end;
		
 // Mettre à jour la position du rectangle rouge

    if sdlKeyboardState[SDL_SCANCODE_W] = 1 then avancer(j1,1,car2);
    if sdlKeyboardState[SDL_SCANCODE_S] = 1 then avancer(j1,-1,car2);

    // Appliquer la nouvelle position au rectangle rouge
  
	if sdlKeyboardState[SDL_SCANCODE_D] = 1 then 
	begin  if SDL_GetTicks - lastRotationTime1 > rotationDelay then
      begin
        TournerDroite(j1);
        AfficherTank(j1,sdlRenderer);
        lastRotationTime1 := SDL_GetTicks;
      end;
    end
    else if sdlKeyboardState[SDL_SCANCODE_A] = 1 then
    begin
      if SDL_GetTicks - lastRotationTime1 > rotationDelay then
      begin
        TournerGauche(j1);
        AfficherTank(j1,sdlRenderer);
        lastRotationTime1 := SDL_GetTicks;
      end;
      end;
       // Contrôles du tank T2
    if sdlKeyboardState[SDL_SCANCODE_UP] = 1 then avancer(j2, 1, car2); // Avancer
    if sdlKeyboardState[SDL_SCANCODE_DOWN] = 1 then avancer(j2, -1,car2); // Reculer

    if sdlKeyboardState[SDL_SCANCODE_RIGHT] = 1 then
      if SDL_GetTicks - lastRotationTime2 > rotationDelay then
      begin
        TournerDroite(j2);
        lastRotationTime2 := SDL_GetTicks;
      end;

    if sdlKeyboardState[SDL_SCANCODE_LEFT] = 1 then
      if SDL_GetTicks - lastRotationTime2 > rotationDelay then
      begin
        TournerGauche(j2);
        lastRotationTime2 := SDL_GetTicks;
      end;
      
j1.t.visible:=true;
j2.t.visible:=true;
gererCollision(j2, j1); // Vérifie si T1 touche T2
gererCollision(j1, j2); // Vérifie si T2 touche T1
      
    // Afficher le rendu final
    
    SDL_RenderClear(sdlRenderer); //Supprime les textures du renderer
    SDL_RenderCopy(sdlRenderer, backgroundTexture, nil, nil); //Affiche la carte de nouveau

	//Affichage des  les nouvelles positions du tank

    AfficherTank(j1,sdlRenderer);
    AfficherTank(j2,sdlRenderer);
    
	          // tirer les munitions T1
      
iniMun(j1);
if (sdlKeyboardState[SDL_SCANCODE_SPACE] = 1) and (SDL_GetTicks - lastshotTime1 > shotDelay) then
begin
  for i := 1 to 5 do
  begin
    // Trouver une balle inactive et la tirer
    if not j1.t.munitions[i].visible then
    begin
      tirer(j1, i);
          lastshotTime1 := SDL_GetTicks;// Initialise les coordonnées, direction, etc.
      Break; // On sort après avoir activé une balle
    end;
  end;
end;



avancerballe(j1,car2);


      
      // affichtirs T1
for i:=1 to 5 do
begin
  if j1.t.munitions[i].visible then
  begin
    SDL_SetRenderDrawColor(sdlRenderer, 255, 0, 0, SDL_ALPHA_OPAQUE); // Jaune
    sdlRectangle.x :=j1.t.munitions[i].x;
    sdlRectangle.y :=j1.t.munitions[i].y;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;
    SDL_RenderFillRect(sdlRenderer, @sdlRectangle);
    end;
  end;

 
 // tirer les munitions T2
      
iniMun(j1);
if (sdlKeyboardState[SDL_SCANCODE_L] = 1) and (SDL_GetTicks - lastshotTime2 > shotDelay) then
begin
  for i := 1 to 5 do
  begin
    // Trouver une balle inactive et la tirer
    if not j2.t.munitions[i].visible then
    begin
      tirer(j2, i);
          lastshotTime2 := SDL_GetTicks;// Initialise les coordonnées, direction, etc.
      Break; // On sort après avoir activé une balle
    end;
  end;
end;
avancerballe(j2,car2);


      
      // affichtirs T2
for i:=1 to 5 do
begin
  if j2.t.munitions[i].visible then
  begin
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, SDL_ALPHA_OPAQUE); // Jaune
    sdlRectangle.x :=j2.t.munitions[i].x;
    sdlRectangle.y :=j2.t.munitions[i].y;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;
    SDL_RenderFillRect(sdlRenderer, @sdlRectangle);
    end;
  end;
    
	//Affichage rendu
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(20);

    // Gestion des événements pour quitter la boucle
    while SDL_PollEvent(@event) <> 0 do
    begin
      if event.type_ = SDL_QUITEV then
        isRunning := False;
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
  SDL_DestroyTexture(sdlTexture9);   
  SDL_DestroyTexture(sdlTexture10);
  SDL_DestroyTexture(sdlTexture11);
  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  // ferme la SDL2
  SDL_Quit;
  
//Affiche le gagnant
if j1.score>j2.score then
	begin
   	writeln('===================================================');	
	writeln(j1.nom,' a gagne la partie !');
	end;
if j1.score<j2.score then
	begin
   	writeln('===================================================');	
	writeln(j2.nom,' a gagne la partie !');	
	end;
if j1.score=j2.score then
	begin
   	writeln('===================================================');	
	writeln('Egalite parfaite !');
	end;
	
end;


procedure jouercarte3(var j1,j2:joueur);
begin
lastRotationTime1 := SDL_GetTicks;
lastRotationTime2 := SDL_GetTicks;
  // Initialisation de la video du sous-système
  if SDL_Init(SDL_INIT_VIDEO) < 0 then Halt;

  if SDL_CreateWindowAndRenderer(1200, 800, SDL_WINDOW_SHOWN, @sdlWindow1, @sdlRenderer) <> 0
    then Halt;

  // Creer des surfaces à partir de fichiers d'images
  sdlSurface1 := SDL_LoadBMP('./Images/sable.bmp');
  if sdlSurface1 = nil then
    Halt;
    
  sdlSurface2 := SDL_LoadBMP('./Images/caisse1.bmp');
  if sdlSurface2 = nil then
	Halt;
	
  sdlSurface3 := SDL_LoadBMP('./Images/caisse2.bmp');
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
    
  sdlTexture4 := IMG_LoadTexture(sdlRenderer, './Images/troue1.png');
  if sdlTexture4 = nil then 
	Halt;

  sdlTexture5 := IMG_LoadTexture(sdlRenderer, './Images/liane.png');
  if sdlTexture5 = nil then 
	Halt;	

  sdlTexture6 := IMG_LoadTexture(sdlRenderer, './Images/etoile.png');
  if sdlTexture6 = nil then 
	Halt;
	
     sdlTexture7 := IMG_LoadTexture(sdlRenderer, './Images/coquillage.png');
  if sdlTexture7 = nil then 
	Halt;
	
     sdlTexture8 := IMG_LoadTexture(sdlRenderer, './Images/coquillage2.png');
  if sdlTexture8 = nil then 
	Halt;

	sdlTexture9 := IMG_LoadTexture(sdlRenderer, './Images/tank1.png');
  if sdlTexture7 = nil then 
	Halt;   
	
  sdlTexture10 := IMG_LoadTexture(sdlRenderer, './Images/tank2.png');
  if sdlTexture7 = nil then 
	Halt;  

  sdlTexture11 := IMG_LoadTexture(sdlRenderer, './Images/tank3.png');
  if sdlTexture7 = nil then 
	Halt;
	
  // Créer une texture de rendu de 1200x800 pixels pour pouvoir enregistrer la carte en tant que texture à la fin de sa création
  //On pourra ainsi la réafficher plus facilement lors des mouvements
  backgroundTexture := SDL_CreateTexture(sdlRenderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_TARGET, 1200, 800);
  if backgroundTexture = nil then
  begin
    WriteLn('Erreur de création de la texture de rendu: ', SDL_GetError);
    Halt(1);
  end;    

InitialiserTank(j1, 40, 40, 0);
InitialiserTank(j2, 1100, 700, 180);
iniobst3(car3);
chargerTexturesT1(sdlRenderer);
chargerTexturesT2(sdlRenderer);
chargerTexturesT3(sdlRenderer);

  // Boucle principale
  isRunning := True;
  sdlKeyboardState := SDL_GetKeyboardState(nil);

  while isRunning do
  begin
    SDL_PumpEvents;
    
    // Définir cette texture comme cible de rendu
	SDL_SetRenderTarget(sdlRenderer, backgroundTexture);

    // Dessiner le fond de sable sur toute la fenêtre
    SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);

    // Dessiner les caisses (caisse1 et caisse2)
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
	
	// Rétablir le renderer par défaut
	SDL_SetRenderTarget(sdlRenderer, nil);
	
	 // Affichage des tanks
    // Tank T1 rouge
    if j1.t.visible then
    begin
    sdlRectangle.x := j1.t.x;
    sdlRectangle.y := j1.t.y;
    sdlRectangle.w := 60;
    sdlRectangle.h := 60;
    if j1.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, sdlTexture9, nil, @sdlRectangle);
    if j1.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, sdlTexture10, nil, @sdlRectangle);		
    if j1.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, sdlTexture11, nil, @sdlRectangle);
	end;
		
    // Tank T2 bleu
    if j2.t.visible then
    begin
    sdlRectangle.x := j2.t.x;
    sdlRectangle.y := j2.t.y;
    sdlRectangle.w := 60;
    sdlRectangle.h := 60;
    if j2.t.nomt ='Vic' then
		SDL_RenderCopy(sdlRenderer, sdlTexture9, nil, @sdlRectangle);
    if j2.t.nomt ='Tom' then
		SDL_RenderCopy(sdlRenderer, sdlTexture10, nil, @sdlRectangle);		
    if j2.t.nomt ='JM' then
		SDL_RenderCopy(sdlRenderer, sdlTexture11, nil, @sdlRectangle);
	end;

    // Mettre à jour la position du rectangle rouge
  

    if sdlKeyboardState[SDL_SCANCODE_W] = 1 then avancer(j1,1,car3);
    if sdlKeyboardState[SDL_SCANCODE_S] = 1 then avancer(j1,-1,car3);

    // Appliquer la nouvelle position au rectangle rouge
  
	if sdlKeyboardState[SDL_SCANCODE_D] = 1 then 
	begin  if SDL_GetTicks - lastRotationTime1 > rotationDelay then
      begin
        TournerDroite(j1);
        lastRotationTime1 := SDL_GetTicks;
      end;
    end
    else if sdlKeyboardState[SDL_SCANCODE_A] = 1 then
    begin
      if SDL_GetTicks - lastRotationTime1 > rotationDelay then
      begin
        TournerGauche(j1);
        lastRotationTime1 := SDL_GetTicks;
      end;
      end;
       // Contrôles du tank T2
    if sdlKeyboardState[SDL_SCANCODE_UP] = 1 then avancer(j2, 1,car3); // Avancer
    if sdlKeyboardState[SDL_SCANCODE_DOWN] = 1 then avancer(j2, -1,car3); // Reculer

    if sdlKeyboardState[SDL_SCANCODE_RIGHT] = 1 then
      if SDL_GetTicks - lastRotationTime2 > rotationDelay then
      begin
        TournerDroite(j2);
        lastRotationTime2 := SDL_GetTicks;
      end;

    if sdlKeyboardState[SDL_SCANCODE_LEFT] = 1 then
      if SDL_GetTicks - lastRotationTime2 > rotationDelay then
      begin
        TournerGauche(j2);
        lastRotationTime2 := SDL_GetTicks;
      end;

j1.t.visible:=true;
j2.t.visible:=true;
gererCollision(j2, j1); // Vérifie si T1 touche T2
gererCollision(j1, j2); // Vérifie si T2 touche T1
	
	// Afficher le rendu final
    
    SDL_RenderClear(sdlRenderer); //Supprime les textures du renderer
    SDL_RenderCopy(sdlRenderer, backgroundTexture, nil, nil); //Affiche la carte de nouveau

	//Affichage des  les nouvelles positions du tank

    AfficherTank(j1,sdlRenderer);
    AfficherTank(j2,sdlRenderer);

iniMun(j1);
if (sdlKeyboardState[SDL_SCANCODE_SPACE] = 1) and (SDL_GetTicks - lastshotTime1 > shotDelay) then
begin
  for i := 1 to 5 do
  begin
    // Trouver une balle inactive et la tirer
    if not j1.t.munitions[i].visible then
    begin
      tirer(j1, i);
          lastshotTime1 := SDL_GetTicks;// Initialise les coordonnées, direction, etc.
      Break; // On sort après avoir activé une balle
    end;
  end;
end;



avancerballe(j1,car3);


      
      // affichtirs T1
for i:=1 to 5 do
begin
  if j1.t.munitions[i].visible then
  begin
    SDL_SetRenderDrawColor(sdlRenderer, 255, 0, 0, SDL_ALPHA_OPAQUE); // Jaune
    sdlRectangle.x :=j1.t.munitions[i].x;
    sdlRectangle.y :=j1.t.munitions[i].y;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;
    SDL_RenderFillRect(sdlRenderer, @sdlRectangle);
    end;
  end;

 
 // tirer les munitions T2
      
iniMun(j1);
if (sdlKeyboardState[SDL_SCANCODE_L] = 1) and (SDL_GetTicks - lastshotTime2 > shotDelay) then
begin
  for i := 1 to 5 do
  begin
    // Trouver une balle inactive et la tirer
    if not j2.t.munitions[i].visible then
    begin
      tirer(j2, i);
          lastshotTime2 := SDL_GetTicks;// Initialise les coordonnées, direction, etc.
      Break; // On sort après avoir activé une balle
    end;
  end;
end;
avancerballe(j2,car3);


      
      // affichtirs T2
for i:=1 to 5 do
begin
  if j2.t.munitions[i].visible then
  begin
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, SDL_ALPHA_OPAQUE); // Jaune
    sdlRectangle.x :=j2.t.munitions[i].x;
    sdlRectangle.y :=j2.t.munitions[i].y;
    sdlRectangle.w := 10;
    sdlRectangle.h := 10;
    SDL_RenderFillRect(sdlRenderer, @sdlRectangle);
    end;
  end;
  
	//Affichage rendu
    SDL_RenderPresent(sdlRenderer);
    SDL_Delay(20);

    // Gestion des événements pour quitter la boucle
    while SDL_PollEvent(@event) <> 0 do
    begin
      if event.type_ = SDL_QUITEV then
        isRunning := False;
    end;
  end;

  // Nettoyage de la mémoire
  SDL_DestroyTexture(sdlTexture1);
  SDL_DestroyTexture(sdlTexture2);
  SDL_DestroyTexture(sdlTexture3);
  SDL_DestroyTexture(sdlTexture4);
  SDL_DestroyTexture(sdlTexture5);
  SDL_DestroyTexture(sdlTexture6);
  SDL_DestroyTexture(sdlTexture7);
  SDL_DestroyTexture(sdlTexture8);
  SDL_DestroyTexture(sdlTexture9);
  SDL_DestroyTexture(sdlTexture10);
  SDL_DestroyTexture(sdlTexture11);
  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow(sdlWindow1);
  SDL_Quit;
  
//Affiche le gagnant
if j1.score>j2.score then
	begin
   	writeln('===================================================');	
	writeln(j1.nom,' a gagne la partie !');
	end;
if j1.score<j2.score then
	begin
   	writeln('===================================================');	
	writeln(j2.nom,' a gagne la partie !');	
	end;
if j1.score=j2.score then
	begin
   	writeln('===================================================');	
	writeln('Egalite parfaite !');
	end;
	
end;

end.
