unit tirs;


interface

uses crt,types,interaction;
procedure tirJ1(j:joueur);
procedure tirJ2(j:joueur);

implementation

procedure tirJ1(j:joueur);
var touche:char;
i:integer;
BEGIN
	touche:=readkey;
	if touche=' ' then
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



procedure tirJ2(j:joueur);
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
