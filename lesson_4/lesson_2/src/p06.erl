-module(p06).
-export([is_palindrome/1]).
-include_lib("eunit/include/eunit.hrl").

% ex. 6
% p06:is_palindrome([1,2,3,2,1]). 
% true

is_palindrome([]) ->
    false;
is_palindrome([_|[]]) ->
    false;
is_palindrome(L) ->
    L == p05:reverse(L).

is_palindrome_test_() ->
    [?_assert(is_palindrome([1,2,3,2,1]) =:= true),
    ?_assert(is_palindrome([a,b,c,b,a]) =:= true),
    ?_assert(is_palindrome([a,b,c]) =:= false),
	?_assertException(error, function_clause, is_palindrome({}))
    ].