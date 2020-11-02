-module(p07).
-export([flatten/1]).

% ex. 7
% p07:flatten([a,[],[b,[c,d],e]]).
% [a, b, c, d, e]

flatten(L) ->
    flatten(L, []).

flatten([], Rest) ->
    Rest;
flatten([[]|T], Rest) ->
    flatten(T, Rest);
flatten([[_|_]=H|T], Rest) ->
    flatten(H, flatten(T, Rest));
flatten([H|T], Rest) -> 
    [H|flatten(T, Rest)].