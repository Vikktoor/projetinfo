unit u_aff;

interface

uses sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf, math, sysutils,
    u_types, u_menu, u_maj_calcul;

procedure Affichage (var partie : u_types.TPartie ; var  menu : TmenuIG ; entrainement : Boolean);


implementation

function CalculAngle(vect1 : TVecteur ; vect2 : TVecteur) : real ;

var norme1, norme2, scalaire : real ;

begin
	norme1 := sqrt( sqr(vect1.x) + sqr(vect1.y) ) ;
	norme2 := sqrt( sqr(vect2.x) + sqr(vect2.y) ) ;
	
	scalaire := ( vect1.x * vect2.x ) + ( vect1.y * vect2.y ) ;
	
	CalculAngle := ArcCos(scalaire / (norme1 * norme2)) ;
	CalculAngle := radtodeg(CalculAngle);
	
	if vect2.y > 0 then 
		CalculAngle := 360 - CalculAngle ;
end;


procedure AffichageJoueur(var partie : TPartie);

var rect, zRect : TSDL_RECT;
	vectBase : TVecteur;
	theta : real ;
	numImage : Integer ;
	chemin : PChar ;
	
begin
    // creer la surface d'affichage 
    rect.x := 0;
    rect.y := 0;
	rect.w := 150;
	rect.h := 150;
    
	//on definit la zone d'affichage zRect
	zRect.x := round(partie.joueur.Jcord.x) - 75;
	zRect.y := round(partie.joueur.Jcord.y) - 75;
	zRect.w := 150;
	zRect.h := 150;

	vectBase.x := 1;
	vectBase.y := 0;
 
    theta := 360 - CalculAngle(vectBase, partie.joueur.direction);

	// on definit rect comme surface de la texture : partie.joueur.skin.texture
	if EstDistanceTir(partie.joueur.Scord, partie.joueur.Jcord) then
		begin
			//SDL_QueryTexture(partie.joueur.skinTir.texture, nil, nil, @rect.w, @rect.h);
			//SDL_RenderCopyEx(partie.fenetre.renderer, partie.joueur.skinTir.texture, nil, @zRect, theta, nil, SDL_FLIP_NONE);
			SDL_RenderCopyEx(partie.fenetre.renderer, partie.joueur.skinRepo.texture, nil, @zRect, theta, nil, SDL_FLIP_NONE);
		end
	else
		begin
			//SDL_QueryTexture(partie.joueur.skinRepo.texture, nil, nil, @rect.w, @rect.h);
			SDL_RenderCopyEx(partie.fenetre.renderer, partie.joueur.skinRepo.texture, nil, @zRect, theta, nil, SDL_FLIP_NONE);
		end;
end;


procedure AffichageDecor(var partie : u_types.TPartie);

var rect : TSDL_RECT ;
	i : integer ;
	
begin
	// Affiche la map (fond)
	SDL_RenderCopy (partie.fenetre.renderer , partie.map.skin.texture , nil, nil);
	
	// Affiche les différentes textures
	if length(partie.map.lstDecors) > 0 then 
	    begin
	        for i := 0 to length(partie.map.lstDecors) - 1 do
	            begin
		            rect.x := round(partie.map.lstDecors[i].Dcord.x - (partie.map.lstDecors[i].largeur/2)); 
		            rect.y := round(partie.map.lstDecors[i].Dcord.y - (partie.map.lstDecors[i].hauteur/2)); 
		            
		            rect.w := partie.map.lstDecors[i].largeur;
		            rect.h := partie.map.lstDecors[i].hauteur;

		            SDL_RenderCopy (partie.fenetre.renderer , partie.map.lstDecors[i].skin.texture , nil, @rect);
	            end;
	    end;
end;


procedure AffichageProjectile(var partie : u_types.TPartie);

var i : integer;
	rect : TSDL_RECT;
	
