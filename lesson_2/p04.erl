-module(p04).
-export([len/1]).

% ex. 4
% p04:len([]).
% 0
% p04:len([a,b,c,d]).
% 4

len([]) ->
    0;
len([_|T]) ->
    len(T) + 1.