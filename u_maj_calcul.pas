unit u_maj_calcul;

interface

uses Dos ,Mouse, sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf, sysutils,
	u_types;

procedure estCliquee(var bouton : TBouton ; var fenetre : TFenetre);

procedure EstGagnee(var partie : TPartie);

function CalculVecteur (cord1 : TCoordonnee ; cord2 : TCoordonnee) : TVecteur ; // Vecteur entre 1 et 2

function Rotation(vecteur : TVecteur ; angle {radian} : real) : TVecteur ;

function CalculNorme(vect : TVecteur) : Real;

procedure Deplacement(var partie : TPartie);

procedure Tir(var partie : TPartie ; Jcord : TCoordonnee ; Vcord : TCoordonnee ; arme : TArme ; coefOffset : integer);

function ContactRond(cord1 : TCoordonnee ; cord2 : TCoordonnee ; hitbox1 : integer) : boolean ;

function ContactCarre(cord1 : TCoordonnee ; cord2 : TCoordonnee ; hitboxHauteur : integer ; hitboxLargeur : integer) : Boolean; // Hitbox de 1, est ce que 2 dans la hitbox de 1

function EstDistanceTir (cordE1 : TCoordonnee ; cordE2 : TCoordonnee) : Boolean ; 


implementation

function CalculNorme(vect : TVecteur) : Real;

begin

CalculNorme := sqrt(vect.x * vect.x + vect.y * vect .y)

end;


procedure estCliquee(var bouton : TBouton ; var fenetre :Tfenetre);

var x : Integer;
	y : Integer;
	
begin 

    if fenetre.event.button.state = SDL_BUTTON_LEFT then
          begin
            // recuperation des coord du clic 
            SDL_GetMouseState(@x, @y);
            // comparaison sur les x puis des y 
            if ((x > round(bouton.Bcord.x)) and (x < (round(bouton.Bcord.x) + bouton.largeur))) and (((y > round(bouton.Bcord.y)) and (y < round(bouton.Bcord.y) + bouton.hauteur))) then
                begin
				if bouton.estCliquee then
					bouton.estCliquee := False
				else 
					bouton.estCliquee := True;
				end;
        end;
end;


procedure EstGagnee(var partie : TPartie);
	begin
		if partie.entrainement then
			begin
				partie.gagnee := (length(partie.map.lstCibles) <= 0);
			end
		else 
			partie.gagnee := partie.bot.vie.actuel <= 0;
	end;


function CalculVecteur (cord1 : TCoordonnee ; cord2 : TCoordonnee) : TVecteur ; //Vecteur entre 1 et 2

begin
	CalculVecteur.x := cord2.x - cord1.x ;
	CalculVecteur.y := cord2.y - cord1.y ;
end;


function EstDistanceTir (cordE1 : TCoordonnee ; cordE2 : TCoordonnee) : Boolean ; 

begin
EstDistanceTir := True;
{
	if CalculNorme(CalculVecteur(cordE1, cordE2)) <= 350 then
		EstDistanceTir := True
	else
		EstDistanceTir := False;
}
end;



function ContactCarre(cord1 : TCoordonnee ; cord2 : TCoordonnee ; hitboxHauteur : integer ; hitboxLargeur : integer) : Boolean; // Hitbox de 1, est ce que 2 dans la hitbox de 1

var vecteur : TVecteur ;

	begin
		vecteur := CalculVecteur(cord1, cord2) ;

		ContactCarre := ( (vecteur.x < hitboxLargeur) and (vecteur.x > -hitboxLargeur) ) and ( (vecteur.y < hitboxHauteur ) and (vecteur.y > -hitboxHauteur) ) ; 
	end;


function ContactRond(cord1 : TCoordonnee ; cord2 : TCoordonnee ; hitbox1 : integer) : boolean ;

var vecteur : TVecteur ;
	norme : real ;
	
begin
	vecteur := CalculVecteur(cord1, cord2) ;
	norme := CalculNorme(vecteur) ;
	
	ContactRond := norme <= hitbox1;
