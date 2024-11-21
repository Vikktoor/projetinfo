unit u_menu;

interface

uses sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf,
    u_types, u_maj, u_maj_calcul;

procedure AffMajMenu(var partie : TPartie);

procedure InitialisationMenu(var partie : TPartie);

procedure  AffMajMenuInGame(var partie : Tpartie);

procedure InitialisationMenuInGame(var partie : TPartie);

procedure ChoixNiveauInitialisation(var partie : TPartie);

procedure AffMajChoixNiveau(var partie : TPartie ; init : Boolean);

implementation

procedure InitialisationMenu(var partie : TPartie);

begin 
    partie.menu.fond := IMG_LoadTexture(partie.fenetre.renderer, 'ressource/image/menu/fond.jpg');
    // initialise le btn jouer
    partie.menu.btnJouer.estCliquee := False;
    partie.menu.btnJouer.largeur := 200;
    partie.menu.btnJouer.hauteur := 75;
    partie.menu.btnJouer.skin.cheminAccees := 'ressource/image/bouton/Jouer.jpg' ;
    partie.menu.btnJouer.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menu.btnJouer.skin.cheminAccees);
    partie.menu.btnJouer.Bcord.x := partie.fenetre.largeurFenetre div 2 - partie.menu.btnJouer.largeur div 2;
    partie.menu.btnJouer.Bcord.y := partie.fenetre.hauteurFenetre div 2 - partie.menu.btnJouer.hauteur div 2 + 50;

    // initialise le btn Son
    partie.menu.btnSon.estCliquee := False;
    partie.menu.btnSon.largeur := 200;
    partie.menu.btnSon.hauteur := 75;
    partie.menu.btnSon.skin.cheminAccees := 'ressource/image/bouton/son.jpg' ;
    partie.menu.btnSon.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menu.btnSon.skin.cheminAccees);
    partie.menu.btnSon.Bcord.x := 10;
    partie.menu.btnSon.Bcord.y := 10;

    // initialise le btn Entrainement
    partie.menu.btnEntrainement.estCliquee := False;
    partie.menu.btnEntrainement.largeur := 200;
    partie.menu.btnEntrainement.hauteur := 75;
    partie.menu.btnEntrainement.skin.cheminAccees := 'ressource/image/bouton/entrainement.jpg' ;
    partie.menu.btnEntrainement.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menu.btnEntrainement.skin.cheminAccees);
    partie.menu.btnEntrainement.Bcord.x := partie.fenetre.largeurFenetre div 2 - partie.menu.btnJouer.largeur div 2;
    partie.menu.btnEntrainement.Bcord.y := partie.fenetre.hauteurFenetre div 2 - partie.menu.btnJouer.hauteur div 2 - 50;

    // initialisation du son 
    partie.menu.music.bandeSon := Mix_LoadMUS('ressource/son/Legends Never Die.mp3');
    Mix_PlayMusic(partie.menu.music.bandeSon, -1);
    partie.menu.music.estJouee := True;
end;


procedure InitialisationMenuInGame(var partie : TPartie);

begin
    partie.menuIG.fond := IMG_LoadTexture(partie.fenetre.renderer, 'ressource/image/menu/mini.png');
    // initialise le btn Son in Game 
    partie.menuIG.btnSon.estCliquee := False;
    partie.menuIG.btnSon.largeur := 30;
    partie.menuIG.btnSon.hauteur := 30;
    partie.menuIG.btnSon.skin.cheminAccees := 'ressource/image/bouton/son.jpg' ;
    partie.menuIG.btnSon.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuIG.btnSon.skin.cheminAccees);
    partie.menuIG.btnSon.Bcord.x := 10;
    partie.menuIG.btnSon.Bcord.y := 10;

    partie.menuIG.btnMenu.estCliquee := False;
    partie.menuIG.btnMenu.largeur := 30;
    partie.menuIG.btnMenu.hauteur := 30;
    partie.menuIG.btnMenu.skin.cheminAccees := 'ressource/image/bouton/btnMenu.png' ;
    partie.menuIG.btnMenu.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuIG.btnMenu.skin.cheminAccees);
    partie.menuIG.btnMenu.Bcord.x := 10;
    partie.menuIG.btnMenu.Bcord.y := 50;

    partie.menuIG.btnBruitage.estCliquee := False;
    partie.menuIG.btnBruitage.largeur := 30;
    partie.menuIG.btnBruitage.hauteur := 30;
    partie.menuIG.btnBruitage.skin.cheminAccees := 'ressource/image/bouton/son - Copie.jpg' ;
    partie.menuIG.btnBruitage.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuIG.btnBruitage.skin.cheminAccees);
    partie.menuIG.btnBruitage.Bcord.x := 50;
    partie.menuIG.btnBruitage.Bcord.y := 10;

    // initialisation son 
    partie.menuIG.music.bandeSon := Mix_LoadMUS('ressource/son/Mystery Man.mp3');
    Mix_PlayMusic(partie.menuIG.music.bandeSon, -1);
    partie.menuIG.music.estJouee := True;
