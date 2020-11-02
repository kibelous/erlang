-module(p15).
-export([replicate/2]).

% p15:replicate([a,b,c], 3).
% [a,a,a,b,b,b,c,c,c]

replicate([], _) ->
    [];
replicate([H|T], N) ->
    p07:flatten([repeat(N,H)|replicate(T, N)]).

repeat(0, _) ->
    [];
repeat(N, C) ->
    [C|repeat(N-1, C)].