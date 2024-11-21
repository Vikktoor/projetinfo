unit u_maj;

interface

uses Dos ,Mouse, sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf, sysutils, 
	u_types, u_maj_calcul, u_maj_bot;

procedure MiseAJour(var partie : TPartie ; entrainement : Boolean);


implementation

const offsetProj = 4 ;

procedure RamasserArme(var partie : TPartie);

var arme : TArmeRamasse ;
	n : integer ;
	i : integer ;
	
begin
	for i := 0 to (length(partie.map.lstArmes) - 1) do
		begin
			arme := partie.map.lstArmes[i] ;
			if arme.afficher then
				if ContactCarre(arme.Acord, partie.joueur.Jcord, arme.hauteur div 2, arme.largeur div 2) then 
					begin
						n := length(partie.joueur.Armes) ;
						setlength(partie.joueur.Armes , n + 1);
						//Caractérisque
						partie.joueur.Armes[n].cadence := arme.cadence ;
						partie.joueur.Armes[n].compteur := arme.cadence ;
						partie.joueur.Armes[n].degat := arme.degat ;
						partie.joueur.Armes[n].precision := arme.precision ;
						partie.joueur.Armes[n].nbProjectilesMax := arme.nbProjectilesMax ;
						partie.joueur.Armes[n].nbProjectiles := arme.nbProjectiles ;
						
						//Affichage et son
						partie.joueur.Armes[n].skin.cheminAccees := arme.skin.cheminAccees ;
						partie.joueur.Armes[n].Skin.texture := arme.skin.texture ;
						partie.joueur.Armes[n].projectileSkin.cheminAccees := arme.projectileSkin.cheminAccees ;
						partie.joueur.Armes[n].projectileSkin.texture := arme.projectileSkin.texture ; //IMG_LoadTexture(partie.fenetre.renderer , arme.projectileSkin.cheminAccees)
						partie.joueur.Armes[n].son := arme.son;
						partie.map.lstArmes[i].afficher := False ;
					end;
		end;
end;

procedure ChangerArme(var partie : TPartie);

begin
	if ( (partie.joueur.indiceArme + 1) <= (length(partie.joueur.Armes) - 1) ) then
		partie.joueur.indiceArme += 1 
	else
		partie.joueur.indiceArme := 0 ;
end;

procedure RechargerArme(var partie : TPartie);

begin
	partie.joueur.Armes[partie.joueur.indiceArme].nbProjectiles := partie.joueur.Armes[partie.joueur.indiceArme].nbProjectilesMax ;
	partie.joueur.Armes[partie.joueur.indiceArme].compteur := -50 ;
end;

procedure MajJoueur(var partie : TPartie);
	
var projectile : TProjectile ;
	tmp : Array of integer ;
	i, n : integer ;
	vectSouris : TVecteur ; 
	normeSouris : real ;

const offsetTir = 18 ; 
const hitboxJoueur = 30 ;

begin
	Deplacement(partie) ;
	
	//partie.joueur.Scord.x := partie.fenetre.event.button.x ;
	//partie.joueur.Scord.y := partie.fenetre.event.button.y ;
	
	vectSouris.x := partie.joueur.Scord.x ;
	vectSouris.y := partie.joueur.Scord.y ;
	
	normeSouris := CalculNorme(vectSouris); 
	
	// Si E Pressé alors ramasser arme 
	if (partie.fenetre.event.key.keysym.sym = SDLK_e) and (partie.fenetre.event.type_ = SDL_Keydown) then 
		RamasserArme(partie);
	
	// Si F pressé alors changer d'arme
	if (partie.fenetre.event.key.keysym.sym = SDLK_f) and (partie.fenetre.event.type_ = SDL_Keydown) then 
		ChangerArme(partie);
		
	// Si R pressé alors recharger arme
	if (partie.fenetre.event.key.keysym.sym = SDLK_r) and (partie.fenetre.event.type_ = SDL_Keydown) then 
		RechargerArme(partie);
	
	if (partie.fenetre.event.button.state = 1) and (normeSouris > 100) then
		begin
			if partie.joueur.Armes[partie.joueur.indiceArme].nbProjectiles > 0 then
				if (partie.joueur.Armes[partie.joueur.indiceArme].compteur >= partie.joueur.Armes[partie.joueur.indiceArme].cadence) and EstDistanceTir(partie.joueur.Jcord, partie.joueur.Scord) then 
					begin
						Tir(partie, partie.joueur.Jcord, partie.joueur.Scord, partie.joueur.Armes[partie.joueur.indiceArme], offsetTir) ;
						partie.joueur.Armes[partie.joueur.indiceArme].compteur := 0 ;
						partie.joueur.Armes[partie.joueur.indiceArme].nbProjectiles -= 1 ;
					end;
		end
	else
		partie.joueur.armes[partie.joueur.indiceArme].compteur := partie.joueur.armes[partie.joueur.indiceArme].compteur + 1 ;
	
	for i := 0 to length(partie.map.lstProjectiles) - 1 do 
		begin
			projectile := partie.map.lstProjectiles[i];
			
			if ContactRond(partie.joueur.Jcord, projectile.Pcord, hitboxJoueur) then
				begin
					partie.joueur.vie.actuel := partie.joueur.vie.actuel - projectile.degat ;
					if not partie.menuIG.btnBruitage.estCliquee then
						Mix_PlayChannel(1, partie.joueur.vie.son, 0); // channel 1 pour les bruits du joueur
					n := length(tmp);
					setlength(tmp, n + 1);
					tmp[n] := i ;
				end;
		end;
	
	for i := 0 to length(tmp)-1 do
		delete(partie.map.lstProjectiles, tmp[i], 1) ;
	setlength(tmp, 0);
	
	if partie.joueur.vie.actuel <= 0 then
		//game over ;
