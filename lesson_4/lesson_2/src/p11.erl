-module(p11).
-export([encode_modified/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 11
% p11:encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]). 
% [{4,a},b,{2,c},{2,a},d,{4,e}]

encode_modified(L) ->
    encode_modified(L, []).

encode_modified([], R) ->
    p05:reverse(R);
encode_modified([H|T], [{N,H}|R]) ->
    encode_modified(T, [{N+1,H}|R]);
encode_modified([H,H|T], R) ->
    encode_modified(T, [{2,H}|R]);
encode_modified([H|T], R) ->
    encode_modified(T, [H|R]).

encode_modified_test_() ->
    [?_assert(encode_modified([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [{4,a},b,{2,c},{2,a},d,{4,e}]),
    ?_assert(encode_modified([a,a,a,a,b,b,b,b,b,c,c,b,b,b,c,c,a,a,d,e,e,e,e,e,e,e,e]) =:= [{4,a},{5,b},{2,c},{3,b},{2,c},{2,a},d,{8,e}]),
	?_assertException(error, function_clause, encode_modified({}))
    ].