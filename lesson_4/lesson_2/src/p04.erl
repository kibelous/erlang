-module(p04).
-export([len/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 4
% p04:len([]).
% 0
% p04:len([a,b,c,d]).
% 4

len([]) ->
    0;
len([_|T]) ->
    len(T) + 1.

len_test_() ->
    [?_assert(len([a,b,c,d,e,f]) =:= 6),
    ?_assert(len([a,b,c,d,e]) =:= 5),
    ?_assert(len([]) =:= 0),
	?_assertException(error, function_clause, len({}))
    ].