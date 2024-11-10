communication tom entre vpn et ordi
procedure colliObsDBG(T:tank;c:tobst;var col:boolean);//collision case diagonale en bas gauche
var i,j :Integer;

BEGIN
	i:=trunc(T.x)-1; 
	j:=trunc(T.y)+1;
	if ((((T.x-epais)>i) or( T.y+epais)) and (c[i][j]='x')) then 
		col:=True;
	
end;
