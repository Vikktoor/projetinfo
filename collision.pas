unit collision;

interface


uses crt,types,cartes,math,SDL2, SDL2_image;
var  sdlRectangle: TSDL_Rect;
const epais : real=0.5;



procedure collision(tob:tobst; j: joueur);

implementation



procedure collision(tob:tobst; j: joueur); 
var i:integer;
colli:boolean;
begin
sdlRectangle(j.t.x, j.t.y, 40, 40);

    for i:=1 to 24 do
		begin
			Colli := SDL_HasIntersection(@tob[i], @sdlrectangle) = SDL_TRUE;
			if colli then
				writeln('collision avce obstacle',i,'.');
		end;
end;


begin
end.
