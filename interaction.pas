unit interaction ;

Interface 
uses types,SDL2, SDL2_image,SDL2_ttf,crt;
const
  SURFACE_WIDTH = 550;
  SURFACE_HEIGHT = 120;

var
  sdlWindow1: PSDL_Window;
  sdlRenderer: PSDL_Renderer;
  sdlTexture1, sdlTexture2,sdlTexture3,sdlTexture4,sdlTexture5,sdlTexture6: PSDL_Texture;
  sdlRectangle: TSDL_Rect;
  sdlColor1, sdlColor2: TSDL_Color;
  ttfFont: PTTF_Font;
  sdlSurface1, sdlSurface2, sdlSurface3, sdlSurface4: PSDL_Surface;

procedure afficTank(T: Ttank);

procedure choixTank(T :Ttank;var j: joueur);

procedure menu(var j1,j2:joueur;Tabt:Ttank);

procedure AffichScore(var j1,j2:joueur);

Implementation

procedure afficTank(T: Ttank);
var i:integer;
Begin 
	For i:=1 to 3 do
		begin
			writeln();
			writeln('Tank numero ',i);
			writeln('nom :',T[i].nomt);
			writeln('degats :',T[i].degats);
			writeln('Pv :',T[i].Pv);
			writeln('coefficient de vitesse :',T[i].vitesse:3:2);
		end;


end;

procedure choixTank(T :Ttank;var j: joueur);
var n :integer;
Begin
	writeln(j.nom,', quel tank choisissez vous ? ');
	readln(n);
	while (n<1) or (n>3) do
		begin
			writeln('Veuillez entrer un nombre compris entre 1 et 3');
			readln(n);
		end;
	j.t.nomT:=T[n].nomt;
	j.t.degats:=T[n].degats;
	j.t.Pv:=T[n].Pv;
	j.t.vitesse:=T[n].vitesse;
end;

procedure menu(var j1,j2:joueur;Tabt:Ttank);

BEGIN
	
	afficTank(Tabt);
	writeln();
	writeln('j1 veuillez rentrer votre nom');
	readln(j1.nom);
	writeln('j2 veuillez rentrer votre nom');
	readln(j2.nom);
	choixTank(Tabt,j1);
	writeln();
	writeln('Recap: ');
	writeln(j1.nom,', votre tank s''appelle ',j1.t.nomT,'.');
	writeln('Chaque boulet inflige ',j1.t.degats,' degats a votre adversaire.');
	writeln('Votre tank a ' ,j1.t.Pv,' Pv.');
	writeln('Votre tank a un coefficient de vitesse de ' ,j1.t.vitesse:3:2,' .');
	choixTank(Tabt,j2);
	writeln();
	writeln('Recap: ');
	writeln(j2.nom,', votre tank s''appelle ',j2.t.nomT,'.');
	writeln('Chaque boulet inflige ',j2.t.degats,' degats a votre adversaire.');
	writeln('Votre tank a ' ,j2.t.Pv,' Pv.');
	writeln('Votre tank a un coefficient de vitesse de ' ,j1.t.vitesse:3:2,' .');
	
END;





