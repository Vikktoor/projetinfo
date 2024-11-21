unit reset;

interface

uses main;

procedure pp();


implementation

procedure pp();

var
    partie :  u_types.TPartie;
    init : Boolean;
    musicMenu : Tmusic;
    musicJeux : Tmusic;


begin
   
	// Definition des types 
    partie.gagnee := False ;
	partie.score := 0 ;
	
    randomize ;
    
    partie.fenetre.largeurFenetre := 1040;
    partie.fenetre.hauteurFenetre := 780;
    
    SDL_CreateWindowAndRenderer(partie.fenetre.largeurFenetre, partie.fenetre.hauteurFenetre, SDL_WINDOW_SHOWN, @partie.fenetre.window, @partie.fenetre.renderer);	
    
    {partie.fenetre.window := SDL_CreateWindow('4 night', SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, partie.fenetre.largeurFenetre, partie.fenetre.hauteurFenetre, SDL_WINDOW_SHOWN);
    partie.fenetre.renderer := SDL_CreateRenderer(partie.fenetre.window, -1,  SDL_RENDERER_ACCELERATED);}
	//SDL_RENDERER_ACCELERATED (fonctionne que sur PC portable débranché)

	//Initialisation   
    SDL_Init(SDL_INIT_VIDEO);
    Mix_OpenAudio(44100, MIX_DEFAULT_FORMAT, 2, 2048);

    partie.joueur.Jcord.x := 600 ; 
    partie.joueur.Jcord.y := 200 ;
    
    InitialisationMenu(partie);
    // Boucle principale
    init := True;
    
    while not partie.gagnee do
		begin
	        SDL_PollEvent(@partie.fenetre.event) ;
	        if partie.menu.btnEntrainement.estCliquee then
	            begin
					partie.entrainement := True;
					SDL_Delay(2);
	                if partie.menu.music.estJouee then //stop la music
	                    begin
	                        partie.menu.music.estJouee := False;
	                        Mix_HaltMusic;
	                    end;
	                    
	                if init then
	                    begin
	                        InitialisationMenuInGame(partie);
	                        InitialisationPartie(partie, musicJeux);
	                        init := False;
	                    end;
		            // Effacer l'écran avec une couleur
		            SDL_RenderClear(partie.fenetre.renderer);
		            u_maj_2.MiseAJour(partie, True);
		            // Affic	her le contenu
		            u_aff.Affichage(partie, partie.menuIG, True);
	            end
	        else 
	        if partie.menu.btnJouer.estCliquee then
		        begin
					partie.entrainement := False ;
		            SDL_Delay(2);
		            // Effacer l'écran avec une couleur
		            SDL_RenderClear(partie.fenetre.renderer);
		            if partie.menu.music.estJouee then //stop la music
						begin
							partie.menu.music.estJouee := False;
							Mix_HaltMusic;
						end;
		            if init then
		                begin
		                    InitialisationMenuInGame(partie);
		                    InitialisationPartieRobot(partie);
		                    init := False;
		                end;
		            u_maj_2.MiseAJour(partie, False);
		            // Afficher le contenu
		            u_aff.Affichage(partie, partie.menuIG, False);
		        end
			else 
				AffMajMenu(partie);
			
			if partie.fenetre.event.type_ = SDL_QUITEV then 
				partie.gagnee := True;
	        SDL_RenderPresent(partie.fenetre.renderer);
	    end;

    // Libérer les ressources
    setlength(partie.map.lstDecors, 0) ;
    setlength(partie.joueur.Armes, 0) ; 
    setlength(partie.map.lstProjectiles, 0) ;
    SDL_DestroyRenderer(partie.fenetre.renderer);
    SDL_DestroyWindow(partie.fenetre.window);
    SDL_Quit;
    Mix_CloseAudio;
    Mix_Quit;
end;


begin
end.
