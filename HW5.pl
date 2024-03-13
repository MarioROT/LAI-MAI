link(sagradafamilia, verdaguer, 4, blue).
link(verdaguer, girona, 3, yellow).
link(santpau, sagradafamilia, 2, blue).
link(verdaguer, diagonal, 3, blue).

numberofsteps(X,Y, 1, linked(X,Y)):- link(X,Y,A,_).
connected(X,Y, L, linked(X,C)):- link(X,Z,A,B),
                                connected(Z,Y,P,C), L is P+1.

connected(X,Y) :- link(X,Y,_,_).
connected(X,Z) :- link(Y,Z,_,_), connected(X,Y).

% child(anne, bridget).
% child(bridget, caroline).
% child(caroline, donna).
% child(dona, emily).

% descend(X,Y,1,daughter(X,Y)):- child(X,Y).
% descend(X,Y,L,daughter(X,C)):- child(X,Z),
%                    descend(Z,Y,P,C), L is P+1.