begin   
	for i := 0 to length(partie.map.lstProjectiles) - 1 do
		begin
            rect.x := round(partie.map.lstProjectiles[i].Pcord.x) - 15; // -15 pour centrer l'image avec les coordonnées
            rect.y := round(partie.map.lstProjectiles[i].Pcord.y) - 15; 
            rect.w := 30;
            rect.h := 30;
            
            SDL_RenderCopy (partie.fenetre.renderer, partie.map.lstProjectiles[i].skin.texture, nil, @rect); // changer le skin utiliser en fct du projectile, plus tard
		end;
end;


procedure AffichageBot(var partie : TPartie);

var rect, zRect : TSDL_RECT;
	vectBase : TVecteur;
	theta : real ;
	numImage : Integer ;
	chemin : PChar ;
	
begin
    // creer la surface d'affichage 
    rect.x := 0;
    rect.y := 0;
	rect.w := 150;
	rect.h := 150;
    
	//on definit la zone d'affichage zRect
	zRect.x := round(partie.bot.Bcord.x) - 75;
	zRect.y := round(partie.bot.Bcord.y) - 75;
	zRect.w := 150;
	zRect.h := 150;

	vectBase.x := 1;
	vectBase.y := 0;
 
    theta := 360- CalculAngle(vectBase, CalculVecteur(partie.bot.Bcord, partie.joueur.Jcord));

	SDL_RenderCopyEx(partie.fenetre.renderer, partie.bot.skin.texture, nil, @zRect, theta, nil, SDL_FLIP_NONE);
end;


procedure AffichageCible(var partie : u_types.TPartie);

var i : integer;
	rect : TSDL_RECT;

begin   
	for i := 0 to length(partie.map.lstCibles) - 1 do
		begin
            // creer la surface d'affichage 
            rect.x := round(partie.map.lstCibles[i].Ccord.x) - 25; // -25 pour centrer l'image avec les coordonnées
            rect.y := round(partie.map.lstCibles[i].Ccord.y) - 25; 
            rect.w := 50;
            rect.h := 50;

            SDL_RenderCopy (partie.fenetre.renderer , partie.map.lstCibles[i].skin.texture , nil, @rect);
		end;
end;


procedure AffichageVieJoueur(partie : TPartie);

var rect1 : TSDL_Rect ;
	rect2 : TSDL_Rect ;
	tailleVie : integer;
	
begin
	tailleVie := 125 ;
	rect1.x := round(partie.joueur.Jcord.x) - 60 ;
	rect1.y := round(partie.joueur.Jcord.y) - 45 ;
	rect1.w := round( (partie.joueur.vie.actuel / partie.joueur.vie.total) * tailleVie);
	rect1.h := 10;

	rect2.x := round(partie.joueur.Jcord.x) - 60 ;
	rect2.y := round(partie.joueur.Jcord.y) - 45 ;
	rect2.w := tailleVie;
	rect2.h := 10;

	SDL_RenderCopy(partie.fenetre.renderer, partie.joueur.vie.fond.texture, nil, @rect2);
	SDL_RenderCopy(partie.fenetre.renderer, partie.joueur.vie.skin.texture, nil, @rect1);
end;


procedure AfficheVieCible(partie : TPartie);

var rect1 : TSDL_Rect ;
	rect2 : TSDL_Rect ;
	i : integer ;
	tailleVie : integer ;
	
begin
	tailleVie := 80 ;
	for i:= 0 to length(partie.map.lstCibles) - 1 do
		begin
			rect1.x := round(partie.map.lstCibles[i].Ccord.x) - 40 ;
			rect1.y := round(partie.map.lstCibles[i].Ccord.y) - 40 ;
			rect1.w := round( (partie.map.lstCibles[i].vie.actuel / partie.map.lstCibles[i].vie.total) * tailleVie);
			rect1.h := 10;
	
			rect2.x := rect1.x  ;
			rect2.y := rect1.y ;
			rect2.w := tailleVie ;
			rect2.h := 10 ;
	
			SDL_RenderCopy(partie.fenetre.renderer, partie.map.lstCibles[i].vie.fond.texture, nil, @rect2);
			SDL_RenderCopy(partie.fenetre.renderer, partie.map.lstCibles[i].vie.skin.texture, nil, @rect1);
	end;
