wordtrans(casa, house, noun).
wordtrans(grande, big, adjective).
wordtrans(roja, red, adjective).
wordtrans(marron, brown, adjective).
wordtrans(una, a, article).
wordtrans(la, the, article).
stop(vaca).
stop(foca).

% Predicate to check if a word is a noun
is_noun(Word) :- wordtrans(_, Word, noun).

% Predicate to check if a word is an adjective
is_adjective(Word) :- wordtrans(_, Word, adjective).

% Predicate to check if a word is an article
is_article(Word) :- wordtrans(_, Word, article).

% rearrange predicate
rearrange([], []).
rearrange([H|T], Result) :-
    is_noun(H), % If H is a noun
    collect_adjectives(T, Adj, Rest), % Collect adjectives following the noun
    !, % Cut to prevent backtracking
    rearrange(Rest, RearrangedRest),
    append(Adj, [H|RearrangedRest], Result).
rearrange([H|T], [H|ResultRest]) :-
    rearrange(T, ResultRest).

% Collect adjectives until an article or a noun is found
collect_adjectives([], [], []).
collect_adjectives([H|T], [H|Adj], Rest) :-
    is_adjective(H), % If H is an adjective, continue collecting
    !, % Cut to prevent backtracking on adjective check
    collect_adjectives(T, Adj, Rest).
collect_adjectives(List, [], List) :-
    List = [H|_],
    (is_noun(H); is_article(H); \+ is_adjective(H)). % Stop collecting if H is not an adjective



