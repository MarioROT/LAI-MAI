link(sagrera, fabra, 3, red).
link(arcdetriomf, marina, 2, red).
link(marina, glories, 3, red).
link(glories, clot, 4, red).
link(clot, encants, 2, purple).
link(encants, sagradafamilia, 2, pruple).
link(bompastor, onzedesetembre, 3, orange).
link(onzedesetembre, sagrera, 2, orange).
link(sagrera, navas, 5, red).
link(navas, clot, 2, red).
link(clot, bacderoda, 1, pruple).
link(bacderoda, stmarti, 2, purple).
link(sagrera, congres, 3, blue).
link(congres, maragall, 4, blue).
link(maragall, guinardo, 2, yellow).
link(guinardo, alfonsx, 3, yellow).
link(alfonsx, joanic, 1, yellow).
link(joanic, verdaguer, 4, yellow).
link(verdaguer, sagradafamilia, 4, blue).
link(sagradafamilia, santpau, 2, blue).
link(santpau, campdelarpa, 3, blue).
link(campdelarpa, sagrera, 4, blue).
link(horta,vilapicina,3,blue).
link(santacoloma, barodeviver, 9, red).

connected(A,B) :- link(A,B,_,_).
connected(A,C) :- link(B,C,_,_), connected(A,B).

numberofsteps(A,B,1):-link(A,B,_,_).
numberofsteps(A,C,N):-link(A,B,_,_),
                      numberofsteps(B,C,P), N is P+1.


routedistance(A,B,move(A,B,D),D):-link(A,B,D,_).
routedistance(A,C,move(A,B,E,H),S):-link(A,B,E,_),
                                    routedistance(B,C,H,P), S is P+E.

sameline(A,B,C):-link(A,B,_,C).
sameline(A,G,C):-link(B,G,_,C),
                 sameline(A,B,C).

distance(A,B,D):-link(A,B,D,_).
distance(A,C,D):-link(A,B,E,_),
                 distance(B,C,P), D is P+E.

route(A,B,move(A,B,D)):-link(A,B,D,_).
route(A,C,move(A,B,H,G)):-link(A,B,H,_),
                          route(B,C,G).



