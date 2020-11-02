-module(p08).
-export([compress/1]).

% ex. 8
% p08:compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [a,b,c,a,d,e]

compress(L) ->
    compress(L, []).

compress([], R) ->
    p05:reverse(R);
compress([H|T], [H|_]=R) ->
    compress(T, R);
compress([H|T], R) ->
    compress(T, [H|R]).