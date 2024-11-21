unit init_u_aff;

interface

uses sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf, 
	u_types, u_menu;

procedure InitialisationPartie(var partie : TPartie ; musicJeux : Tmusic);

procedure InitialisationPartieRobot(var partie : TPartie);


implementation

procedure InitialisationPartie(var partie : TPartie ; musicJeux : Tmusic);

var i : integer ;
	
begin
	//affichage ATH joueur
	partie.menuIG.skinFond.cheminAccees := 'ressource\image\arme\fond.png';
	partie.menuIG.skinFond.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.menuIG.skinFond.cheminAccees);

	partie.menuIG.skinMun.cheminAccees := 'ressource\image\arme\munition.png';
	partie.menuIG.skinMun.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.menuIG.skinMun.cheminAccees);
		
    //affichage du joueur
    partie.joueur.vie.total := 100;
    partie.joueur.vie.actuel := partie.joueur.vie.total;
    
    partie.joueur.vie.skin.cheminAccees := 'ressource\image\personnage\Vie.png';
    partie.joueur.vie.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.vie.skin.cheminAccees); 
    
    partie.joueur.vie.fond.cheminAccees := 'ressource\image\personnage\fondVie.png';
    partie.joueur.vie.fond.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.vie.fond.cheminAccees); 

    partie.joueur.vie.son := Mix_LoadWAV('ressource/son/degat/aie-x5-99381-mp3cutnet-1_1fZAAvYY.wav');
    
    partie.joueur.direction.x := 15;
    partie.joueur.direction.y := 0;
    
	partie.joueur.skinRepo.cheminAccees := 'ressource\image\personnage\perso0.png'; 
    partie.joueur.skinRepo.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.skinRepo.cheminAccees); 
	
    partie.joueur.skinTir.cheminAccees := 'ressource\image\personnage\perso1.png'; 
    partie.joueur.skinTir.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.skinTir.cheminAccees); 
	
	//init arme du joueur
	setlength(partie.joueur.Armes, 1) ; 
	partie.joueur.armes[0].cadence := 30 ; // Nombre de frame avant de pouvoir re-tirer
	partie.joueur.armes[0].compteur := partie.joueur.Armes[0].cadence ; // Pour que le joueur puisse tirer dès la 1er frame
	partie.joueur.armes[0].degat := 10 ;
	partie.joueur.armes[0].precision := 20 ;
	partie.joueur.armes[0].nbProjectilesMax := 15 ;
	partie.joueur.armes[0].nbProjectiles := partie.joueur.armes[0].nbProjectilesMax ;
	
	//skin de l'arme
	partie.joueur.armes[0].skin.cheminAccees := 'ressource/image/arme/glock.png' ;
	partie.joueur.armes[0].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.armes[0].skin.cheminAccees);
	
	//on charge les textures des projectilles pour les différentes armes : 
    partie.joueur.armes[0].projectileSkin.cheminAccees := 'ressource/image/projectile/arme1.png' ;
	partie.joueur.armes[0].projectileSkin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.armes[0].projectileSkin.cheminAccees);
    partie.joueur.armes[0].son := Mix_LoadWAV('ressource/son/gun.wav');
	
    //affichage map
    partie.map.skin.cheminAccees := 'ressource/image/map/m1.jpg';
    partie.map.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.skin.cheminAccees);
    
    //Initialisation Arme Ramassable
	setlength(partie.map.lstArmes, 1) ;
	
	//affichage de l'arme
	partie.map.lstArmes[0].afficher := True ;
	partie.map.lstArmes[0].skin.cheminAccees := 'ressource/image/arme/ak.png' ;
	partie.map.lstArmes[0].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstArmes[0].skin.cheminAccees);
	partie.map.lstArmes[0].Acord.x := 600 ;
	partie.map.lstArmes[0].Acord.y := 320 ; 
	partie.map.lstArmes[0].largeur := 90 ;
	partie.map.lstArmes[0].hauteur := 90 ;
	
	
	//caractéristique de l'arme	
	partie.map.lstArmes[0].projectileSkin.cheminAccees := 'ressource/image/projectile/arme2.png';
	partie.map.lstArmes[0].projectileSkin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstArmes[0].projectileSkin.cheminAccees);
	partie.map.lstArmes[0].cadence := 20 ; // Nombre de frame avant de pouvoir re-tirer
	partie.map.lstArmes[0].degat := 10 ;
	partie.map.lstArmes[0].precision := 20 ;
	partie.map.lstArmes[0].nbProjectilesMax := 30 ;
	partie.map.lstArmes[0].nbProjectiles := partie.map.lstArmes[0].nbProjectilesMax ;
    partie.map.lstArmes[0].son := Mix_LoadWAV('ressource/son/GUNAuto_Coup-de-feu-de-beretta-m12-9-mm-_ID-0437__LS.wav');

    //affichage decor (map 1)
    setlength(partie.map.lstDecors, 7);
    
    partie.map.lstDecors[0].skin.cheminAccees := 'ressource\image\decor\BoxGauche.png';
    partie.map.lstDecors[0].hLargeur := 100 div 2;
    partie.map.lstDecors[0].hHauteur := 100 div 2;
    partie.map.lstDecors[0].Largeur := 100;
    partie.map.lstDecors[0].Hauteur := 100;
    partie.map.lstDecors[0].Dcord.x := 250 ;
    partie.map.lstDecors[0].Dcord.y := 400 ;
    
    partie.map.lstDecors[1].skin.cheminAccees := 'ressource\image\decor\BoxDroite.png';
    partie.map.lstDecors[1].hLargeur := 80 div 2;
    partie.map.lstDecors[1].hHauteur := 80 div 2;
    partie.map.lstDecors[1].Largeur := 80 ;
    partie.map.lstDecors[1].Hauteur := 80;
    partie.map.lstDecors[1].Dcord.x := 750 ;
    partie.map.lstDecors[1].Dcord.y := 275 ;	
    
    partie.map.lstDecors[2].skin.cheminAccees := 'ressource\image\decor\Jeep2.png';
    partie.map.lstDecors[2].hLargeur := 135 div 2;
    partie.map.lstDecors[2].hHauteur := 170 div 2;
    partie.map.lstDecors[2].Largeur := 135;
    partie.map.lstDecors[2].Hauteur := 170;
    partie.map.lstDecors[2].Dcord.x := 975 ;
    partie.map.lstDecors[2].Dcord.y := 85 ;	
    
    partie.map.lstDecors[3].skin.cheminAccees := 'ressource\image\decor\MurBas.png';
    partie.map.lstDecors[3].hLargeur := 120 div 2;
    partie.map.lstDecors[3].hHauteur := 20 div 2;
    partie.map.lstDecors[3].Largeur := 120;
    partie.map.lstDecors[3].Hauteur := 20;
    partie.map.lstDecors[3].Dcord.x := 575 ;
    partie.map.lstDecors[3].Dcord.y := 524 ;	
    
    partie.map.lstDecors[4].skin.cheminAccees := 'ressource\image\decor\MurGauche.png';
    partie.map.lstDecors[4].hLargeur := 20 div 2;
    partie.map.lstDecors[4].hHauteur := 170 div 2;
    partie.map.lstDecors[4].Largeur := 20;
    partie.map.lstDecors[4].Hauteur := 170;
    partie.map.lstDecors[4].Dcord.x := 525 ;
    partie.map.lstDecors[4].Dcord.y := 450 ;	
    
    partie.map.lstDecors[5].skin.cheminAccees := 'ressource\image\decor\palmierGauche.png';
    partie.map.lstDecors[5].hLargeur := 200 div 2;
    partie.map.lstDecors[5].hHauteur := 50 div 2;
    partie.map.lstDecors[5].Largeur := 300;
    partie.map.lstDecors[5].Hauteur := 100;
    partie.map.lstDecors[5].Dcord.x := 150 ;
    partie.map.lstDecors[5].Dcord.y := 50 ;	
    
    partie.map.lstDecors[6].skin.cheminAccees := 'ressource\image\decor\palmierDroit.png';
    partie.map.lstDecors[6].hLargeur := 250 div 2;
    partie.map.lstDecors[6].hHauteur := 40 div 2;
    partie.map.lstDecors[6].Largeur := 330;
    partie.map.lstDecors[6].Hauteur := 80;
    partie.map.lstDecors[6].Dcord.x := 800 ;
    partie.map.lstDecors[6].Dcord.y := 40 ;	
	
	for i:= 0 to length(partie.map.lstDecors) - 1 do
		begin
			partie.map.lstDecors[i].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstDecors[i].skin.cheminAccees);
		end;
	
    //initialisation des cibles 
    setlength(partie.map.lstCibles, 2);
    
    for i := 0 to 1 do
		begin
		    partie.map.lstCibles[i].vie.total := 50;
		    partie.map.lstCibles[i].vie.actuel := partie.map.lstCibles[0].vie.total;
		    
		    partie.map.lstCibles[i].vie.skin.cheminAccees := 'ressource\image\personnage\Vie.png';
		    partie.map.lstCibles[i].vie.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstCibles[i].vie.skin.cheminAccees); 
		    
		    partie.map.lstCibles[i].vie.fond.cheminAccees := 'ressource\image\personnage\fondVie.png';
		    partie.map.lstCibles[i].vie.fond.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstCibles[i].vie.fond.cheminAccees); 
		    partie.map.lstCibles[i].vie.son := Mix_LoadWav('ressource/son/degat/characterpain-163914.wav');

		    partie.map.lstCibles[i].arme.degat := round(1.3*exp(partie.menuNiveau.niveau)) ;
		    partie.map.lstCibles[i].arme.projectileSkin.cheminAccees := 'ressource\image\projectile\cible.png';
			partie.map.lstCibles[i].arme.projectileSkin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstCibles[i].arme.projectileSkin.cheminAccees); 
			partie.map.lstCibles[i].arme.cadence := 30 ;
			partie.map.lstCibles[i].arme.compteur := partie.map.lstCibles[i].arme.cadence ;
            partie.map.lstCibles[i].arme.son := Mix_LoadWAV('ressource/son/GUNShotg_Fusil tir 2 (ID 2854)_LS.wav');
		    
		    partie.map.lstCibles[i].skin.cheminAccees := 'ressource\image\cible\cible.png';
		    partie.map.lstCibles[i].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstCibles[i].skin.cheminAccees);
		    
		    partie.map.lstCibles[i].Ccord.x := (i + 1)*250;
		    partie.map.lstCibles[i].Ccord.y := (i + 1)*300;
		end;
		
	setlength(partie.map.lstProjectiles, 0);
