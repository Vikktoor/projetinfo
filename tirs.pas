unit tirs;

interface
uses crt,math,types,SDL2, SDL2_image, mouvement;

procedure tirer(var j:joueur;i:integer);
procedure avancerballe(var j:joueur; obstacles:tobst);
function BoulletEnCollisionAvecObstacles(var tirRect: TSDL_Rect; obstacles: tobst): Boolean;
function CollisionSurBordHorizontal(balle: TSDL_Rect; obstacles: tobst): Boolean;
function CollisionSurBordVertical(balle: TSDL_Rect; obstacles: tobst): Boolean;
procedure CalculerRebondParfait(var direction: real; normaleX, normaleY: real);

implementation

function BoulletEnCollisionAvecObstacles(var tirRect: TSDL_Rect; obstacles: tobst): Boolean;
var
  i: Integer;
begin
  BoulletEnCollisionAvecObstacles := False;
  for i := Low(obstacles) to High(obstacles) do
  begin
    if RectanglesSeChevauchent(tirRect, obstacles[i]) then
    begin
      BoulletEnCollisionAvecObstacles := True;
      Exit;  // Arrête la vérification dès qu'on trouve une collision
    end;
  end;
end;

function CollisionSurBordHorizontal(balle: TSDL_Rect; obstacles: tobst): Boolean;
var
  i: Integer;
begin
  CollisionSurBordHorizontal := False;
  for i := 0 to High(obstacles) do
  begin
    if RectanglesSeChevauchent(balle, obstacles[i]) then
    begin
      // Vérifier si la collision concerne les bords supérieur ou inférieur
      if (balle.y + balle.h >= obstacles[i].y) and (balle.y <= obstacles[i].y + obstacles[i].h) then
      begin
        CollisionSurBordHorizontal := True;
        Exit;
      end;
    end;
  end;
end;

function CollisionSurBordVertical(balle: TSDL_Rect; obstacles: tobst): Boolean;
var
  i: Integer;
begin
  CollisionSurBordVertical := False;
  for i := 0 to High(obstacles) do
  begin
    if RectanglesSeChevauchent(balle, obstacles[i]) then
    begin
      // Vérifier si la collision concerne les bords gauche ou droit
      if (balle.x + balle.w >= obstacles[i].x) and (balle.x <= obstacles[i].x + obstacles[i].w) then
      begin
        CollisionSurBordVertical := True;
        Exit;
      end;
    end;
  end;
end;

procedure CalculerRebondParfait(var direction: real; normaleX, normaleY: real);
var
  vx, vy, dot, rx, ry: real;
begin
  // Convertir la direction en vecteur
  vx := cos(direction * Pi / 180);
  vy := sin(direction * Pi / 180);

  // Calculer le produit scalaire
  dot := vx * normaleX + vy * normaleY;

  // Calculer le vecteur réfléchi
  rx := vx - 2 * dot * normaleX;
  ry := vy - 2 * dot * normaleY;

  // Reconvertir le vecteur réfléchi en angle
  direction := arctan2(ry, rx) * 180 / Pi;
  if direction < 0 then
    direction := direction + 360; // Normaliser l'angle entre 0 et 360
end;

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

procedure avancerballe(var j: joueur; obstacles: tobst);
var
  anglerad: real;
  i, obstacleIdx: integer;
  newRect: TSDL_Rect;
