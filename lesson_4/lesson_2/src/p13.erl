-module(p13).
-export([decode/1]).
-include_lib("eunit/include/eunit.hrl").

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

decode_test_() ->
    [?_assert(decode([{4,a},{1,b},{2,c},{2,a},{1,d},{4,e}]) =:= [a,a,a,a,b,c,c,a,a,d,e,e,e,e]),
    ?_assert(decode([{4,a},{5,b},{2,c},{3,b},{2,c},{2,a},{1,d},{8,e}]) =:= [a,a,a,a,b,b,b,b,b,c,c,b,b,b,c,c,a,a,d,e,e,e,e,e,e,e,e]),
	?_assertException(error, function_clause, decode({}))
    ].