end;


procedure InitialisationPartieRobot(var partie : TPartie);

var i : integer ;

begin
    //affichage ATH joueur
	partie.menuIG.skinFond.cheminAccees := 'ressource\image\arme\fond.png';
	partie.menuIG.skinFond.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.menuIG.skinFond.cheminAccees);

	partie.menuIG.skinMun.cheminAccees := 'ressource\image\arme\munition.png';
	partie.menuIG.skinMun.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.menuIG.skinMun.cheminAccees);
		
    //affichage du joueur
    partie.joueur.vie.total := 100;
    partie.joueur.vie.actuel := partie.joueur.vie.total;
    
    partie.joueur.vie.skin.cheminAccees := 'ressource\image\personnage\Vie.png';
    partie.joueur.vie.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.vie.skin.cheminAccees); 
    
    partie.joueur.vie.fond.cheminAccees := 'ressource\image\personnage\fondVie.png';
    partie.joueur.vie.fond.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.vie.fond.cheminAccees); 

    partie.joueur.vie.son := Mix_LoadWAV('ressource/son/degat/aie-x5-99381-mp3cutnet-1_1fZAAvYY.wav');
    
    partie.joueur.direction.x := 15;
    partie.joueur.direction.y := 0;
    
	partie.joueur.skinRepo.cheminAccees := 'ressource\image\personnage\perso0.png'; 
    partie.joueur.skinRepo.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.skinRepo.cheminAccees); 
	
    partie.joueur.skinTir.cheminAccees := 'ressource\image\personnage\perso1.png'; 
    partie.joueur.skinTir.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.skinTir.cheminAccees); 
	
	//init arme du joueur
	setlength(partie.joueur.Armes, 1) ; 
	partie.joueur.armes[0].cadence := 30 ; // Nombre de frame avant de pouvoir re-tirer
	partie.joueur.armes[0].compteur := partie.joueur.Armes[0].cadence ; // Pour que le joueur puisse tirer dès la 1er frame
	partie.joueur.armes[0].degat := 10 ;
	partie.joueur.armes[0].precision := 20 ;
	partie.joueur.armes[0].nbProjectilesMax := 15 ;
	partie.joueur.armes[0].nbProjectiles := partie.joueur.armes[0].nbProjectilesMax ;
	
	//skin de l'arme
	partie.joueur.armes[0].skin.cheminAccees := 'ressource/image/arme/glock.png' ;
	partie.joueur.armes[0].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.armes[0].skin.cheminAccees);
	
	//on charge les textures des projectilles pour les différentes armes : 
    partie.joueur.armes[0].projectileSkin.cheminAccees := 'ressource/image/projectile/arme1.png' ;
	partie.joueur.armes[0].projectileSkin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.joueur.armes[0].projectileSkin.cheminAccees);
    partie.joueur.armes[0].son := Mix_LoadWAV('ressource/son/gun.wav');
	
    //affichage map
    partie.map.skin.cheminAccees := 'ressource/image/map/m1.jpg';
    partie.map.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.skin.cheminAccees);
    
    //Initialisation Arme Ramassable
	setlength(partie.map.lstArmes, 1) ;
	
	//affichage de l'arme
	partie.map.lstArmes[0].afficher := True ;
	partie.map.lstArmes[0].skin.cheminAccees := 'ressource/image/arme/ak.png' ;
	partie.map.lstArmes[0].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstArmes[0].skin.cheminAccees);
	partie.map.lstArmes[0].Acord.x := 600 ;
	partie.map.lstArmes[0].Acord.y := 320 ; 
	partie.map.lstArmes[0].largeur := 90 ;
	partie.map.lstArmes[0].hauteur := 90 ;
	
	//caractéristique de l'arme	
	partie.map.lstArmes[0].projectileSkin.cheminAccees := 'ressource/image/projectile/arme2.png';
	partie.map.lstArmes[0].projectileSkin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstArmes[0].projectileSkin.cheminAccees);
	partie.map.lstArmes[0].son := Mix_LoadWAV('ressource/son/GUNAuto_Coup-de-feu-de-beretta-m12-9-mm-_ID-0437__LS.wav');
	partie.map.lstArmes[0].cadence := 20 ; // Nombre de frame avant de pouvoir re-tirer
	partie.map.lstArmes[0].degat := 10 ;
	partie.map.lstArmes[0].precision := 20 ;
	partie.map.lstArmes[0].nbProjectilesMax := 30 ;
	partie.map.lstArmes[0].nbProjectiles := partie.map.lstArmes[0].nbProjectilesMax ;

    //affichage decor (map 1)
    setlength(partie.map.lstDecors, 7);
    
    partie.map.lstDecors[0].skin.cheminAccees := 'ressource\image\decor\BoxGauche.png';
    partie.map.lstDecors[0].hLargeur := 100 div 2;
    partie.map.lstDecors[0].hHauteur := 100 div 2;
    partie.map.lstDecors[0].Largeur := 100;
    partie.map.lstDecors[0].Hauteur := 100;
    partie.map.lstDecors[0].Dcord.x := 250 ;
    partie.map.lstDecors[0].Dcord.y := 400 ;
    
    partie.map.lstDecors[1].skin.cheminAccees := 'ressource\image\decor\BoxDroite.png';
    partie.map.lstDecors[1].hLargeur := 80 div 2;
    partie.map.lstDecors[1].hHauteur := 80 div 2;
    partie.map.lstDecors[1].Largeur := 80 ;
    partie.map.lstDecors[1].Hauteur := 80;
    partie.map.lstDecors[1].Dcord.x := 750 ;
    partie.map.lstDecors[1].Dcord.y := 275 ;	
    
    partie.map.lstDecors[2].skin.cheminAccees := 'ressource\image\decor\Jeep2.png';
    partie.map.lstDecors[2].hLargeur := 135 div 2;
    partie.map.lstDecors[2].hHauteur := 170 div 2;
    partie.map.lstDecors[2].Largeur := 135;
    partie.map.lstDecors[2].Hauteur := 170;
    partie.map.lstDecors[2].Dcord.x := 975 ;
    partie.map.lstDecors[2].Dcord.y := 85 ;	
    
    partie.map.lstDecors[3].skin.cheminAccees := 'ressource\image\decor\MurBas.png';
    partie.map.lstDecors[3].hLargeur := 120 div 2;
    partie.map.lstDecors[3].hHauteur := 20 div 2;
    partie.map.lstDecors[3].Largeur := 120;
    partie.map.lstDecors[3].Hauteur := 20;
    partie.map.lstDecors[3].Dcord.x := 575 ;
    partie.map.lstDecors[3].Dcord.y := 524 ;	
    
    partie.map.lstDecors[4].skin.cheminAccees := 'ressource\image\decor\MurGauche.png';
    partie.map.lstDecors[4].hLargeur := 20 div 2;
    partie.map.lstDecors[4].hHauteur := 170 div 2;
    partie.map.lstDecors[4].Largeur := 20;
    partie.map.lstDecors[4].Hauteur := 170;
    partie.map.lstDecors[4].Dcord.x := 525 ;
    partie.map.lstDecors[4].Dcord.y := 450 ;	
    
    partie.map.lstDecors[5].skin.cheminAccees := 'ressource\image\decor\palmierGauche.png';
    partie.map.lstDecors[5].hLargeur := 200 div 2;
    partie.map.lstDecors[5].hHauteur := 50 div 2;
    partie.map.lstDecors[5].Largeur := 300;
    partie.map.lstDecors[5].Hauteur := 100;
    partie.map.lstDecors[5].Dcord.x := 150 ;
    partie.map.lstDecors[5].Dcord.y := 50 ;	
    
    partie.map.lstDecors[6].skin.cheminAccees := 'ressource\image\decor\palmierDroit.png';
    partie.map.lstDecors[6].hLargeur := 250 div 2;
    partie.map.lstDecors[6].hHauteur := 40 div 2;
    partie.map.lstDecors[6].Largeur := 330;
    partie.map.lstDecors[6].Hauteur := 80;
    partie.map.lstDecors[6].Dcord.x := 800 ;
    partie.map.lstDecors[6].Dcord.y := 40 ;	
	
	for i:= 0 to length(partie.map.lstDecors) - 1 do
		begin
			partie.map.lstDecors[i].skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.map.lstDecors[i].skin.cheminAccees);
		end;
	
		 
    //Affichage du bot  
    partie.bot.Bcord.x := 250 ;
    partie.bot.Bcord.y := 300 ;
    
	partie.bot.vie.total := 100 ;
	partie.bot.vie.actuel := partie.bot.vie.total;
    
    partie.bot.vie.skin.cheminAccees := 'ressource\image\personnage\Vie.png';
    partie.bot.vie.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.bot.vie.skin.cheminAccees); 
    
    partie.bot.vie.fond.cheminAccees := 'ressource\image\personnage\fondVie.png';
    partie.bot.vie.fond.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.bot.vie.fond.cheminAccees); 

    partie.bot.vie.son := Mix_LoadWav('ressource/son/degat/ouch-oof-hurt-sound-effect-262616.wav');
    
	partie.bot.arme.degat := round(1.3*exp(partie.menuNiveau.niveau)) ;
	partie.bot.arme.projectileSkin.cheminAccees := 'ressource/image/projectile/arme1.png' ;
	partie.bot.arme.projectileSkin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.bot.arme.projectileSkin.cheminAccees);
	partie.bot.arme.son := Mix_LoadWAV('ressource/son/GUNShotg_Fusil tir 2 (ID 2854)_LS.wav');

    partie.bot.skin.cheminAccees := 'ressource\image\bot\bot.png'; 
    partie.bot.skin.texture := IMG_LoadTexture(partie.fenetre.renderer , partie.bot.skin.cheminAccees);
    
end;

begin
end.
