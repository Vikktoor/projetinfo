unit collision;

interface

uses crt,types,cartes,math;

const epais : real=0.5;

procedure colliObsD(jou:joueur;c:tobst;var col:boolean);//collision case de droite
procedure colliObsG(jou:joueur;c:tobst;var col:boolean);//collision case de gauche
procedure colliObsH(jou:joueur;c:tobst;var col:boolean);//collision case en haut
procedure colliObsB(jou:joueur;c:tobst;var col:boolean);//collision case en bas

procedure colliObsDHD(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en haut droite
procedure colliObsDBD(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en bas droite
procedure colliObsDHG(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en haut gauche
procedure colliObsDBG(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en bas gauche

implementation



procedure colliObsD(jou:joueur;c:tobst;var col:boolean); //collision case de droite
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx)+1; 
	j:=trunc(jou.t.posy);
	if ((jou.t.posx+epais>i)  and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsG(jou:joueur;c:tobst;var col:boolean); //collisin case de gauche
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx)-1; 
	j:=trunc(jou.t.posy);
	if ((jou.t.posx-epais<i) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsH(jou:joueur;c:tobst;var col:boolean);
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx); 
	j:=trunc(jou.t.posy)-1;
	if ((jou.t.posy-epais<j) and (c[i][j]='x')) then 
		col:=True;
	
end;
procedure colliObsB(jou:joueur;c:tobst;var col:boolean);
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx); 
	j:=trunc(jou.t.posy)+1;
	if ((jou.t.posy+epais>j) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDHD(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en haut droite
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx)+1; 
	j:=trunc(jou.t.posx)-1;
	if ((((jou.t.posx+epais)>i) or( jou.t.posx-epais<j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDBD(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en bas droite
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx)+1; 
	j:=trunc(jou.t.posy)+1;
	if ((((jou.t.posx+epais)>i) or( jou.t.posy+epais>j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDHG(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en haut gauche
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx)-1; 
	j:=trunc(jou.t.posy)-1;
	if ((((jou.t.posx-epais)<i) or( jou.t.posy-epais<j)) and (c[i][j]='x')) then 
		col:=True;
	
end;

procedure colliObsDBG(jou:joueur;c:tobst;var col:boolean);//collision case diagonale en bas gauche
var i,j :Integer;

BEGIN
	i:=trunc(jou.t.posx)-1; 
	j:=trunc(jou.t.posy)+1;
	if (((jou.t.posx-epais)<i) or(jou.t.posy+epais>j)) and (c[i][j]='x') then 
		col:=True;
	
end;


END.
