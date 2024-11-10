unit collision;

interface

uses crt,types,cartes,math;

procedure colliObsD(T:tank;c:tobst;var col:boolean);//collision case de droite
procedure colliObsG(T:tank;c:tobst;var col:boolean);//collision case de gauche
procedure colliObsH(T:tank;c:tobst;var col:boolean);//collision case en haut
procedure colliObsB(T:tank;c:tobst;var col:boolean);//collision case en bas

procedure colliObsDHD(T:tank;c:tobst;var col:boolean);//collision case diagonale en haut droite
procedure colliObsDBD(T:tank;c:tobst;var col:boolean);//collision case diagonale en bas droite
procedure colliObsDHG(T:tank;c:tobst;var col:boolean);//collision case diagonale en haut gauche
procedure colliObsDBG(T:tank;c:tobst;var col:boolean);//collision case diagonale en bas gauche

implementation

procedure colliObsD(T:tank;c:tobst;var col:boolean); //collision case de droite
var i,j :Integer;

BEGIN
	i:=trunc(T.x)+1; 
	j:=trunc(T.y);
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsG(T:tank;c:tobst;var col:boolean); //collisin case de gauche
var i,j :Integer;

BEGIN
	i:=trunc(T.x)-1; 
	j:=trunc(T.y);
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsH(T:tank;c:tobst;var col:boolean);
var i,j :Integer;

BEGIN
	i:=trunc(T.x); 
	j:=trunc(T.y)-1;
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;
procedure colliObsB(T:tank;c:tobst;var col:boolean);
var i,j :Integer;

BEGIN
	i:=trunc(T.x); 
	j:=trunc(T.y)+1;
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDHD(T:tank;c:tobst;var col:boolean);//collision case diagonale en haut droite
var i,j :Integer;

BEGIN
	i:=trunc(T.x)+1; 
	j:=trunc(T.y)-1;
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDBD(T:tank;c:tobst;var col:boolean);//collision case diagonale en bas droite
var i,j :Integer;

BEGIN
	i:=trunc(T.x)+1; 
	j:=trunc(T.y)+1;
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDHG(T:tank;c:tobst;var col:boolean);//collision case diagonale en haut gauche
var i,j :Integer;

BEGIN
	i:=trunc(T.x)-1; 
	j:=trunc(T.y)-1;
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDBG(T:tank;c:tobst;var col:boolean);//collision case diagonale en bas gauche
var i,j :Integer;

BEGIN
	i:=trunc(T.x)+1; 
	j:=trunc(T.y)+1;
	if (((T.x+(0.5*T.direction)>i) or( T.y+(0.5*T.direction)>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;


END.
