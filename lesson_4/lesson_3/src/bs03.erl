-module(bs03).
-export([split/2]).

% BinText = <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>.
% <<"Col1-:-Col2-:-Col3-:-Col4-:-Col5">>
% bs03:split(BinText, "-:-").
% [<<"Col1">>, <<"Col2">>, <<"Col3">>, <<"Col4">>, <<"Col5">>]

split(Bin, Delim) ->
    BinDelim = list_to_binary(Delim),
    split(Bin, BinDelim, byte_size(BinDelim), 1, []).

split(Bin, Delim, DelimSize, I, Acc) ->
    case Bin of
        <<Word:I/binary>>                                         -> lists:reverse([Word|Acc]);
        <<Word:I/binary, Delim:DelimSize/binary, Rest/binary>>    -> split(Rest, Delim, DelimSize, 1, [Word|Acc]);
        _                                                         -> split(Bin, Delim, DelimSize, I+1, Acc)
    end.