-module(p15).
-export([replicate/2]).

% ex. 15
% p15:replicate([a,b,c], 3).
% [a,a,a,b,b,b,c,c,c]

replicate(L, N) ->
    replicate(L, N, []).

replicate([], _, R) ->
    p05:reverse(R);
replicate([{1,C}|T], N, R) ->
    replicate(T, N, [C|R]);
replicate([{N2,C}|T], N, R) ->
    replicate([{N2-1,C}|T], N, [C|R]);
replicate([H|T], N, R) ->
    replicate([{N,H}|T], N, R).