end;


procedure AfficheVieBot(partie : TPartie);

var rect1 : TSDL_Rect ;
	rect2 : TSDL_Rect ;
	tailleVie : integer ;
	
begin
	tailleVie := 80 ;
	rect1.x := round(partie.bot.Bcord.x) - 40 ;
	rect1.y := round(partie.bot.Bcord.y) - 40 ;
	rect1.w := round( (partie.bot.vie.actuel / partie.bot.vie.total) * tailleVie);
	rect1.h := 10;

	rect2.x := rect1.x  ;
	rect2.y := rect1.y ;
	rect2.w := tailleVie ;
	rect2.h := 10 ;
	SDL_RenderCopy(partie.fenetre.renderer, partie.bot.vie.fond.texture, nil, @rect2);
	SDL_RenderCopy(partie.fenetre.renderer, partie.bot.vie.skin.texture, nil, @rect1);
end;

procedure AffichageArmes(partie : TPartie);

var arme : TArmeRamasse ;
	rect : TSDL_Rect ;
	
begin
	for arme in partie.map.lstArmes do
		if arme.afficher then 
			begin
				rect.x := round(arme.Acord.x - (arme.largeur/2));
				rect.y := round(arme.Acord.y - (arme.hauteur/2));
				
				rect.w := arme.largeur;
				rect.h := arme.hauteur;
				
				SDL_RenderCopy (partie.fenetre.renderer , arme.skin.texture , nil, @rect);
			end;
end;	

procedure AffichageATH(partie : TPartie);

var rect1, rect2, rect3 : TSDL_Rect ;
	tailleMun : integer ;
	
begin
	// Fond de l'ATH arme
	rect1.w := 120 ;
	rect1.h := 155 ;
	rect1.x := 60 - (rect1.w div 2) ;
	rect1.y := 300 - (rect1.h div 2) ;
	
	SDL_RenderCopy(partie.fenetre.renderer , partie.menuIG.skinFond.texture , nil, @rect1);
	
	// Afficher barre de munition
	tailleMun := 110 ;
	rect3.w := round( (partie.joueur.armes[partie.joueur.indiceArme].nbProjectiles / partie.joueur.armes[partie.joueur.indiceArme].nbProjectilesMax)  * tailleMun);
	rect3.h := 10 ;
	rect3.x := 5 ;
	rect3.y := 365 - (rect3.h div 2) ;

	SDL_RenderCopy(partie.fenetre.renderer, partie.menuIG.skinMun.texture, nil, @rect3);
	
	// Afficher l'arme
    rect2.w := 100 ;
    rect2.h := 100 ;	
    rect2.x := 60 - (rect2.w div 2) ;
    rect2.y := 300 - (rect2.h div 2) ;

    SDL_RenderCopy(partie.fenetre.renderer , partie.joueur.armes[partie.joueur.indiceArme].skin.texture , nil, @rect2);
end;


procedure Affichage (var partie : TPartie ; var  menu : TmenuIG ; entrainement : Boolean);

begin
	AffichageDecor(partie);
	AffichageArmes(partie);
	writeln('log 1 ');
    if entrainement then
		begin
			AffichageCible(partie);
			AfficheVieCible(partie);
		end;
	writeln('log 2 ');
    if not(entrainement) then
		begin
			AffichageBot(partie);
			AfficheVieBot(partie);
		end;
	writeln('log 3 ');
    AffichageJoueur(partie);
    AffichageVieJoueur(partie);
    
    AffichageProjectile(partie);
    
    AffichageATH(partie);

	writeln('log 4 ');
    AffMajMenuInGame(partie);
	writeln('log 5 ');
end;

begin
end.
