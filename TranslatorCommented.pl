% Fact definitions for word translations and stop words.
wordtrans(casa, house, noun).
wordtrans(grande, big, adjective).
wordtrans(roja, red, adjective).
wordtrans(marron, brown, adjective).
wordtrans(una, a, article).
wordtrans(la, the, article).
stop(vaca).
stop(foca).

% Entry predicate to start the translation process.
senttrans(SL, EL) :- translate(SL, [], ELRev), rearrange(ELRev, EL).

% Handling stop words.
translate([Word|_], Acc, Acc) :- stop(Word), !.

% Handling nouns: the noun is placed in front of accumulated adjectives.
translate([Word|Tail], Acc, EL) :-
    wordtrans(Word, EngWord, noun), !,
    reverse(Acc, [], AdjectivesRev),
    translate(Tail, [], RestEL),
    append([EngWord|AdjectivesRev], RestEL, EL).

% Handling adjectives: accumulate them for later reordering.
translate([Word|Tail], Acc, EL) :-
    wordtrans(Word, EngWord, adjective), !,
    translate(Tail, [EngWord|Acc], EL).

% Handling articles: directly place them at the beginning of the translation.
translate([Word|Tail], Acc, EL) :-
    wordtrans(Word, EngWord, article), !,
    translate(Tail, Acc, RestEL),
    append([EngWord], RestEL, EL).

% Handling unknown words: treat them as articles for positioning.
translate([Word|Tail], Acc, EL) :-
    ( \+ wordtrans(Word, _, _) -> EngWord = '?'; wordtrans(Word, EngWord, _) ),
    translate(Tail, Acc, RestEL),
    append([EngWord], RestEL, EL).

% Base case: no more words to translate.
translate([], Acc, Acc).


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

% Helper predicate to reverse a list.
reverse([], Acc, Acc).
reverse([H|T], SoFar, Rev) :- reverse(T, [H|SoFar], Rev).

% Helper predicate to append two lists.
append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).
