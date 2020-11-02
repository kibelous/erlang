-module(p10).
-export([encode/1]).

% p10:encode([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]

encode(L) ->
    encode(p09:pack(L), []).

encode([], R) ->
    p05:reverse(R);
encode([[H|_]|T]=Temp, R) ->
    [SubL|_] = Temp,
    encode(T, [{p04:len(SubL),H}|R]).
