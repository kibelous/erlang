-module(p07).
-export([flatten/1]).

% ex. 7
% p07:flatten([a,[],[b,[c,d],e]]).
% [a, b, c, d, e]

flatten([]) ->
    [];
flatten([[]|T]) ->
    flatten(T);
flatten([[SubH|SubT]|T]) ->
    flatten([SubH|[SubT|T]]);
flatten([H|T]) -> 
    [H|flatten(T)].