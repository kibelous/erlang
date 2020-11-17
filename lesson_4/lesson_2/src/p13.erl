-module(p13).
-export([decode/1]).

% ex. 13
% p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

decode(L) ->
    decode(L, []).

decode([], R) ->
    p05:reverse(R);
decode([{1,C}|T], R) ->
    decode(T, [C|R]);
decode([{N,C}|T], R) ->
    decode([{N-1,C}|T], [C|R]).