end;


procedure MajCible(var partie : TPartie) ;

var projectile : TProjectile ;
	tmp : array of integer ;
	tmp2 : array of integer ;
	n : integer ;
	i : integer ;
	j : integer ;

const offsetTir = 14 ; 
const hitboxCible = 22 ;

begin
	for i := 0 to length(partie.map.lstCibles)-1 do
		begin
			for j := 0 to length(partie.map.lstProjectiles)-1 do 
				begin
					projectile := partie.map.lstProjectiles[j];
					
					if ContactRond(partie.map.lstCibles[i].Ccord, projectile.Pcord, hitboxCible + offsetProj) then 
						begin
							partie.map.lstCibles[i].vie.actuel := partie.map.lstCibles[i].vie.actuel - projectile.degat ;
							if not partie.menuIG.btnBruitage.estCliquee then
								Mix_PlayChannel(0, partie.map.lstCibles[i].vie.son, 0); // channel 0 pour les sons des entiter non joueur
							n := length(tmp2);
							setlength(tmp2, n + 1);
							tmp2[n] := j ;
						end;
				end;
				
			if partie.map.lstCibles[i].vie.actuel <= 0 then 
				begin
					n := length(tmp);
					setlength(tmp, n + 1);
					tmp[n] := i ;
				end
			else
				begin
					randomize;
					if random(90) = 1 then 
						if (partie.map.lstCibles[i].arme.compteur >= partie.map.lstCibles[i].arme.cadence) then
							begin
								Tir(partie, partie.map.lstCibles[i].Ccord, partie.joueur.Jcord, partie.map.lstCibles[i].arme, offsetTir) ;
								partie.map.lstCibles[i].arme.compteur := 0 ;
							end;
					partie.map.lstCibles[i].arme.compteur += 1 ;
				end;
		end;

		
	if	length(partie.map.lstCibles) > 0 then
		begin
			for i := 0 to length(tmp)-1 do
				delete(partie.map.lstCibles, tmp[i], 1) ;
				
			for j := 0 to length(tmp2)-1 do
				delete(partie.map.lstProjectiles, tmp2[j], 1) ;
		end;
	setlength(tmp,0) ;
	setlength(tmp2,0) ;
end;


procedure MajProjectiles(var partie : TPartie) ;

var	n : integer ;
	i : integer ;
	k : integer ;
	len : integer ;
	tmp : array of Integer;
	suppr : Boolean ;
	decor : TDecor ;
	
begin
	n := length(partie.map.lstProjectiles) ;
	suppr := False ;
	
	for i := 0 to n - 1 do 
		begin
			if (partie.map.lstProjectiles[i].Pcord.y < 0) or (partie.map.lstProjectiles[i].Pcord.y > partie.fenetre.hauteurFenetre) or (partie.map.lstProjectiles[i].Pcord.x < 0) or  (partie.map.lstProjectiles[i].Pcord.x > partie.fenetre.largeurFenetre) then	
				suppr := True ;
				
			if not(Suppr) then
				begin
					for k := 0 to length(partie.map.lstDecors) - 1 do
						begin
							decor := partie.map.lstDecors[k] ;
							if ContactCarre(decor.Dcord, partie.map.lstProjectiles[i].Pcord, decor.hHauteur, decor.hLargeur)then
								suppr := True ;
						end;
				end;
				
			if Suppr then
				begin 
					len := length(tmp) ;
					setlength(tmp, len + 1) ;
					tmp[len] := i ;
				end
			else
				begin
					partie.map.lstProjectiles[i].Pcord.x := partie.map.lstProjectiles[i].Pcord.x + partie.map.lstProjectiles[i].vitesse.x ;
					partie.map.lstProjectiles[i].Pcord.y := partie.map.lstProjectiles[i].Pcord.y + partie.map.lstProjectiles[i].vitesse.y ;
				end;
			
			suppr := False;
		end;
	
	for i := 0 to length(tmp)-1 do
		delete(partie.map.lstProjectiles, tmp[i], 1) ;
	setlength(tmp, 0);
end;


procedure MiseAJour(var partie : TPartie ; entrainement : Boolean);

begin
	MajJoueur(partie);
	MajProjectiles(partie);
	
	if entrainement then
		MajCible(partie);
	if not entrainement then 
		MajRobot(partie);
		
	estGagnee(partie) ;
end;

begin
end.
