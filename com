communication tom entre vpn et ordi
procedure colliObsAv(T:tank;c:tobst;var col:boolean);
var i,j :Integer;

BEGIN
	i:=trunc(T.x)+trunc(1*T.direction); //direction tank 1 ou -1 pout savoir si on prend indice avant ou apres selon la position du tank
	j:=trunc(T.y)+trunc(1*T.direction);
	if (((T.x+(0.5*tank.direction)>i) or( T.y+(0.5*tank.direction)>j)) and c[i][j]='x') then 
		col:=True;
	
end;

END.
if (((T.x + (0.5 * T.direction) > i) or (T.y + (0.5 * T.direction) > j)) and (c[i][j] = 'x')) then 
        col := True;
