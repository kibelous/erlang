-module(p15).
-export([replicate/2]).
-include_lib("eunit/include/eunit.hrl").

% ex. 15
% p15:replicate([a,b,c], 3).
% [a,a,a,b,b,b,c,c,c]

replicate(L, N) ->
    replicate(L, N, []).

replicate([], _, R) ->
    p05:reverse(R);
replicate([{1,C}|T], N, R) ->
    replicate(T, N, [C|R]);
replicate([{N2,C}|T], N, R) ->
    replicate([{N2-1,C}|T], N, [C|R]);
replicate([H|T], N, R) ->
    replicate([{N,H}|T], N, R).

replicate_test_() ->
    [?_assert(replicate([a,b,c], 3) =:= [a,a,a,b,b,b,c,c,c]),
    ?_assert(replicate([a,b,c,d], 2) =:= [a,a,b,b,c,c,d,d]),
	?_assertException(error, function_clause, replicate({},0))
    ].