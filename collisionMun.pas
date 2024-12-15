unit collisionMun;

interface

uses crt,math,types,SDL2, SDL2_image,mouvement;

function collision(t: tank; m: Mun): boolean;

procedure gererCollision(var jvict: joueur; var jatt: joueur);

implementation

function collision(t: tank; m: Mun): boolean;
begin
	collision := False;
	if t.visible and m.visible then
	begin
		// Vérifie si les positions du tank et de la munition correspondent au quel cas il y a une collision
		if (m.x > t.x) and (m.x < t.x + 60) and(m.y > t.y) and (m.y < t.y + 60) then
			collision := True;
	end;
end;

procedure gererCollision(var jvict: joueur; var jatt: joueur); // jvict pour joueur prenant degat et jatt pour le joueuer attaquant 
var i,j: integer;
begin
	for i := 1 to 5 do // On vérifie les collision pour chacune des 5 munitions disponibles
	begin
		if collision(jvict.t, jatt.t.munitions[i]) then
		begin
			// Modifie les PV des tanks en fonction de leurs caracéristiques 
			jvict.t.Pv:=jvict.t.Pv-jatt.t.degats;
			//Affiche dans le terminal les PV des tanks en fonction de la collision
   			writeln('===================================================');			
			writeln('PV ',jvict.nom,': ',jvict.t.pv);
			writeln('PV ',jatt.nom,': ',jatt.t.pv);
			jatt.t.munitions[i].visible := False; // Désactiver la balle
		end;
		if jvict.t.pv<=0 then
		begin
			jvict.t.visible := False; // Désactiver le tank si n'a plus de PV
			delay(2000); //meten pause la partie quelques instants 
			// Réinitialise les PV en fonction des tanks
			case jvict.t.nomt of 
				'Vic' : jvict.t.Pv:=150;
				'JM' : jvict.t.Pv:=110;
				'Tom' : jvict.t.Pv:=60;
			end;		
			for j:=1 to 5  do 
			// Permet de supprimer les munitions si elles ont été tirées sans toucherle tank mais que ce dernier est arrivé à 0 PV
			begin
				jvict.t.munitions[j].visible:=False;
				jatt.t.munitions[j].visible:=False;
			end;
			// Replace les tanks sur la carte pour recommencer une partie
			InitialiserTank(jvict, 20, 350, 0);
			InitialiserTank(jatt, 920, 720, 180);
   			jatt.score:=jatt.score+1; //met à jour le score
   			writeln('===================================================');
   			writeln('Score ',jatt.nom,' :' ,jatt.score);
   			writeln('Score ',jvict.nom,' :' ,jvict.score);
		end; 
	end;
end;

end.
