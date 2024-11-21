program MouseCoordinatesSDL2;

uses SDL2;

var
  window: PSDL_Window;
  renderer: PSDL_Renderer;
  running: Boolean;
  mouseX, mouseY: Integer;
  event: TSDL_Event;

begin
  if SDL_Init(SDL_INIT_VIDEO) < 0 then
  begin
    Writeln('Erreur SDL: ', SDL_GetError);
    Halt(1);
  end;

  window := SDL_CreateWindow('Coordonnées de la Souris', SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 800, 600, SDL_WINDOW_SHOWN);
  if window = nil then
  begin
    Writeln('Erreur de création de fenêtre: ', SDL_GetError);
    SDL_Quit;
    Halt(1);
  end;

  renderer := SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
  if renderer = nil then
  begin
    Writeln('Erreur de création du renderer: ', SDL_GetError);
    SDL_DestroyWindow(window);
    SDL_Quit;
    Halt(1);
  end;

  running := True;
  while running do
  begin

    SDL_GetMouseState(@mouseX, @mouseY);
    Writeln('Coordonnées de la souris : X=', mouseX, ' Y=', mouseY);

    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_RenderClear(renderer);
    SDL_RenderPresent(renderer);

    SDL_Delay(100);
  end;

  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);
  SDL_Quit;
end.
