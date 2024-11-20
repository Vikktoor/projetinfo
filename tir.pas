unit tirs;

interface
uses crt,math,types,SDL2, SDL2_image;

procedure tirer(var j:joueur;i:integer);
procedure avancerballe(var j:joueur);


implementation
procedure tirer(var j:joueur;i:integer);

begin
				begin
					if j.t.munitions[i].visible=false then // si la balle n'est pas en cours
					begin
						j.t.munitions[i].x:=j.t.x+20; 
						j.t.munitions[i].y:=j.t.y+20;
						j.t.munitions[i].posx:=j.t.x+20; 
						j.t.munitions[i].posy:=j.t.y+20;
						j.t.munitions[i].direction:=j.t.direction;
						j.t.munitions[i].vitesse:=5;
						j.t.munitions[i].visible:=True;
				end;
	end;
end;

procedure avancerballe(var j:joueur);
var
anglerad: real;
i:integer;
begin
for i := 1 to 5 do
begin
  if j.t.munitions[i].visible then
  begin
    anglerad := j.t.munitions[i].direction * Pi / 180;

    // Calculer la nouvelle position
    j.t.munitions[i].posx := j.t.munitions[i].x + j.t.munitions[i].vitesse * cos(anglerad);
    j.t.munitions[i].posy := j.t.munitions[i].y + j.t.munitions[i].vitesse * sin(anglerad);
    j.t.munitions[i].x:=Trunc(j.t.munitions[i].posx);
    j.t.munitions[i].y:=Trunc(j.t.munitions[i].posy);
    // Désactiver la balle si elle sort de l'écran
    if (j.t.munitions[i].x < 0) or (j.t.munitions[i].x > 1200) or (j.t.munitions[i].y < 0) or (j.t.munitions[i].y > 800) then
      j.t.munitions[i].visible := False
  end;
end;
end;

end.

var touche:char;
i:integer;
BEGIN
	touche:=readkey;
	if touche=#13 then
		begin
			for i:=1 to 5 do
				begin
					if j.t.munitions[i].b=false then
						begin
							j.t.munitions[i].direction:=j.t.direction;
							j.t.munitions[i].b:=True;
							j.t.munitions[i].x:=j.t.x;
							j.t.munitions[i].y:=j.t.y;
						end;
				end;
		end;
	
END;




end.
