program menutest;

uses SDL2, SDL2_image, SDL2_ttf, unitemenu, types;

var
  isRunning: Boolean;
  event: TSDL_Event;
  sdlSurface1, sdlSurface2, sdlSurface3, sdlSurface4,sdlSurface5, sdlSurface6: PSDL_Surface;
  ttfFont, ttfFont2: PTTF_Font;
  sdlColor1, sdlColor2: TSDL_Color;
  sdlWindow1, sdlWindow2: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlTexture1, sdlTexture2, sdlTexture3, sdlTexture4, sdlTexture5, sdlTexture6,sdlTexture7, sdlTexture8: PSDL_Texture;
  sdlRectangle: TSDL_Rect;
  EntrerJoueur1, EntrerJoueur2, estMenuActif, saisieComplete: Boolean;
  j1,j2:joueur;

procedure ReactClicJouer();
begin
	if event.type_ = SDL_MOUSEBUTTONDOWN then
	begin
    // Vérifier si le clic est dans la zone du rectangle "Jouer"
		if (event.button.x >= 400) and (event.button.x <= 800) and (event.button.y >= 350) and (event.button.y <= 500) then
        begin
          //Marquer la fin de menu avec le boolean
          estMenuActif:=False;
          
          // Ouvrir une nouvelle fenêtre pour démarrer un jeu (ou une autre action)
          sdlWindow2 := SDL_CreateWindow('TankMania', 100, 100, 1200, 800, SDL_WINDOW_SHOWN);
          if sdlWindow2 = nil then HALT;

          // Créer un renderer pour la nouvelle fenêtre
        sdlRenderer := SDL_CreateRenderer(sdlWindow2, -1, SDL_RENDERER_ACCELERATED);
          if sdlRenderer = nil then HALT;
			
		  //détruit l'ancienne fenetre
		  SDL_DestroyWindow(sdlWindow1);
		  
		  //Activer la saisie de tete pour le premier joueur
          SDL_StartTextInput;
          EntrerJoueur1 := True;
          EntrerJoueur2 := False;		  
		  
          // Afficher un fond ou des éléments dans la nouvelle fenêtre
          SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, 255);
          SDL_RenderClear(sdlRenderer);
          SDL_RenderPresent(sdlRenderer);
        end;
    end;
end;

procedure RenderNomJoueur(text: string; x,y,w,h:integer; color: TSDL_Color);
var
	surface: PSDL_Surface;
	texture: PSDL_Texture;
begin
  surface := TTF_RenderText_Blended(ttfFont, PAnsiChar(AnsiString(text)), color); //creer une surface pour le texte 
  texture := SDL_CreateTextureFromSurface(sdlRenderer, surface); //creer une texture pour le texte

  //position de la case dans laquelle on va rentrer le texte
  sdlRectangle.x := x; 
  sdlRectangle.y := y;
  sdlRectangle.w := w;
  sdlRectangle.h := h;

  SDL_RenderCopy(sdlRenderer, texture, nil, @sdlRectangle);

  //liberer la mémoire
  SDL_FreeSurface(surface);
  SDL_DestroyTexture(texture);	
end;

