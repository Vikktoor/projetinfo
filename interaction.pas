unit interaction ;

Interface 
uses types;

procedure afficTank(T: Ttank);

procedure choixTank(T :Ttank;var j: joueur);

procedure menu(var j1,j2:joueur;Tabt:Ttank);

Implementation

procedure afficTank(T: Ttank);
var i:integer;
Begin 
	For i:=1 to 3 do
		begin
			writeln();
			writeln('Tank n°',i);
			writeln(T[i].nomt);
			writeln(T[i].degats);
			writeln(T[i].Pv);
		end;


end;

procedure choixTank(T :Ttank;var j: joueur);
var n :integer;
Begin
	writeln(j.nom,', quel tank choisissez vous ? ');
	readln(n);
	j.t.nomT:=T[n].nomt;
	j.t.degats:=T[n].degats;
	j.t.Pv:=T[n].Pv;
end;

procedure menu(var j1,j2:joueur;Tabt:Ttank);

BEGIN
	
	afficTank(Tabt);
	writeln('j1 veuillez rentrer votre nom');
	readln(j1.nom);
	writeln('j2 veuillez rentrer votre nom');
	readln(j2.nom);
	choixTank(Tabt,j1);
	writeln();
	writeln('Récap: ');
	writeln(j1.nom,', votre tank s''appelle ',j1.t.nomT,'.');
	writeln('Chaque boulet inflige ',j1.t.degats,' degats a votre adversaire.');
	writeln('Votre tank à ' ,j1.t.Pv,' Pv.');
	choixTank(Tabt,j2);
	writeln();
	writeln('Récap: ');
	writeln(j2.nom,', votre tank s''appelle ',j2.t.nomT,'.');
	writeln('Chaque boulet inflige ',j2.t.degats,' degats a votre adversaire.');
	writeln('Votre tank à ' ,j2.t.Pv,' Pv.');
	
END;

end.
