-module(p03).
-export([element_at/2]).

% p03:element_at([a,b,c,d,e,f], 4). 
% d
% p03:element_at([a,b,c,d,e,f], 10). 
% undefined

element_at([H|_], 1) ->
    H;
element_at([_|T], N) ->
    element_at(T, N-1);
element_at([], _) ->
    undefined.