begin

  // Initialisation de la sous-système vidéo
  if SDL_Init(SDL_INIT_VIDEO) < 0 then HALT;

  sdlWindow1 := SDL_CreateWindow('Menu', 100, 100, 1200, 800, SDL_WINDOW_SHOWN);
  if sdlWindow1 = nil then HALT;

  sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, 0);
  if sdlRenderer = nil then HALT;

  // Initialisation du moteur TrueType et chargement de la police
  //police 1
  if TTF_Init = -1 then HALT;
  ttfFont := TTF_OpenFont('C:\WINDOWS\fonts\Comic.ttf', 100); //cherche la police
  TTF_SetFontStyle(ttfFont, TTF_STYLE_BOLD); //met le texte en gras
  TTF_SetFontOutline(ttfFont, 0); //creer un contour ou non au texte
  TTF_SetFontHinting(ttfFont, TTF_HINTING_NORMAL);
  
  //police 2
  if TTF_Init = -1 then HALT;
  ttfFont2 := TTF_OpenFont('C:\WINDOWS\fonts\Arial.ttf', 100); //cherche la police
  TTF_SetFontStyle(ttfFont2, TTF_STYLE_BOLD);
  TTF_SetFontOutline(ttfFont2, 0); //creer un contour ou non au texte
  TTF_SetFontHinting(ttfFont2, TTF_HINTING_NORMAL);
  
  // Définition des couleurs par valeurs RGB pour la police 1
  sdlColor1.r := 103; sdlColor1.g := 175; sdlColor1.b :=76;
  
  // Définition des couleurs par valeurs RGB pour la police 2
  sdlColor2.r := 255; sdlColor2.g := 255; sdlColor2.b := 255;
  
  // Rendu du texte sur une SDL_Surface
  sdlSurface1 := TTF_RenderText_Blended(ttfFont, 'TankMania', sdlColor1);
  
  sdlSurface2 := TTF_RenderText_Blended(ttfFont2, 'By Tom, Jean Matthieu and Victor', sdlColor2);

  sdlSurface3 := TTF_RenderText_Blended(ttfFont, 'JOUER', sdlColor1);
  
  sdlSurface4:= SDL_LoadBMP('C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\FondMenu.bmp');
  
  sdlSurface5:= TTF_RenderText_Blended(ttfFont, 'Joueur 1:', sdlColor1);
  
  sdlSurface6:= TTF_RenderText_Blended(ttfFont, 'Joueur 2:', sdlColor1);

  // Conversion de SDL_Surface en SDL_Texture
  sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
  
  sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface2);

  sdlTexture3 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface3);
  
  sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface4);
  
  sdlTexture7 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface5);
  
  sdlTexture8 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface6);
  
  //Texture png

  sdlTexture5 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\bouton1.png');
  if sdlTexture5 = nil then 
	Halt;	
	
  sdlTexture6 := IMG_LoadTexture(sdlRenderer, 'C:\Users\victo\Desktop\PROJET INFO STPI2\Code\images\bouton2.png');
  if sdlTexture5 = nil then 
	Halt;	

  
  //affichage nom
  SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, nil);
  
  //bouton du haut

  // Définir un rectangle titre TankMania (600x200) à la position (300, 100)
  sdlRectangle.x := 300;
  sdlRectangle.y := 50;
  sdlRectangle.w := 600;  // Largeur du rectangle
  sdlRectangle.h := 200;  // Hauteur du rectangle

  // Rendu de la texture dans le rectangle spécifié
  SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle);

  // Définir un rectangle titre TankMania (600x200) à la position (300, 100)
  sdlRectangle.x := 350;
  sdlRectangle.y := 100;
  sdlRectangle.w := 500;  // Largeur du rectangle
  sdlRectangle.h := 100;  // Hauteur du rectangle
  
  SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, @sdlRectangle);

  // Définir un rectangle Créateurs (1100x100) à la position (50, 350)
  sdlRectangle.x := 300;
  sdlRectangle.y := 240;
  sdlRectangle.w := 600;  // Largeur du rectangle
  sdlRectangle.h := 50;  // Hauteur du rectangle 
 
  // Rendu de la texture dans le rectangle spécifié
  SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);

  // Définir un rectangle Jouer (400x150) à la position (400, 600)
  sdlRectangle.x := 400;
  sdlRectangle.y := 350;
  sdlRectangle.w := 400;  // Largeur du rectangle
  sdlRectangle.h := 150;  // Hauteur du rectangle

  // Rendu de la texture dans le rectangle spécifié
  SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle); 
  
  SDL_RenderPresent(sdlRenderer); 

  // Boucle pour afficher indéfiniment l'écran
  isRunning := True;
  estMenuActif:= True;
  saisieComplete:=False;
  
  //initialisation des noms des deux joueurs
  j1.nom:='';
  j2.nom:='';
  
  //initialisation des boolean
  EntrerJoueur1 := False;
  EntrerJoueur2 := False;

  while isRunning do
  begin
    while SDL_PollEvent(@event) <> 0 do
    begin
      if event.type_ = SDL_QUITEV then
        isRunning := False
      else if estMenuActif and (event.type_ = SDL_MOUSEBUTTONDOWN) then

        // Réagir au clic sur "Jouer"
        ReactClicJouer()
      else if not estMenuActif then 
      begin
        // Gérer la saisie des noms si elle est activée
        if (event.type_ = SDL_TEXTINPUT) then
        begin
          if EntrerJoueur1 then
            j1.nom := j1.nom + event.text.text
          else if EntrerJoueur2 then
            j2.nom := j2.nom + event.text.text;
        end
        else if (event.type_ = SDL_KEYDOWN) then
        begin
          if event.key.keysym.sym = SDLK_RETURN then
          begin
            if EntrerJoueur1 then
            begin
              EntrerJoueur1 := False;
              EntrerJoueur2 := True;  // Passer au joueur 2
            end
            else
            begin
              EntrerJoueur2 := False;
              SDL_StopTextInput; // Désactiver la saisie de texte
              saisieComplete:=True;
            end;
          end
          else if event.key.keysym.sym = SDLK_BACKSPACE then
          begin
            if EntrerJoueur1 and (Length(j1.nom) > 0) then
              Delete(j1.nom, Length(j1.nom), 1)
            else if EntrerJoueur2 and (Length(j2.nom) > 0) then
              Delete(j2.nom, Length(j2.nom), 1);
          end;
          
        end;
      end;
    end;

 // Affichage dans le menu ou la deuxième fenêtre selon l'état
    if estMenuActif then
    begin
      // Afficher le menu principal
      SDL_RenderPresent(sdlRenderer);
    end
    else
    begin
     // Afficher les noms des joueurs
     SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 255, 255); // Définir la couleur de fond (ici, bleu)
     SDL_RenderClear(sdlRenderer); // Effacer l'écran avant de redessiner
  
     // Affiche message si saisie terminée
      if saisieComplete then
        begin
          // indique que la saisie est terminée
          RenderNomJoueur('Saisie terminée!', 100, 300, 10,20, sdlColor2);
       end
      else
        begin
          // Affichage des noms des joueurs en temps réel
          sdlRectangle.x := 100;
		  sdlRectangle.y := 100;
		  sdlRectangle.w := 100;  // Largeur du rectangle
		  sdlRectangle.h := 30;  // Hauteur du rectangle
		  SDL_RenderCopy(sdlRenderer, sdlTexture7, nil, @sdlRectangle);
		  RenderNomJoueur('Nom Joueur 1: ' + j1.nom, 200, 100,100,30, sdlColor2);
		  
          RenderNomJoueur('Nom Joueur 2: ' + j2.nom, 100, 200,100,30, sdlColor2);
        end;

      SDL_RenderPresent(sdlRenderer); // Actualiser l'écran
     end;
  end;

  // Nettoyage
  TTF_CloseFont(ttfFont);
  TTF_CloseFont(ttfFont2);
  TTF_Quit;

  SDL_FreeSurface(sdlSurface1);
  SDL_FreeSurface(sdlSurface2);
  SDL_FreeSurface(sdlSurface3);
  SDL_FreeSurface(sdlSurface4);
  SDL_FreeSurface(sdlSurface5);
  SDL_FreeSurface(sdlSurface6);
  SDL_DestroyTexture(sdlTexture1);
  SDL_DestroyTexture(sdlTexture2);
  SDL_DestroyTexture(sdlTexture3);
  SDL_DestroyTexture(sdlTexture4);
  SDL_DestroyTexture(sdlTexture5);
  SDL_DestroyTexture(sdlTexture6);
  SDL_DestroyTexture(sdlTexture7);
  SDL_DestroyTexture(sdlTexture8);
  SDL_DestroyRenderer(sdlRenderer);
  SDL_DestroyWindow(sdlWindow1);
  SDL_DestroyWindow(sdlWindow2);

  // Fermeture du sous-système vidéo
  SDL_Quit;
end.
