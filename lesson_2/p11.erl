-module(p11).
-export([encode_modified/1]).

% ex. 11
% p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]). 
% [{4,a},b,{2,c},{2,a},d,{4,e}]

encode_modified(L) ->
    encode_modified(p10:encode(L), []).

encode_modified([], R) ->
    p05:reverse(R);
encode_modified([{1,H}|T], R) ->
    encode_modified(T, [H|R]);
encode_modified([{_,_}=Tuple|T], R) ->
    encode_modified(T, [Tuple|R]).