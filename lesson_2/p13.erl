-module(p13).
-export([decode/1]).

% p13:decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]).
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

decode(L) ->
    decode(L, []).

decode([], R) ->
    p05:reverse(p07:flatten(R));
decode([{N,C}|T], R) ->
    decode(T, [repeat(N,C)|R]).

repeat(0, _) ->
    [];
repeat(N, C) ->
    [C|repeat(N-1, C)].