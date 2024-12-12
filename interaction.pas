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

procedure AffichScore(var j1, j2: joueur; var sdlTexture1, sdlTexture2,sdlTexture3,sdlTexture4: PSDL_Texture);

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





procedure AffichScore(var j1, j2: joueur; var sdlTexture1, sdlTexture2,sdlTexture3,sdlTexture4: PSDL_Texture);
begin

   //Chargement de la police
	if TTF_Init = -1 then HALT;
		ttfFont := TTF_OpenFont('./Police/Arialn.ttf', 100); //cherche la police
		TTF_SetFontOutline(ttfFont, 0); //creer un contour ou non au texte
		TTF_SetFontHinting(ttfFont, TTF_HINTING_NORMAL);
  
  
  
	// Définition des couleurs par valeurs RGB pour la police 1 et 2
	sdlColor1.r := 255; sdlColor1.g := 255; sdlColor1.b :=255;//blanc 
 
			
	case j1.score of
	0:scoreJ1 := TTF_RenderText_Blended(ttfFont,'0', sdlColor1);
	1:scoreJ1 := TTF_RenderText_Blended(ttfFont,'1', sdlColor1);  // On ne peut pas mettre une variable dans l'affichage de texte donc on définit 5 points maximum par joueur
	2:scoreJ1 := TTF_RenderText_Blended(ttfFont,'2', sdlColor1);
	3:scoreJ1 := TTF_RenderText_Blended(ttfFont,'3', sdlColor1);
	4:scoreJ1 := TTF_RenderText_Blended(ttfFont,'4', sdlColor1);
	5:scoreJ1 := TTF_RenderText_Blended(ttfFont,'5', sdlColor1);
	end;
	if scoreJ1 = nil then
		begin
			writeln('pb s1');
			Halt;
		end;
		
	case j2.score of
	0:scoreJ2 := TTF_RenderText_Blended(ttfFont,'0', sdlColor1);
	1:scoreJ2 := TTF_RenderText_Blended(ttfFont,'1', sdlColor1);  // On ne peut pas mettre une variable dans l'affichage de texte donc on définit 5 points maximum par joueur
	2:scoreJ2 := TTF_RenderText_Blended(ttfFont,'2', sdlColor1);
	3:scoreJ2 := TTF_RenderText_Blended(ttfFont,'3', sdlColor1);
	4:scoreJ2 := TTF_RenderText_Blended(ttfFont,'4', sdlColor1);
	5:scoreJ2 := TTF_RenderText_Blended(ttfFont,'5', sdlColor1);
	end;
	if scoreJ2 = nil then
		begin
			writeln('pb s2');
			Halt;
		end;
	
	if (j1.t.nomt='Vic') and (j2.t.nomt='Vic') then
		begin
			case j1.t.pv of
			200:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV: 200', sdlColor1);
			150:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:150', sdlColor1);
			100:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			50:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:50', sdlColor1);
			0:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
			case j2.t.pv of
			200:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV: 200', sdlColor1);
			150:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:150', sdlColor1);
			100:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			50:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:50', sdlColor1);
			else
			pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
		end;
		
	if (j1.t.nomt='Vic') and (j2.t.nomt='JM') then
		begin
			case j1.t.pv of
			200:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV: 200', sdlColor1);
			130:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:130', sdlColor1);
			60:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:60', sdlColor1);
			else
			pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
			case j2.t.pv of
			150:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:150', sdlColor1);
			100:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			50:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:50', sdlColor1);
			else
			pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
		end;
	
	if (j1.t.nomt='Vic') and (j2.t.nomt='Tom') then
		begin
			case j1.t.pv of
			200:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV: 200', sdlColor1);
			110:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:110', sdlColor1);
			20:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:20', sdlColor1);
			else
			pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
			case j2.t.pv of
			100:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			50:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:50', sdlColor1);
			else
			pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
		end;
		
		if (j1.t.nomt='JM') and (j2.t.nomt='JM') then
		begin
			case j1.t.pv of
			150:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:150', sdlColor1);
			80:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:80', sdlColor1);
			10:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:10', sdlColor1);
			else
			pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
			case j2.t.pv of
			150:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:150', sdlColor1);
			80:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:80', sdlColor1);
			10:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:10', sdlColor1);
			else
			pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
		end;
		
		if (j1.t.nomt='JM') and (j2.t.nomt='Tom') then
		begin
			case j1.t.pv of
			150:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:150', sdlColor1);
			60:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:60', sdlColor1);
			else
			pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
			case j2.t.pv of
			100:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			30:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:30', sdlColor1);
			else
			pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
		end;
		
		if (j1.t.nomt='Tom') and (j2.t.nomt='Tom') then
		begin
			case j1.t.pv of
			100:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			10:pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:10', sdlColor1);
			else
			pvJ1 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
			case j2.t.pv of
			100:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:100', sdlColor1);
			10:pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:10', sdlColor1);
			else
			pvJ2 := TTF_RenderText_Blended(ttfFont,'PV:0', sdlColor1);
			end;
		end;
	
		
    // Charger les textures (images)
	sdlTexture1 := SDL_CreateTextureFromSurface(sdlRenderer, scoreJ1);
	if sdlTexture1 = nil then
		Halt;
		
	sdlTexture2 := SDL_CreateTextureFromSurface(sdlRenderer, scoreJ2);
	if sdlTexture2 = nil then
		Halt;
		
	sdlTexture3 := SDL_CreateTextureFromSurface(sdlRenderer, pvJ1);
	if sdlTexture3 = nil then
		Halt;
	
	sdlTexture4 := SDL_CreateTextureFromSurface(sdlRenderer, pvJ2);
	if sdlTexture4 = nil then
		Halt;
end;





end.