end;

procedure ChoixNiveauInitialisation(var partie : TPartie);

const largeur = 350;
const hauteur = 100;
const espace = hauteur + 50;
const premier = 50;

begin
    //le fond
    partie.menuNiveau.fond := IMG_LoadTexture(partie.fenetre.renderer, 'ressource/image/menu/fond - Copie.jpg');

    // les boutons ne fonctionne pas avec une boucle car on peut pas créer des chemin d'accès a cause du types des chemin
    // Pchar (Pchar ('bbbbb' + intTostr(i) + 'jpg')--> Pchar pointe a chaque fois sur le même chemin d'acces (le dernier crée)
    {setlength(partie.menuNiveau.lstBtn, 5);
    for i := 0 to 4 do 
        begin
        partie.menuNiveau.lstBtn[i].estCliquee := False;
        partie.menuNiveau.lstBtn[i].largeur := largeur;
        partie.menuNiveau.lstBtn[i].hauteur := hauteur;
        partie.menuNiveau.lstBtn[i].skin.cheminAccees := Pchar('ressource/image/bouton/lvl ' + IntToStr(i) + '.jpg');
        partie.menuNiveau.lstBtn[i].skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuNiveau.lstBtn[i].skin.cheminAccees);
        partie.menuNiveau.lstBtn[i].Bcord.x := partie.fenetre.largeurFenetre div 2 - largeur div 2;
        partie.menuNiveau.lstBtn[i].Bcord.y := premier + i*espace;
        writeln(partie.menuNiveau.lstBtn[i].skin.cheminAccees);
        writeln(partie.menuNiveau.lstBtn[0].skin.cheminAccees);
        end;}
        
    partie.menuNiveau.facile.estCliquee := False;
    partie.menuNiveau.facile.largeur := largeur;
    partie.menuNiveau.facile.hauteur := hauteur;
    partie.menuNiveau.facile.skin.cheminAccees := 'ressource/image/bouton/lvl facile.jpg' ;
    partie.menuNiveau.facile.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuNiveau.facile.skin.cheminAccees);
    partie.menuNiveau.facile.Bcord.x := partie.fenetre.largeurFenetre div 2 - largeur div 2;
    partie.menuNiveau.facile.Bcord.y := premier;

    partie.menuNiveau.moyen.estCliquee := False;
    partie.menuNiveau.moyen.largeur := largeur;
    partie.menuNiveau.moyen.hauteur := hauteur;
    partie.menuNiveau.moyen.skin.cheminAccees := 'ressource/image/bouton/lvl moyen.jpg' ;
    partie.menuNiveau.moyen.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuNiveau.moyen.skin.cheminAccees);
    partie.menuNiveau.moyen.Bcord.x := partie.fenetre.largeurFenetre div 2 - largeur div 2;
    partie.menuNiveau.moyen.Bcord.y := espace * 1 + premier;

    partie.menuNiveau.difficle.estCliquee := False;
    partie.menuNiveau.difficle.largeur := largeur;
    partie.menuNiveau.difficle.hauteur := hauteur;
    partie.menuNiveau.difficle.skin.cheminAccees := 'ressource/image/bouton/lvl difficlie.jpg' ;
    partie.menuNiveau.difficle.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuNiveau.difficle.skin.cheminAccees);
    partie.menuNiveau.difficle.Bcord.x := partie.fenetre.largeurFenetre div 2 - largeur div 2;
    partie.menuNiveau.difficle.Bcord.y := espace * 2 + premier;

    partie.menuNiveau.extreme.estCliquee := False;
    partie.menuNiveau.extreme.largeur := largeur;
    partie.menuNiveau.extreme.hauteur := hauteur;
    partie.menuNiveau.extreme.skin.cheminAccees := 'ressource/image/bouton/lvl extreme.jpg' ;
    partie.menuNiveau.extreme.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuNiveau.extreme.skin.cheminAccees);
    partie.menuNiveau.extreme.Bcord.x := partie.fenetre.largeurFenetre div 2 - largeur div 2;
    partie.menuNiveau.extreme.Bcord.y := espace * 3 + premier;

    partie.menuNiveau.impossible.estCliquee := False;
    partie.menuNiveau.impossible.largeur := largeur;
    partie.menuNiveau.impossible.hauteur := hauteur;
    partie.menuNiveau.impossible.skin.cheminAccees := 'ressource/image/bouton/lvl impossible.jpg' ;
    partie.menuNiveau.impossible.skin.texture := IMG_LoadTexture(partie.fenetre.renderer, partie.menuNiveau.impossible.skin.cheminAccees);
    partie.menuNiveau.impossible.Bcord.x := partie.fenetre.largeurFenetre div 2 - largeur div 2;
    partie.menuNiveau.impossible.Bcord.y := espace * 4 + premier;
