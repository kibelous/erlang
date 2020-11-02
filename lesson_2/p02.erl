-module(p02).
-export([but_last/1]).

% ex. 2
% p02:but_last([a,b,c,d,e,f]). 
% [e,f]

but_last([]) ->
    [];
but_last([H|[T|[]]]) ->
    [H,T];
but_last([_|T]) ->
    but_last(T).