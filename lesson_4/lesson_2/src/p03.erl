-module(p03).
-export([element_at/2]).
-include_lib("eunit/include/eunit.hrl").

% ex. 3
% p03:element_at([a,b,c,d,e,f], 4). 
% d
% p03:element_at([a,b,c,d,e,f], 10). 
% undefined

element_at([H|_], 1) ->
    H;
element_at([_|T], N) ->
    element_at(T, N-1);
element_at([], _) ->
    undefined.

element_at_test_() ->
    [?_assert(element_at([a,b,c,d,e,f], 4) =:= d),
    ?_assert(element_at([a,b,c,d,e,f], 5) =:= e),
    ?_assert(element_at([a,b,c,d,e,f], 10) =:= undefined),
	?_assertException(error, function_clause, element_at({a,b,c}, 2))
    ].