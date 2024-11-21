unit u_types;

interface

uses sdl2,sdl2_image, SDL2_MIXER, sdl2_ttf,sysutils;

type TCoordonnee = record 
	x : real ;
	y : real ;
end;

type TVecteur = record 
	x : real ;
	y : real ;
end;

type TSkin = record 
	cheminAccees : Pchar ;
	texture : PSDL_Texture ;
end;

type TBouton = record 
	skin : TSkin ;
	estCliquee : Boolean ;
	Bcord : TCoordonnee ;
	largeur : Integer;
	hauteur : Integer;
end;

type TArme = record
	nbProjectiles : integer ;
	nbProjectilesMax : integer ;
	skin : TSkin ; 
	projectileSkin : TSkin ;
	compteur : integer ;
	cadence : integer ;
	degat : integer ;
	precision : integer ;
	son : PMix_Chunk ;
end;

type TArmeRamasse = record
	nbProjectiles : integer ;
	nbProjectilesMax : integer ;
	skin : TSkin ;
	projectileSkin : TSkin ;
	cadence : integer ;
	degat : integer ;
	precision : integer ;
	son : PMix_Chunk ;
	afficher : Boolean ;
	Acord : TCoordonnee ;
	largeur : integer ; 
	hauteur : integer ;
end;

type TableauArmesRamasse = array of TArmeRamasse ;

type TableauArmes = array of TArme ; 

type TVie = record
	total : integer ;
	actuel : integer ;
	skin : TSkin ;
	fond : Tskin;
	son : PMix_Chunk;
end;
	
type TJoueur = record
	skinRepo : TSkin ;
	skinTir : TSkin ;
	armes : TableauArmes ;
	indiceArme : integer ;
	Jcord : TCoordonnee ;
	Scord : TCoordonnee ;
	direction : TVecteur ;
	vitesse : TVecteur ; 
	vie : TVie ;
end;

type TCible = record
	arme :TArme ;
	Ccord : TCoordonnee ;
	vie : TVie ;
	skin : TSkin;
end;

type TableauCibles = array of TCible ;
	
type TDecor = record
	skin : TSkin ;
	Dcord : TCoordonnee ;
	largeur : integer;
	hauteur : integer;
	hLargeur : integer ;
	hHauteur : integer ;
end;

type TableauDecors = array of TDecor ;

type TProjectile = record
	degat : integer ;
	Pcord : TCoordonnee ;
	vitesse : TVecteur ; 
	skin : TSkin ;
end;

type TableauProjectiles = array of TProjectile ;

type TMap = record 
	skin : TSkin ; 
	lstDecors : TableauDecors ;
	lstCibles : TableauCibles ;
	lstProjectiles : TableauProjectiles ;
	lstArmes : TableauArmesRamasse ;
end;

type TFenetre = record 
	window: PSDL_Window;
	renderer: PSDL_Renderer;
	event: TSDL_Event;
	largeurFenetre : Integer;
	hauteurFenetre : Integer;
end;

type TBot = record 
	skin : TSkin ;
	arme : TArme ;
	Bcord : TCoordonnee ;
	direction : TVecteur ; 
	vie : TVie ;
end; 
 
type Tmusic = record
	bandeSon : PMix_Music;
	estJouee : Boolean;
end;

type TmenuIG = record
	btnSon : TBouton ; 
	btnBruitage : TBouton ; 
	btnMenu : TBouton ;
	music : Tmusic;
	fond : PSDL_Texture ;
	skinFond : TSkin ;
	skinMun : TSkin ;
end;

type TmenuNiveau = record
	facile : TBouton;
	moyen : TBouton;
	difficle : TBouton;
	extreme : TBouton;
	impossible : TBouton;
	niveau : Integer;
	fond : PSDL_Texture;
end;

type Tmenu = record
	btnJouer : TBouton;
	btnSon : TBouton;
	btnEntrainement : TBouton;
	music : Tmusic;
	fond : PSDL_Texture;
end;

type TPartie = record 
	fenetre : Tfenetre;
	gagnee : Boolean ;
	entrainement : Boolean ;
	map : TMap ; 
	joueur : TJoueur ;
	bot : TBot ;
	score : integer ;
	menuIG : TmenuIG;
	menu : Tmenu;
	menuNiveau : TmenuNiveau;
end ;

implementation

end.
