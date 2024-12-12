unit interaction ;

Interface 
uses types,SDL2, SDL2_image,SDL2_ttf,crt;
const
  SURFACE_WIDTH = 800;
  SURFACE_HEIGHT = 200;

var
	sdlWindow1: PSDL_Window;
    sdlRenderer: PSDL_Renderer;
    sdlTexture1, sdlTexture2,sdlTexture3,sdlTexture4: PSDL_Texture;
    sdlRectangle: TSDL_Rect;
    sdlColor1, sdlColor2: TSDL_Color;
    ttfFont: PTTF_Font;
    nomJ1, nomJ2, scoreJ1, scoreJ2,pvJ1,pvJ2: PSDL_Surface;
    LT:Ttank;
    i,j:integer;
	
procedure afficTank(T: Ttank);

procedure choixTank(T :Ttank;var j: joueur);

procedure menu(var j1,j2:joueur;Tabt:Ttank);

Implementation

procedure afficTank(T: Ttank);
var i:integer;
Begin 
	For i:=1 to 3 do
		begin
			writeln('');
			writeln('Tank numero ',i);
			writeln('nom :',T[i].nomt);
			writeln('degats :',T[i].degats);
			writeln('Pv :',T[i].Pv);
			writeln('coefficient de vitesse diagonale :',T[i].vitesse:3:2);
		end;


end;

procedure choixTank(T :Ttank;var j: joueur);
var n :integer;
Begin
	writeln(j.nom,', quel tank choisissez vous ? ');
	readln(n);
	while (n<1) or (n>3) do
		begin
			writeln('Veuillez entrer un nombre compris entre 1 et 3');
			readln(n);
		end;
	j.t.nomT:=T[n].nomt;
	j.t.degats:=T[n].degats;
	j.t.Pv:=T[n].Pv;
	j.t.vitesse:=T[n].vitesse;
end;

procedure menu(var j1,j2:joueur;Tabt:Ttank);

BEGIN
	
	afficTank(Tabt);
	writeln('');
	writeln('j1 veuillez rentrer votre nom');
	readln(j1.nom);
	writeln('j2 veuillez rentrer votre nom');
	readln(j2.nom);
	choixTank(Tabt,j1);
	writeln('');
	writeln('Recap: ');
	writeln(j1.nom,', votre tank s''appelle ',j1.t.nomT,'.');
	writeln('Chaque boulet inflige ',j1.t.degats,' degats a votre adversaire.');
	writeln('Votre tank a ' ,j1.t.Pv,' Pv.');
	writeln('Votre tank a un coefficient de vitesse de ' ,j1.t.vitesse:3:2,' .');
	choixTank(Tabt,j2);
	writeln('');
	writeln('Recap: ');
	writeln(j2.nom,', votre tank s''appelle ',j2.t.nomT,'.');
	writeln('Chaque boulet inflige ',j2.t.degats,' degats a votre adversaire.');
	writeln('Votre tank a ' ,j2.t.Pv,' Pv.');
	writeln('Votre tank a un coefficient de vitesse diagonale de ' ,j2.t.vitesse:3:2,' .');
	
END;

end.