end;


function Rotation(vecteur : TVecteur ; angle {radian} : real) : TVecteur ;

begin
	Rotation.x := ( vecteur.x * round(cos(angle)) ) - ( vecteur.y * round(sin(angle)));
	Rotation.y := ( vecteur.x * round(sin(angle))) + ( vecteur.y * round(cos(angle)));
end;


procedure OrientationSouris(var partie : TPartie ; var vectUniX : TVecteur ; var vectUniY : TVecteur);

var norme : real ;

const coefVitesse = 7;

begin
	if partie.fenetre.event.type_ = SDL_MOUSEMOTION then
		begin
			partie.joueur.Scord.x := partie.fenetre.event.button.x;
			partie.joueur.Scord.y := partie.fenetre.event.button.y;
			
			vectUniX := CalculVecteur(partie.joueur.Jcord, partie.joueur.Scord) ;
		
			norme := CalculNorme(vectUniX) ;
		
			vectUniX.x := (vectUniX.x / norme) * coefVitesse ;
			vectUniX.y := (vectUniX.y / norme) * coefVitesse ; 
	
			partie.joueur.direction := vectUniX ;
		end
	else	
		begin
			vectUniX := partie.joueur.direction ;
		end;

	vectUniY.x := Rotation(vectUniX, -(pi() / 2)).x ;
	vectUniY.y := Rotation(vectUniX, -(pi() / 2)).y ;
end ;


procedure Deplacement(var partie : TPartie);

var xdirection : TVecteur ;
	ydirection : TVecteur ;
	nouvellePosX : TCoordonnee ;
	nouvellePosY : TCoordonnee ;
	decor : TDecor ;
	contactDecorX : Boolean ;
	contactDecorY : Boolean ;
	i : integer ;
	
const offsetDecor = 20;
const offsetFenetre = 30;
	
begin
	OrientationSouris(partie, xdirection, ydirection); 
	
	// Si Z pressée alors
	if (partie.fenetre.event.key.keysym.sym = SDLK_z) and (partie.fenetre.event.type_ = SDL_Keydown) then
		begin
			nouvellePosX.x := partie.joueur.Jcord.x + xdirection.x ;
			nouvellePosX.y := partie.joueur.Jcord.y ;
			
			nouvellePosY.x := partie.joueur.Jcord.x ; 
			nouvellePosY.y := partie.joueur.Jcord.y + xdirection.y;
			
			contactDecorX := False;
			contactDecorY := False;
			
			for i := 0 to length(partie.map.lstDecors)-1 do
				begin
					decor := partie.map.lstDecors[i];

					if ContactCarre(decor.Dcord , nouvellePosX, decor.hHauteur + offsetDecor, decor.hLargeur + offsetDecor) then
						contactDecorX := True ;
					if ContactCarre(decor.Dcord , nouvellePosY, decor.hHauteur + offsetDecor, decor.hLargeur + offsetDecor) then
						contactDecorY := True ;
				end;

			
			if ( (nouvellePosX.x > offsetFenetre) and (nouvellePosX.x < partie.fenetre.largeurFenetre - offsetFenetre) ) and not(contactDecorX) then
				partie.joueur.Jcord.x := nouvellePosX.x ;
				
			if ( (nouvellePosY.y > offsetFenetre) and (nouvellePosY.y < partie.fenetre.hauteurFenetre - offsetFenetre) ) and not(contactDecorY) then 
				partie.joueur.Jcord.y := nouvellePosY.y ;		
		end;
	
	// Si S pressée alors 
	if (partie.fenetre.event.key.keysym.sym = SDLK_s) and (partie.fenetre.event.type_ = SDL_Keydown) then
		begin
			nouvellePosX.x := partie.joueur.Jcord.x - xdirection.x ;
			nouvellePosX.y := partie.joueur.Jcord.y ;
			
			nouvellePosY.x := partie.joueur.Jcord.x ; 
			nouvellePosY.y := partie.joueur.Jcord.y - xdirection.y;
			
			contactDecorX := False;
			contactDecorY := False;
			
			for i := 0 to length(partie.map.lstDecors)-1 do
				begin
					decor := partie.map.lstDecors[i];
					if ContactCarre(decor.Dcord , nouvellePosX, decor.hHauteur + offsetDecor, decor.hLargeur + offsetDecor) then
						contactDecorX := True ;
					if ContactCarre(decor.Dcord , nouvellePosY, decor.hHauteur + offsetDecor, decor.hLargeur + offsetDecor) then
						contactDecorY := True ;
				end;
				
			if ( (nouvellePosX.x > offsetFenetre) and (nouvellePosX.x < partie.fenetre.largeurFenetre - offsetFenetre) ) and not(contactDecorX) then
				partie.joueur.Jcord.x := nouvellePosX.x ;
				
			if ( (nouvellePosY.y > offsetFenetre) and (nouvellePosY.y < partie.fenetre.hauteurFenetre - offsetFenetre) ) and not(contactDecorY) then 
				partie.joueur.Jcord.y := nouvellePosY.y ;
		end;
	
	{if (partie.fenetre.event.key.keysym.sym = SDLK_q) and (partie.fenetre.event.type_ = SDL_Keydown) then // Si Q pressée alors 
		begin
			partie.joueur.Jcord.x := partie.joueur.Jcord.x + ydirection.x ;
			partie.joueur.Jcord.y := partie.joueur.Jcord.y + ydirection.y ;
		end;
	
	if  (partie.fenetre.event.key.keysym.sym = SDLK_d) and (partie.fenetre.event.type_ = SDL_Keydown) then // Si D pressée alors 
		begin
			partie.joueur.Jcord.x := partie.joueur.Jcord.x - ydirection.x ;
			partie.joueur.Jcord.y := partie.joueur.Jcord.y - ydirection.y ;
		end;}
