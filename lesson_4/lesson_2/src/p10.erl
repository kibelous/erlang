-module(p10).
-export([encode/1]).

% ex. 10
% p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]

encode(L) ->
    encode(L, []).

encode([], R) ->
    p05:reverse(R);
encode([H|T], [{N,H}|R]) ->
    encode(T, [{N+1,H}|R]);
encode([H|T], R) ->
    encode(T, [{1,H}|R]).