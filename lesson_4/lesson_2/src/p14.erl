-module(p14).
-export([duplicate/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 14
% p14:duplicate([a,b,c,c,d]).
% [a,a,b,b,c,c,c,c,d,d]

duplicate([]) ->
    [];
duplicate([H|T]) ->
    [H,H|duplicate(T)].

decode_test_() ->
    [?_assert(duplicate([a,b,c,c,d]) =:= [a,a,b,b,c,c,c,c,d,d]),
    ?_assert(duplicate([a,b,c,c,d,d]) =:= [a,a,b,b,c,c,c,c,d,d,d,d]),
	?_assertException(error, function_clause, duplicate({}))
    ].