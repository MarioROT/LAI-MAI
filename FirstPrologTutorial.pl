% Knowledge Base 1
woman(mia).
woman(jody).
woman(yolanda).
playsAirGuitar(jody).
party.


% Knowledge Base 2
happy(yolanda).
listens2Music(mia).
listens2Music(yolanda):- happy(yolanda).
playsAirGuitar(mia):- listens2Music(mia).
playsAirGuitar(yolanda):-


% Knowledge Base 3
happy(vincent).
listens2Music(butch).
playsAirGuitar(vincent):-
   listens2Music(vincent),
   happy(vincent).
playsAirGuitar(butch):-
   happy(butch).
playsAirGuitar(butch):-
   listens2Music(butch).

% Knowledge Base 4
woman(mia).
woman(jody).
woman(yolanda).

loves(vincent,mia).
loves(marsellus,mia).
loves(pumpkin,honey_bunny).
loves(honey_bunny,pumpkin).
loves(toni, toni) % loves(X,X)
% loves(X,Y), woman(Y)

loves(vincent,mia).
loves(marsellus,mia).
loves(pumpkin,honey_bunny).
loves(honey_bunny,pumpkin).

jealous(X,Y):- loves(X,Z), loves(Y,Z), X\=Y.
% jelous(marsellus, W).
