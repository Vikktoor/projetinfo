unit collisionMun;

interface
uses crt,math,types,SDL2, SDL2_image;

function collision(t: tank; m: Mun): boolean;
procedure gererCollision(var t: tank; var j: joueur);

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

procedure gererCollision(var t: tank; var j: joueur);
var
  i: integer;
begin
  for i := 1 to 5 do
  begin
    if collision(t, j.t.munitions[i]) then
    begin
      t.visible := False; // Désactiver le tank
      j.t.munitions[i].visible := False; // Désactiver la balle
      Break; // Sortir après avoir géré une collision
    end;
  end;
end;
end.
