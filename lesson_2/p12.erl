-module(p12).
-export([decode_modified/1]).

% ex. 12
% p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]). 
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

decode_modified(L) ->
    decode_modified(L, []).

decode_modified([], R) ->
    p05:reverse(p07:flatten(R));
decode_modified([{N,C}|T], R) ->
    decode_modified(T, [repeat(N,C)|R]);
decode_modified([H|T], R) ->
    decode_modified(T, [H|R]).

repeat(0, _) ->
    [];
repeat(N, C) ->
    [C|repeat(N-1, C)].

