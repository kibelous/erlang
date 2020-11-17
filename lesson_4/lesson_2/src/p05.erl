-module(p05).
-export([reverse/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 5
% p05:reverse([1,2,3]).
%  [3,2,1]

reverse(L) ->
    reverse(L, []).

reverse([], R) ->
    R;
reverse([H|T], R) ->
    reverse(T, [H|R]).

reverse_test_() ->
    [?_assert(reverse([a,b,c]) =:= [c,b,a]),
    ?_assert(reverse([a,b,c,d,e]) =:= [e,d,c,b,a]),
	?_assertException(error, function_clause, reverse({}))
    ].