end;


procedure AfficheBouton(bouton : TBouton; var renderer : PSDL_Renderer);

var rect : TSDL_RECT;

begin
    rect.x := round(bouton.Bcord.x);
    rect.y := round(bouton.Bcord.y);
    rect.w := bouton.largeur;
    rect.h := bouton.hauteur;
    SDL_RenderCopy (renderer , bouton.skin.texture , nil, @rect);
end;


procedure GestionBtnSon(var btn : TBouton ; var music : Tmusic);

begin
	if btn.estCliquee then
	    begin
	        writeln('log 1 ');
	        btn.estCliquee := False;
	        if music.estJouee then
	            begin
	                writeln('log 2 ');
	                music.estJouee := False;
	                Mix_HaltMusic;
	            end
	        else
	            begin
	                Mix_PlayMusic(music.bandeSon, -1);
	                music.estJouee := True; 
	            end;
	        end;
end;


procedure ReglageNiveau(var partie : TPartie ; init : Boolean);

begin
    if partie.menuNiveau.facile.estCliquee then
        begin
	        partie.menuNiveau.niveau := 1;
	        init := False
        end;
    if partie.menuNiveau.moyen.estCliquee then
        begin
	        partie.menuNiveau.niveau := 2;
	        init := False
        end;
    if partie.menuNiveau.difficle.estCliquee then
        begin
	        partie.menuNiveau.niveau := 3;
	        init := False
        end;
    if partie.menuNiveau.extreme.estCliquee then
        begin
	        partie.menuNiveau.niveau := 4;
	        init := False
        end;
    if partie.menuNiveau.impossible.estCliquee then
        begin
	        partie.menuNiveau.niveau := 5;
	        init := False
        end;
end;


procedure AffMajMenu(var partie : TPartie);

var fond : PSDL_Texture;

begin
    //maj
    estCliquee(partie.menu.btnJouer, partie.fenetre);
    estCliquee(partie.menu.btnSon, partie.fenetre);
    estCliquee(partie.menu.btnEntrainement, partie.fenetre);
    GestionBtnSon(partie.menu.btnSon, partie.menu.music);

    //aff
    SDL_RenderCopy (partie.fenetre.renderer , partie.menu.fond , nil, nil);
    AfficheBouton(partie.menu.btnJouer, partie.fenetre.renderer);
    AfficheBouton(partie.menu.btnSon, partie.fenetre.renderer);
    AfficheBouton(partie.menu.btnEntrainement, partie.fenetre.renderer);
end;


procedure  AffMajMenuInGame(var partie : Tpartie);

var rect : TSDL_RECT;

begin
    // maj
    estCliquee(partie.menuIG.btnSon, partie.fenetre);
    estCliquee(partie.menuIG.btnMenu, partie.fenetre);
    estCliquee(partie.menuIG.btnBruitage, partie.fenetre);
    GestionBtnSon(partie.menuIG.btnSon, partie.menuIG.music);

    //aff
    rect.x := 0;
    rect.y := 0;
    rect.h := 100;
    rect.w := 100;
    SDL_RenderCopy(partie.fenetre.renderer , partie.menuIG.fond , nil, @rect);
    AfficheBouton(partie.menuIG.btnSon, partie.fenetre.renderer);
    AfficheBouton(partie.menuIG.btnMenu, partie.fenetre.renderer);
    AfficheBouton(partie.menuIG.btnBruitage, partie.fenetre.renderer);
end;


procedure AffMajChoixNiveau(var partie : TPartie ; init : Boolean);

begin
	//maj
	estCliquee(partie.menuNiveau.facile, partie.fenetre);
	estCliquee(partie.menuNiveau.moyen, partie.fenetre);
	estCliquee(partie.menuNiveau.difficle, partie.fenetre);
	estCliquee(partie.menuNiveau.extreme, partie.fenetre);
	estCliquee(partie.menuNiveau.impossible, partie.fenetre);
	ReglageNiveau(partie, init);
	
	//aff
	SDL_RenderCopy(partie.fenetre.renderer , partie.menuNiveau.fond , nil, nil);
	AfficheBouton(partie.menuNiveau.facile, partie.fenetre.renderer);
	AfficheBouton(partie.menuNiveau.moyen, partie.fenetre.renderer);
	AfficheBouton(partie.menuNiveau.difficle, partie.fenetre.renderer);
	AfficheBouton(partie.menuNiveau.extreme, partie.fenetre.renderer);
	AfficheBouton(partie.menuNiveau.impossible, partie.fenetre.renderer);
end;

begin
end.
