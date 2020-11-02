-module(p09).
-export([pack/1]).

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