end;


procedure Tir(var partie : TPartie ; Jcord : TCoordonnee ; Vcord : TCoordonnee ; arme : TArme ; coefOffset : integer);

var	n : integer ;
	norme : real ;
	projectile : TProjectile ;
	deg : integer ;
	incertitude : integer ;
	
const coefVitesse =  2 ;

begin
	//Gestion de l'imprecision
	projectile.vitesse.x := CalculVecteur(Jcord, Vcord).x  ;
	projectile.vitesse.y := CalculVecteur(Jcord, Vcord).y  ;
	
	norme := CalculNorme(projectile.vitesse);
	
	randomize ;
	if random(2) = 1 then
		Vcord.x += random(round(arme.precision * (norme/100)))
	else
		Vcord.x -= random(round(arme.precision * (norme/100)));
		
    randomize ;
	if random(2) = 1 then
		Vcord.y += random(round(arme.precision * (norme/100)))
	else
		Vcord.y -= random(round(arme.precision * (norme/100)));
    
	deg := arme.degat ;

	if not partie.menuIG.btnBruitage.estCliquee then
		Mix_PlayChannel(-1, arme.son, 0); // channel -1 joue sur un calan dispo

	n := length(partie.map.lstProjectiles) ;
	setlength(partie.map.lstProjectiles, n + 1) ;

	projectile.vitesse.x := CalculVecteur(Jcord, Vcord).x  ;
	projectile.vitesse.y := CalculVecteur(Jcord, Vcord).y  ;
	
	norme := CalculNorme(projectile.vitesse);

	projectile.vitesse.x := (projectile.vitesse.x / norme) * coefVitesse ;
	projectile.vitesse.y := (projectile.vitesse.y / norme) * coefVitesse ;
		
	projectile.Pcord.x := Jcord.x + (projectile.vitesse.x * coefOffset);
	projectile.Pcord.y := Jcord.y + (projectile.vitesse.y * coefOffset);
	
	projectile.degat := deg ;
	projectile.skin.cheminAccees := arme.projectileSkin.cheminAccees ;
	projectile.skin.texture := arme.projectileSkin.texture ;
	
	partie.map.lstProjectiles[n] := projectile ; 
end;

begin
end.
