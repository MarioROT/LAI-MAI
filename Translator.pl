wordtrans(casa, house, noun).
wordtrans(grande, big, adjective).
wordtrans(roja, red, adjective).
wordtrans(marron, brown, adjective).
wordtrans(una, a, article).
wordtrans(la, the, article).
stop(vaca).
stop(foca).

senttrans(SL, EL) :- translate(SL, [], ELRev), rearrange(ELRev, EL).

% Stop when stop word.
translate([Word|_], Acc, Acc) :- stop(Word), !.

% Translating a noun, appending it to the tanslated list, then continue with the next list items.
translate([Word|Tail], Acc, EL) :- wordtrans(Word, EngWord, noun), !,
                                   translate(Tail, [], RestEL),
                                   append([EngWord|Acc], RestEL, EL).

% Translating an adjective, appending it to the translated list, then continue wih the next list items.
translate([Word|Tail], Acc, EL) :- wordtrans(Word, EngWord, adjective), !,
                                   append(Acc, [EngWord], RestEl),
                                   translate(Tail, RestEl, EL).

% Translating an article: appending it to the translated list, then continue wih the next list items.
translate([Word|Tail], Acc, EL) :- wordtrans(Word, EngWord, article), !, 
                                   translate(Tail, Acc, RestEL),
                                   append([EngWord], RestEL, EL).

% Handling unknown words: treat them as articles for positioning.
translate([Word|Tail], Acc, EL) :- ( \+ wordtrans(Word, _, _) -> EngWord = '?'; wordtrans(Word, EngWord, _) ),
                                   translate(Tail, [EngWord|Acc], EL).
% No more words to translate
translate([], Acc, Acc).

% Predicates to easily identify the word type
is_noun(Word) :- wordtrans(_, Word, noun).
is_adjective(Word) :- wordtrans(_, Word, adjective).
is_article(Word) :- wordtrans(_, Word, article).

% Rearrange predicate
% Stop rearranging
rearrange([], []).
% When an noun is found it checks if it has a sequence of adjectives next to it, if so, then it rearranges them.
rearrange([Word|Tail], Result) :- is_noun(Word), collect_adjectives(Tail, Adj, Rest), !,
                                  rearrange(Rest, RearrangedRest),
                                  append(Adj, [Word|RearrangedRest], Result).

% When no rearrangement is needed just forward the tail for a possible rearrengment
rearrange([Word|Tail], [Word|Rest]) :- rearrange(Tail, Rest).

% Collect adjectives after a noun
% Stop collecting when there are no more words to collect
collect_adjectives([], [], []).

% If an adjective is found the continue checking for more adjectives
collect_adjectives([Word|Tail], [Word|Adj], Rest) :- is_adjective(Word),!,
                                                     collect_adjectives(Tail, Adj, Rest).
% Stop collecting when the word is not an adjective
collect_adjectives(List, [], List) :- List = [Word|_],
                                      \+ is_adjective(Word). 

% Custom predicate to reverse a list.
reverse([], Acc, Acc).
reverse([H|T], SoFar, Rev) :- reverse(T, [H|SoFar], Rev).

% Custom predicate to append two lists.
append([], L, L).
append([H|T], L, [H|R]) :- append(T, L, R).

