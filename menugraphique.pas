program menutest;

uses SDL2, SDL2_image, SDL2_ttf;

var
  isRunning: Boolean;
  event: TSDL_Event;
  sdlSurface1, sdlSurface2, sdlSurface3, sdlSurface4: PSDL_Surface;
  ttfFont: PTTF_Font;
  sdlColor1: TSDL_Color;
  sdlWindow1, sdlWindow2: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlTexture1, sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5: PSDL_Texture;
  sdlRectangle: TSDL_Rect;

procedure ReactClicJouer();
begin
	if event.type_ = SDL_MOUSEBUTTONDOWN then
	begin
    // Vérifier si le clic est dans la zone du rectangle "Jouer"
		if (event.button.x >= 400) and (event.button.x <= 800) and (event.button.y >= 600) and (event.button.y <= 750) then
        begin
          // Ouvrir une nouvelle fenêtre pour démarrer un jeu (ou une autre action)
          sdlWindow2 := SDL_CreateWindow('TankMania', 300, 100, 1200, 800, SDL_WINDOW_SHOWN);
          if sdlWindow2 = nil then HALT;

          // Créer un renderer pour la nouvelle fenêtre
        sdlRenderer := SDL_CreateRenderer(sdlWindow2, -1, SDL_RENDERER_ACCELERATED);
          if sdlRenderer = nil then HALT;
			
		  //détruit l'ancienne fenetre
		  SDL_DestroyWindow(sdlWindow1);
		  
          // Afficher un fond ou des éléments dans la nouvelle fenêtre
          SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, 255);
          SDL_RenderClear(sdlRenderer);
          SDL_RenderPresent(sdlRenderer);
        end;
    end;
end;

begin

  // Initialisation de la sous-système vidéo
  if SDL_Init(SDL_INIT_VIDEO) < 0 then HALT;

  sdlWindow1 := SDL_CreateWindow('Menu', 300, 100, 1200, 800, SDL_WINDOW_SHOWN);
  if sdlWindow1 = nil then HALT;

  sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, 0);
  if sdlRenderer = nil then HALT;

  // Initialisation du moteur TrueType et chargement de la police
  if TTF_Init = -1 then HALT;
  ttfFont := TTF_OpenFont('/usr/share/fonts/truetype/crosextra/Caladea-Bold.ttf', 100);
  TTF_SetFontStyle(ttfFont, TTF_STYLE_UNDERLINE or TTF_STYLE_ITALIC);
  TTF_SetFontOutline(ttfFont, 0);
  TTF_SetFontHinting(ttfFont, TTF_HINTING_NORMAL);

  // Définition des couleurs par valeurs RGB
  sdlColor1.r := 0; sdlColor1.g := 255; sdlColor1.b := 0;

  // Rendu du texte sur une SDL_Surface
  sdlSurface1 := TTF_RenderText_Blended(ttfFont, 'TankMania', sdlColor1);
  
  sdlSurface2 := TTF_RenderText_Blended(ttfFont, 'By Tom, Jean Matthieu and Victor', sdlColor1);

  sdlSurface3 := TTF_RenderText_Blended(ttfFont, 'JOUER', sdlColor1);
  
  sdlSurface4:= SDL_LoadBMP('/home/vhrab/Bureau/PROJET/Images/FondMenu.bmp');

  // Conversion de SDL_Surface en SDL_Texture
  sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
  
  sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface2);

  sdlTexture3 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface3);
  
  sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface4);
  
  //Texture png

  sdlTexture5 := IMG_LoadTexture(sdlRenderer, '/home/vhrab/Bureau/PROJET/Images/bouton1.png');
  if sdlTexture5 = nil then 
	Halt;	

  
  //affichage nom
  SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, nil);
  
  //bouton du haut

  // Définir un rectangle titre TankMania (600x200) à la position (300, 100)
  sdlRectangle.x := 280;
  sdlRectangle.y := 80;
  sdlRectangle.w := 650;  // Largeur du rectangle
  sdlRectangle.h := 250;  // Hauteur du rectangle

  // Rendu de la texture dans le rectangle spécifié
  SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);

  // Définir un rectangle titre TankMania (600x200) à la position (300, 100)
  sdlRectangle.x := 300;
  sdlRectangle.y := 100;
  sdlRectangle.w := 600;  // Largeur du rectangle
  sdlRectangle.h := 200;  // Hauteur du rectangle
  
  SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, @sdlRectangle);

  // Définir un rectangle Créateurs (1100x100) à la position (50, 350)
  sdlRectangle.x := 50;
  sdlRectangle.y := 350;
  sdlRectangle.w := 1100;  // Largeur du rectangle
  sdlRectangle.h := 100;  // Hauteur du rectangle 
 
  // Rendu de la texture dans le rectangle spécifié
  SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);

  // Définir un rectangle Jouer (400x150) à la position (400, 600)
  sdlRectangle.x := 400;
  sdlRectangle.y := 600;
  sdlRectangle.w := 400;  // Largeur du rectangle
  sdlRectangle.h := 150;  // Hauteur du rectangle

  // Rendu de la texture dans le rectangle spécifié
  SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle); 
  
  SDL_RenderPresent(sdlRenderer); 

  // Boucle pour afficher indéfiniment l'écran
  isRunning := True;

  while isRunning do
  begin
    while SDL_PollEvent(@event) <> 0 do
    begin
      if event.type_ = SDL_QUITEV then
        isRunning := False
      else
		ReactClicJouer();
	end;
  end;

  // Nettoyage
  TTF_CloseFont(ttfFont);
  TTF_Quit;

  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  SDL_FreeSurface(sdlSurface4);
  SDL_DestroyTexture(sdlTexture1);
  SDL_DestroyTexture(sdlTexture2);
  SDL_DestroyTexture(sdlTexture3);
  SDL_DestroyTexture(sdlTexture4);
  SDL_DestroyTexture(sdlTexture5);
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow(sdlWindow1);

  // Fermeture du sous-système vidéo
  SDL_Quit;
end.
