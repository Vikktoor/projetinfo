program tankMania;

uses SDL2, SDL2_image, cartes, types, interaction, jouercartes;

var n, choix:integer;
	j1,j2:joueur;
	Tabt:Ttank;

begin

iniT(Tabt);
menu(j1,j2,Tabt);
choix:=0;

while choix <> 1 do

begin

	writeln('Quelle carte voulez-vous afficher ?');
	writeln('');
	writeln('1: carte neige');
	writeln('2: carte jungle');
	writeln('3: carte sable');
	readln(n);
	writeln('');
			
	//Permet d'avoir obligatoirement une réponse entre 1 et 3
	while (n<1) or (n>3) do
		begin
			writeln('Veuillez entrer un nombre compris entre 1 et 3');
			readln(n);
		end;
		
	//Affichage carte 1
	if n=1 then
		begin
			affCarte1;
			writeln('Voulez-vous jouer sur cette carte ?');
			writeln('1: oui');
			writeln('2: non');
			readln(choix);
			//Permet d'avoir obligatoirement 1 ou 2
			while (choix<1) or (choix>2) do
				begin
					writeln('Veuillez entrer 1 ou 2');
					readln(choix);
				end;
			//Début de la partie sur la carte 1	
			if choix = 1 then
				jouercarte1(j1,j2);
		end;
	
	//Affichage carte 2	
	if n=2 then
		begin
			affCarte2;
			writeln('Voulez-vous jouer sur cette carte ?');
			writeln('1: oui');
			writeln('2: non');
			readln(choix);
			//Permet d'avoir obligatoirement 1 ou 2
			while (choix<1) or (choix>2) do
				begin
					writeln('Veuillez entrer 1 ou 2');
					readln(choix);
				end;
			//Debut de la partie sur la carte 2	
			if choix = 1 then
				jouercarte2(j1,j2);
		end;
		
	//Affichage carte 3	
	if n=3 then
		begin
			affCarte3;
			writeln('Voulez-vous jouer sur cette carte ?');
			writeln('1: oui');
			writeln('2: non');
			readln(choix);
			//Permet d'avoir obligatoirement 1 ou 2
			while (choix<1) or (choix>2) do
				begin
					writeln('Veuillez entrer 1 ou 2');
					readln(choix);
				end;
			//Debut de la partie sur la carte 3	
			if choix = 1 then
				jouercarte3(j1,j2);
		end;
	end;

end.
