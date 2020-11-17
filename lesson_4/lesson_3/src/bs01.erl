-module(bs01).
-export([first_word/1]).

% BinText = <<"Some text">>.
% <<"Some Text">>
% bs01:first_word(BinText).
% <<”Some”>>

first_word(Bin) ->
    first_word(Bin, <<>>).

first_word(<<" ", _/binary>>, Result) ->
    Result;
first_word(<<X/utf8, Rest/binary>>, Result) ->
    first_word(Rest, <<Result/binary, X>>).