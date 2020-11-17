-module(bs02).
-export([words/1]).

% BinText = <<"Text with four words">>.
% <<"Text with four words">>
% bs02:words(BinText).
% [<<"Text">>, <<"with">>, <<"four">>, <<"words">>]

words(Bin) ->
    words(Bin, <<>>, []).

words(<<>>, Word, Acc) ->
    lists:reverse([Word|Acc]);
words(<<" ", Rest/binary>>, Word, Acc) ->
    words(Rest, <<>>, [Word|Acc]);
words(<<C/utf8, Rest/binary>>, Word, Acc) ->
    words(Rest, <<Word/binary, C>>, Acc).