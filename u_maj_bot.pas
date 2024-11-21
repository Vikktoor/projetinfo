unit u_maj_bot;

interface

uses  Dos ,Mouse, sdl2 ,sdl2_image , SDL2_MIXER, sdl2_ttf, sysutils, 
	u_types, u_maj_calcul ;
    
procedure MajRobot(var partie : TPartie);


implementation

procedure DeplacementBot(var partie : Tpartie ; vect : TVecteur);

var norme : real ;
	nouvellePosX : TCoordonnee ;
	nouvellePosY : TCoordonnee ;
	contactDecorX : Boolean ;
	contactDecorY : Boolean ;
	decor : TDecor ;
	i : integer ;
	
const offsetDecor = 20;
const offsetFenetre = 30;

begin
	norme := CalculNorme(vect) ;
    
    if round(norme) > (200 + random(100) )then
		begin	
				nouvellePosX.x := partie.bot.Bcord.x + round(vect.x / norme);
				nouvellePosX.y := partie.bot.Bcord.y ;
				
				nouvellePosY.x := partie.bot.Bcord.x ;
				nouvellePosY.y := partie.bot.Bcord.y + round(vect.y / norme);
				
				contactDecorX := False ;
				contactDecorY := False ;
				
				for i := 0 to length(partie.map.lstDecors)-1 do
					begin
						decor := partie.map.lstDecors[i];
						if ContactCarre(decor.Dcord , nouvellePosX, decor.hHauteur + offsetDecor, decor.hLargeur + offsetDecor) then
							contactDecorX := True ;
						if ContactCarre(decor.Dcord , nouvellePosY, decor.hHauteur + offsetDecor, decor.hLargeur + offsetDecor) then
							contactDecorY := True ;
					end;
				
				if ( (nouvellePosX.x > offsetFenetre) and (nouvellePosX.x < partie.fenetre.largeurFenetre - offsetFenetre) ) and not(contactDecorX) then
					partie.bot.Bcord.x := nouvellePosX.x ;
					
				if ( (nouvellePosY.y > offsetFenetre) and (nouvellePosY.y < partie.fenetre.hauteurFenetre - offsetFenetre) ) and not(contactDecorY) then 
					partie.bot.Bcord.y := nouvellePosY.y ;	
		end;
end;


procedure TirBot(var partie : TPartie ; vect : TVecteur);

var incertitude : Integer;
    cordVise : TCoordonnee;
    cadence : integer ;

const offsetTir = 20 ; 

begin
	randomize ;
    cadence := random(round(CalculNorme(vect))) div 4; // plus le joueur est proche plus ca tire vite

    // coordonne de visee avec une incertitude
    incertitude := random(random(500));
    cordVise.x := partie.joueur.Jcord.x + incertitude;
    cordVise.y := partie.joueur.Jcord.y + incertitude;

    if (CalculNorme(vect) <= 400 + random(100)) and (cadence = 1) then
	    begin
	        if random(3) = 1 then 
	            begin
	                tir(partie, partie.bot.Bcord, cordVise, partie.bot.arme, offsetTir);
	            end
	        else
	            begin
	                tir(partie, partie.bot.Bcord, partie.joueur.Jcord, partie.bot.arme, offsetTir);
	            end;
	    end;
end;


procedure MajRobot(var partie : TPartie);

var tmp : array of Integer ;
	n, i, j : integer ;
	projectile : TProjectile ;
    vect : TVecteur;
    
const hitboxBot = 30 ;
	
begin
    // calcul du vecteur bot-joueur (y'a un procedure calculVecteur pour ça)
    
    //vect.x := partie.joueur.Jcord.x - partie.bot.Bcord.x;
    //vect.y := partie.joueur.Jcord.y - partie.bot.Bcord.y;
    vect := CalculVecteur(partie.bot.Bcord, partie.joueur.Jcord);

    DeplacementBot(partie, vect);

    TirBot(partie, vect);

    for i := 0 to length(partie.map.lstProjectiles) - 1 do 
        begin
            projectile := partie.map.lstProjectiles[i];
            
            if ContactRond(partie.bot.Bcord, projectile.Pcord, hitboxBot) then
                begin
                    partie.bot.vie.actuel := partie.bot.vie.actuel - projectile.degat ;
					if not partie.menuIG.btnBruitage.estCliquee then
						Mix_PlayChannel(1, partie.bot.vie.son, 0); // channel 1 pour les bruits des entiter non joueur
                    n := length(tmp);
                    setlength(tmp, n + 1);
                    tmp[n] := i ;
                end;
        end;

	
    for j := 0 to length(tmp) - 1 do
        begin
            delete(partie.map.lstProjectiles, j, 1) ;
        end;
        
end;

begin
end.
