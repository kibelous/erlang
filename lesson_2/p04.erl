-module(p04).
-export([len/1]).

% p04:len([]).
% 0
% p04:len([a,b,c,d]).
% 4

len([]) ->
    0;
len([_|T]) ->
    1 + len(T);
len(_) ->
    undefined.