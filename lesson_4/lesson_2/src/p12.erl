-module(p12).
-export([decode_modified/1]).

% ex. 12
% p12:decode_modified([{4,a},b,{2,c},{2,a},d,{4,e}]). 
% [a,a,a,a,b,c,c,a,a,d,e,e,e,e]

decode_modified(L) ->
    decode_modified(L, []).

decode_modified([], R) ->
    p05:reverse(R);
decode_modified([{1,C}|T], R) ->
    decode_modified(T, [C|R]);
decode_modified([{N,C}|T], R) ->
    decode_modified([{N-1,C}|T], [C|R]);
decode_modified([H|T], R) ->
    decode_modified(T, [H|R]).