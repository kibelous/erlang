-module(p05).
-export([reverse/1]).

% p05:reverse([1,2,3]).
%  [3,2,1]

reverse(L) ->
    reverse(L, []).

reverse([], R) ->
    R;
reverse([H|T], R) ->
    reverse(T, [H|R]).