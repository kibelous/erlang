-module(p09).
-export([pack/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 9
% p09:pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]).
% [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]

pack(L) ->
    pack(L, []).

pack([], R) ->
    p05:reverse(R);
pack([H|T], [[H|_]|_]=R) ->
    [SubH|SubT] = R,
    pack(T, [[H|SubH]|SubT]);
pack([H|T], R) ->
    pack(T, [[H]|R]).

pack_test_() ->
    [?_assert(pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e]) =:= [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]),
    ?_assert(pack([a,a,a,a,b,b,b,b,b,c,c,b,b,b,c,c,a,a,d,e,e,e,e,e,e,e,e]) =:= [[a,a,a,a],[b,b,b,b,b],[c,c],[b,b,b],[c,c],[a,a],[d],[e,e,e,e,e,e,e,e]]),
	?_assertException(error, function_clause, pack({}))
    ].