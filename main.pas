program SDL2Window;

uses sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf,
	u_types, u_aff, u_maj, u_menu, init_u_aff;
   
var
    partie :  u_types.TPartie;
    init : Boolean;
    musicMenu : Tmusic;
    musicJeux : Tmusic;


procedure reset(var btn : Tbouton ; var partie : Tpartie ; var init : Boolean);

begin
	if partie.menuIG.btnMenu.estCliquee then
		begin
			btn.estCliquee := False;
			partie.menuIG.btnMenu.estCliquee := False;
			partie.menu.btnEntrainement.estCliquee := False;
			partie.menu.btnJouer.estCliquee := False;
			partie.menuNiveau.niveau := -1; 
			InitialisationMenu(partie);
			init := True;
		end;
end;


procedure stopMusicMenu(var partie : TPartie);

begin

if partie.menu.music.estJouee then //stop la music
		begin
			partie.menu.music.estJouee := False;
			Mix_HaltMusic;
		end;
end;

procedure modeEntrainement(var partie : Tpartie; var init : Boolean);

begin

	partie.entrainement := True; //mode de jeux

	stopMusicMenu(partie);
		
	if init then
		begin
			InitialisationMenuInGame(partie);
			InitialisationPartie(partie, musicJeux);
			init := False;
		end;

	MiseAJour(partie, True);
	Affichage(partie, partie.menuIG, True);

	reset(partie.menu.btnEntrainement , partie, init); 	// regarde si on repart sur le menu
end;

procedure modeJeux(var partie : Tpartie; var init : Boolean);
begin
	partie.entrainement := False ;
	stopMusicMenu(partie);
	if init then	//initialise le mode de jeux
		begin
			writeln('l1');
			InitialisationMenuInGame(partie);
			writeln('l2');
			InitialisationPartieRobot(partie);
			init := False;
			writeln('l2');
		end;
	writeln('l3');
	MiseAJour(partie, False);
	writeln('l4');
	Affichage(partie, partie.menuIG, False);
	writeln('l5');
	reset(partie.menu.btnJouer , partie, init);	// regarde si on repart sur le menu
end;


procedure gestionMenuNiveau(var partie : Tpartie; init : Boolean);
begin
	if init then 
		begin
		partie.menuNiveau.niveau := -1;
		ChoixNiveauInitialisation(partie);
		init := False;
		end;
	AffMajChoixNiveau(partie, init);
end;


begin
	// Definition des types 
    partie.gagnee := False ;
	partie.score := 0 ;
    partie.fenetre.largeurFenetre := 1040;
    partie.fenetre.hauteurFenetre := 780;
	partie.joueur.Jcord.x := 600 ; 
    partie.joueur.Jcord.y := 200 ;
    SDL_CreateWindowAndRenderer(partie.fenetre.largeurFenetre, partie.fenetre.hauteurFenetre, SDL_WINDOW_SHOWN, @partie.fenetre.window, @partie.fenetre.renderer);	

	//Initialisation   
    SDL_Init(SDL_INIT_VIDEO);
    Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 2048);
    InitialisationMenu(partie);

    // Boucle principale
    init := True; //savoir quand initialiser les modes de jeux
    while not partie.gagnee do
		begin
			SDL_Delay(5);
			SDL_RenderClear(partie.fenetre.renderer); // on vide le renderer
			SDL_PollEvent(@partie.fenetre.event);
			//pour les différents boutons
	        if partie.menu.btnEntrainement.estCliquee then
				begin
					if partie.menuNiveau.niveau > 0 then
						modeEntrainement(partie, init)
					else
						gestionMenuNiveau(partie, init);
				end
	        else if partie.menu.btnJouer.estCliquee then
				begin
					if partie.menuNiveau.niveau > 0 then
						modeJeux(partie, init) 
					else
						gestionMenuNiveau(partie, init);
				end
			else
				AffMajMenu(partie);
			//quitter
			if partie.fenetre.event.type_ = SDL_QUITEV then 
				partie.gagnee := True;
				
	        SDL_RenderPresent(partie.fenetre.renderer); 
	    end;

    // Libérer les ressources
    setlength(partie.map.lstArmes, 0) ;
    setlength(partie.map.lstDecors, 0) ;
    setlength(partie.joueur.Armes, 0) ; 
    setlength(partie.map.lstProjectiles, 0) ;
    SDL_DestroyRenderer(partie.fenetre.renderer);
    SDL_DestroyWindow(partie.fenetre.window);
    SDL_Quit;
    Mix_CloseAudio;
    Mix_Quit;
end.