begin
  for i := 0 to High(j.t.munitions) do
  begin
    if j.t.munitions[i].visible then
    begin
      anglerad := j.t.munitions[i].direction * Pi / 180;

      // Calcul de la position future
      newRect.x := Round(j.t.munitions[i].x + j.t.munitions[i].vitesse * cos(anglerad));
      newRect.y := Round(j.t.munitions[i].y + j.t.munitions[i].vitesse * sin(anglerad));
      newRect.w := 10;
      newRect.h := 10;

      // Vérification de la collision
      if not BoulletEnCollisionAvecObstacles(newRect, obstacles) then
      begin
        // Mise à jour des positions si aucune collision
        j.t.munitions[i].posx := j.t.munitions[i].x + j.t.munitions[i].vitesse * cos(anglerad);
        j.t.munitions[i].posy := j.t.munitions[i].y + j.t.munitions[i].vitesse * sin(anglerad);
        j.t.munitions[i].x := Trunc(j.t.munitions[i].posx);
        j.t.munitions[i].y := Trunc(j.t.munitions[i].posy);
      end
      else
      begin
        // Gérer le rebond
        for obstacleIdx := Low(obstacles) to High(obstacles) do
        begin
          if RectanglesSeChevauchent(newRect, obstacles[obstacleIdx]) then
          begin
          
           // Rebonds sur bord vertical (gauche ou droite)
            if CollisionSurBordVertical(newRect, obstacles) then
            begin
              if j.t.munitions[i].x + newRect.w <= obstacles[obstacleIdx].x then
              begin
                // À gauche de l'obstacle : déplacer la balle juste à gauche
                CalculerRebondParfait(j.t.munitions[i].direction,-1,0);
                j.t.munitions[i].x := obstacles[obstacleIdx].x - newRect.w;
                j.t.munitions[i].nbRebonds:=j.t.munitions[i].nbRebonds + 1;
                if j.t.munitions[i].nbRebonds = 5 then
                begin
					j.t.munitions[i].visible:=False;
					j.t.munitions[i].nbRebonds:= 0;
				end;
              end
              else if j.t.munitions[i].x >= obstacles[obstacleIdx].x + obstacles[obstacleIdx].w then
              begin
                // À droite de l'obstacle : déplacer la balle juste à droite
                CalculerRebondParfait(j.t.munitions[i].direction,1,0);
                j.t.munitions[i].x := obstacles[obstacleIdx].x + obstacles[obstacleIdx].w;
                j.t.munitions[i].nbRebonds:=j.t.munitions[i].nbRebonds + 1;
                if j.t.munitions[i].nbRebonds = 5 then
				begin
					j.t.munitions[i].visible:=False;
					j.t.munitions[i].nbRebonds := 0;
				end;
              end;
            end;
            
            // Rebonds sur bord horizontal (haut ou bas)
            if CollisionSurBordHorizontal(newRect, obstacles) then
            begin
              // Inverser la direction verticale
              // Ajuster la position verticale pour éviter la téléportation
              if j.t.munitions[i].y + newRect.h <= obstacles[obstacleIdx].y then
              begin
                // Si la balle est au-dessus de l'obstacle, on la place juste au-dessus
                CalculerRebondParfait(j.t.munitions[i].direction,0,-1);
                j.t.munitions[i].y := obstacles[obstacleIdx].y - newRect.h;
                j.t.munitions[i].nbRebonds:=j.t.munitions[i].nbRebonds + 1;
                if j.t.munitions[i].nbRebonds = 5 then
                begin
					j.t.munitions[i].visible:=False;
					j.t.munitions[i].nbRebonds := 0;
				end;
              end
              else if j.t.munitions[i].y >= obstacles[obstacleIdx].y + obstacles[obstacleIdx].h then
              begin
                // Si la balle est en dessous de l'obstacle, on la place juste en dessous
                CalculerRebondParfait(j.t.munitions[i].direction,0,1);
                j.t.munitions[i].y := obstacles[obstacleIdx].y + obstacles[obstacleIdx].h;
                j.t.munitions[i].nbRebonds:=j.t.munitions[i].nbRebonds + 1;
                if j.t.munitions[i].nbRebonds = 5 then
                begin
					j.t.munitions[i].visible:=False;
					j.t.munitions[i].nbRebonds := 0;
				end;
              end
              else
              begin
                // Si la balle est exactement au niveau du bord de l'obstacle, on la déplace légèrement
                if j.t.munitions[i].y + newRect.h > obstacles[obstacleIdx].y + obstacles[obstacleIdx].h then
                  j.t.munitions[i].y := obstacles[obstacleIdx].y + obstacles[obstacleIdx].h;
                if j.t.munitions[i].y < obstacles[obstacleIdx].y then
                  j.t.munitions[i].y := obstacles[obstacleIdx].y - newRect.h;
              end;
            end;

            // Sortir de la boucle dès qu'un rebond est géré
            Break;
          end;
        end;

        // Recalculer les positions exactes après ajustement
        j.t.munitions[i].posx := j.t.munitions[i].x;
        j.t.munitions[i].posy := j.t.munitions[i].y;
      end;

      // Désactiver la balle si elle sort de l'écran
      if (j.t.munitions[i].x < 0) or (j.t.munitions[i].x > 1200) or
         (j.t.munitions[i].y < 0) or (j.t.munitions[i].y > 800) then
        j.t.munitions[i].visible := False;
    end;
  end;
end;


end.

