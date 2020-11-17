-module(p02).
-export([but_last/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 2
% p02:but_last([a,b,c,d,e,f]). 
% [e,f]

but_last([]) ->
    [];
but_last([H,H2|[]]) ->
    [H, H2];
but_last([_|T]) ->
    but_last(T).

but_last_test_() ->
    [?_assert(but_last([a,b,c,d,e,f]) =:= [e,f]),
    ?_assert(but_last([a,b,c,d]) =:= [c,d]),
	?_assertException(error, function_clause, but_last({}))
    ].