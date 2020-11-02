-module(p01).
-export([last/1]).

% ex. 1
% p01:last([a,b,c,d,e,f]).
% f

last([]) ->
    [];
last([H|[]]) ->
    H;
last([_|T]) ->
    last(T).