procedure AffichScore(var j1, j2: joueur);
begin
    // Initialisation de SDL
    if SDL_Init(SDL_INIT_VIDEO) < 0 then
		Halt;
     
   //Chargement de la police
	if TTF_Init = -1 then HALT;
		ttfFont := TTF_OpenFont('./Police/Arialn.ttf', 100); //cherche la police
		TTF_SetFontOutline(ttfFont, 1); //creer un contour ou non au texte
		TTF_SetFontHinting(ttfFont, TTF_HINTING_NORMAL);
  
  
  
	// Définition des couleurs par valeurs RGB pour la police 1 et 2
	sdlColor1.r := 255; sdlColor1.g := 255; sdlColor1.b :=255;
	sdlColor2.r := 0; sdlColor2.g := 0; sdlColor2.b :=0;
  
	// Création de la fenêtre et du renderer 
	sdlWindow1 := SDL_CreateWindow('Affichage de l''image', SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, SURFACE_WIDTH, SURFACE_HEIGHT, SDL_WINDOW_SHOWN);
	if sdlWindow1 = nil then
		Halt;

	sdlRenderer := SDL_CreateRenderer(sdlWindow1, -1, SDL_RENDERER_ACCELERATED);
	if sdlRenderer = nil then
		Halt;
 
 
 
	// Transformation du texte en surface
	case j1.nom of
	'JM' :sdlSurface1 := TTF_RenderText_Blended(ttfFont,'JM', sdlColor1);  // On ne peut pas mettre une variable dans l'affichage de texte donc on définit quelques noms de la classe sinon on met J1 par defaut 
	'Tom':sdlSurface1 := TTF_RenderText_Blended(ttfFont,'Tom', sdlColor1);
	'Victor':sdlSurface1 := TTF_RenderText_Blended(ttfFont,'Tom', sdlColor1);
	else sdlSurface1 := TTF_RenderText_Blended(ttfFont, 'J1', sdlColor1);
	end;
	if sdlSurface1 = nil then
		Halt;
		
	case j2.nom of
	'JM' :sdlSurface2 := TTF_RenderText_Blended(ttfFont,'JM', sdlColor1);  // On ne peut pas mettre une variable dans l'affichage de texte donc on définit quelques noms de la classe sinon on met J2 par defaut
	'Tom':sdlSurface2 := TTF_RenderText_Blended(ttfFont,'Tom', sdlColor1);
	'Victor':sdlSurface2 := TTF_RenderText_Blended(ttfFont,'Tom', sdlColor1);
	else sdlSurface2 := TTF_RenderText_Blended(ttfFont, 'J2', sdlColor1);
	end;
	if sdlSurface2 = nil then
		Halt;
		
	case j1.score of
	1:sdlSurface3 := TTF_RenderText_Blended(ttfFont,'1', sdlColor1);  // On ne peut pas mettre une variable dans l'affichage de texte donc on définit 5 points maximum par joueur
	2:sdlSurface3 := TTF_RenderText_Blended(ttfFont,'2', sdlColor1);
	3:sdlSurface3 := TTF_RenderText_Blended(ttfFont,'3', sdlColor1);
	4:sdlSurface3 := TTF_RenderText_Blended(ttfFont,'4', sdlColor1);
	5:sdlSurface3 := TTF_RenderText_Blended(ttfFont,'5', sdlColor1);
	end;
	if sdlSurface3 = nil then
		Halt;
		
	case j2.score of
	1:sdlSurface4 := TTF_RenderText_Blended(ttfFont,'1', sdlColor1);  // On ne peut pas mettre une variable dans l'affichage de texte donc on définit 5 points maximum par joueur
	2:sdlSurface4 := TTF_RenderText_Blended(ttfFont,'2', sdlColor1);
	3:sdlSurface4 := TTF_RenderText_Blended(ttfFont,'3', sdlColor1);
	4:sdlSurface4 := TTF_RenderText_Blended(ttfFont,'4', sdlColor1);
	5:sdlSurface4 := TTF_RenderText_Blended(ttfFont,'5', sdlColor1);
	end;
	if sdlSurface4 = nil then
		Halt;
		
		
		
		
		
    // Charger les textures (images)
    sdlTexture1 := IMG_LoadTexture(sdlRenderer, './Images/fond_noir.png');
    if sdlTexture1 = nil then
		Halt;
      
    sdlTexture2 := IMG_LoadTexture(sdlRenderer, './Images/score.png');
    if sdlTexture2 = nil then
		Halt;
      
	sdlTexture3 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface1);
	if sdlTexture3 = nil then
		Halt;
	
	sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface2);
	if sdlTexture4 = nil then
		Halt;
		
	sdlTexture5 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface3);
	if sdlTexture5 = nil then
		Halt;
		
	sdlTexture6 := SDL_CreateTextureFromSurface(sdlRenderer, sdlSurface4);
	if sdlTexture6 = nil then
		Halt;
	
	// Définir la taille et la position du fond noir
	SDL_QueryTexture(sdlTexture1, nil, nil, @sdlRectangle.w, @sdlRectangle.h);// prend la valeur de hauteur et largeur de la photo en elle-meme
	sdlRectangle.x := (SURFACE_WIDTH - sdlRectangle.w) div 2;
    sdlRectangle.y := (SURFACE_HEIGHT - sdlRectangle.h) div 2;
    
	// Effacer l'écran et afficher l'image de fond
	SDL_RenderCopy(sdlRenderer, sdlTexture1, nil, nil);  // Affiche le fond noir
	
	// Définir la position de l'image de score
    sdlRectangle.x := 0;
    sdlRectangle.y := 0;
    sdlRectangle.w := 550;
    sdlRectangle.h := 120;
	SDL_RenderCopy(sdlRenderer, sdlTexture2, nil, @sdlRectangle);// Afficher l'image du score a la meme position que le fond noir
    
   	// Définir la position du nom du joueur 1
    sdlRectangle.x := 10;
    sdlRectangle.y := 25;
    sdlRectangle.w := 75;
    sdlRectangle.h := 50; 
    SDL_RenderCopy(sdlRenderer, sdlTexture3, nil, @sdlRectangle); //Affiche le nom du joueur 1
    
    // Définir la position du nom du joueur 2
    sdlRectangle.x := 470;
    sdlRectangle.y := 25;
    sdlRectangle.w := 75;
    sdlRectangle.h := 50; 
    SDL_RenderCopy(sdlRenderer, sdlTexture4, nil, @sdlRectangle); //Affiche le nom du joueur 2
    
    // Définir la position du score du joueur 1
    sdlRectangle.x := 200;
    sdlRectangle.y := 25;
    sdlRectangle.w := 30;
    sdlRectangle.h := 50; 
    SDL_RenderCopy(sdlRenderer, sdlTexture5, nil, @sdlRectangle); //Affiche le score du joueur 1
    
    // Définir la position du score du joueur 2
	sdlRectangle.x := 300;
    sdlRectangle.y := 25;
    sdlRectangle.w := 30;
    sdlRectangle.h := 50; 
    SDL_RenderCopy(sdlRenderer, sdlTexture6, nil, @sdlRectangle); //Affiche le score du joueur 2
	
    // Mettre à jour l'écran
    SDL_RenderPresent(sdlRenderer);

	delay(5000);

	// Libération des ressources
	SDL_DestroyTexture(sdlTexture1);
	SDL_DestroyTexture(sdlTexture2);
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);
    SDL_Quit;
end;





end.
