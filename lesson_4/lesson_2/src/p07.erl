-module(p07).
-export([flatten/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 7
% p07:flatten([a,[],[b,[c,d],e]]).
% [a, b, c, d, e]

flatten([]) ->
    [];
flatten([[]|T]) ->
    flatten(T);
flatten([[SubH|SubT]|T]) ->
    flatten([SubH|[SubT|T]]);
flatten([H|T]) -> 
    [H|flatten(T)].

flatten_test_() ->
    [?_assert(flatten([a,[],[b,[c,d],e]]) =:= [a,b,c,d,e]),
    ?_assert(flatten([a,[b,[c,[d]],e]]) =:= [a,b,c,d,e]),
	?_assertException(error, function_clause, flatten({}))
    ].