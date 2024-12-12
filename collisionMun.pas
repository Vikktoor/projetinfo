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
    if (m.x > t.x) and (m.x < t.x + 60) and
       (m.y > t.y) and (m.y < t.y + 60) then
      collision := True;
  end;
end;

procedure gererCollision(var jvict: joueur; var jatt: joueur);//jvict pour joueur prenant degat et jatt pour le joueuer attaquant 
var
  i,j: integer;
begin
  for i := 1 to 5 do
  begin
    if collision(jvict.t, jatt.t.munitions[i]) then
		begin
			jvict.t.Pv:=jvict.t.Pv-jatt.t.degats;
   			writeln('===================================================');			
			writeln('PV ',jvict.nom,': ',jvict.t.pv);
			writeln('PV ',jatt.nom,': ',jatt.t.pv);
			jatt.t.munitions[i].visible := False; // Désactiver la balle
		end;
	
	if jvict.t.pv<=0 then
		begin
			jvict.t.visible := False; // Désactiver le tank
			delay(2000);
			case jvict.t.nomt of 
				'Vic' : jvict.t.Pv:=150;
				'JM' : jvict.t.Pv:=110;
				'Tom' : jvict.t.Pv:=60;
			end;
			
			for j:=1 to 5  do
			begin
				jvict.t.munitions[j].visible:=False;
				jatt.t.munitions[j].visible:=False;
			end;
			
			InitialiserTank(jvict, 20, 350, 0);
			InitialiserTank(jatt, 920, 720, 180);
   			jatt.score:=jatt.score+1;
   			writeln('===================================================');
   			writeln('Score ',jatt.nom,' :' ,jatt.score);
   			writeln('Score ',jvict.nom,' :' ,jvict.score);
		end;

    
  end;
end;
end.
