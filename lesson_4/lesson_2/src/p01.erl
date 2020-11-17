-module(p01).
-export([last/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 1
% p01:last([a,b,c,d,e,f]).
% f

last([]) ->
    [];
last([H|[]]) ->
    H;
last([_|T]) ->
    last(T).

last_test_() ->
    [?_assert(last([a,b,c,d,e,f]) =:= f),
    ?_assert(last([a,b,c,d]) =:= d),
	?_assertException(error, function_clause, last({}))
    ].
