-module(bs04).
-export([decode/2]).

% bs04:decode(Json, proplist).
% Json = <<"
% {
%   'squadName': 'Super hero squad',
%   'homeTown': 'Metro City',
%   'formed': 2016,
%   'secretBase': 'Super tower',
%   'active': true,
%   'members': [
%     {
%       'name': 'Molecule Man',
%       'age': 29,
%       'secretIdentity': 'Dan Jukes',
%       'powers': [
%         'Radiation resistance',
%         'Turning tiny',
%         'Radiation blast'
%       ]
%     },
%     {
%       'name': 'Madame Uppercut',
%       'age': 39,
%       'secretIdentity': 'Jane Wilson',
%       'powers': [
%         'Million tonne punch',
%         'Damage resistance',
%         'Superhuman reflexes'
%       ]
%     },
%     {
%       'name': 'Eternal Flame',
%       'age': 1000000,
%       'secretIdentity': 'Unknown',
%       'powers': [
%         'Immortality',
%         'Heat Immunity',
%         'Inferno',
%         'Teleportation',
%         'Interdimensional travel'
%       ]
%     }
%   ]
% }
% ">>.

decode(Json, DataType) ->
    StripJson = strip(Json, 0, <<>>),
    case DataType of
        proplist -> proplist(StripJson, [{<<>>, <<>>}]);
        map      -> map(StripJson, {<<>>, <<>>}, #{});
        _           -> {error, data_type}
    end.

proplist(<<"}">>, [{_, _}|_] = Acc) ->
    lists:reverse(Acc);
proplist(<<"{", Rest/binary>>, [{<<>>, <<>>}] = Acc) ->
    proplist(Rest, Acc);
proplist(<<"'", Rest/binary>>, Acc) ->
    proplist(Rest, Acc);
proplist(<<":", Rest/binary>>, [{<<>>, Key}|T]) ->
    proplist(Rest, [{Key, <<>>}|T]);
proplist(<<",", Rest/binary>>, [{Key, Value}|T]) ->
    proplist(Rest, [{<<>>, <<>>}, {Key, to_type(Value)}|T]);
proplist(<<"[", Rest/binary>>, [{Key, <<>>}|T])->
    case get_list(Rest, <<>>, 0, []) of
        {List, Out} -> proplist(Out, [{Key, lists:reverse([proplist(X, [{<<>>, <<>>}]) || X <- List])}|T]);
        _ -> {error, get_list_error}
    end;
proplist(<<"{", Rest/binary>>, [{Key, _}|T]) ->
    case get_json(Rest, <<>>, 0) of
        {BinAcc, Out} -> proplist(Out, [{Key, proplist(BinAcc, [{<<>>, <<>>}])}|T]);
        _             -> {error, get_json_error}
    end;
proplist(<<X/utf8, Rest/binary>>, [{Key, Value}|T]) ->
    proplist(Rest, [{Key, <<Value/binary, X>>}|T]);
proplist(<<>>, [{<<>>, Value}]) ->
    Value.

map(<<"}">>, {Key, Value}, Acc) ->
    maps:put(Key, Value, Acc);
map(<<"{", Rest/binary>>, {<<>>, <<>>} = Buf, Acc) ->
    map(Rest, Buf, Acc);
map(<<"'", Rest/binary>>, Buf, Acc) ->
    map(Rest, Buf, Acc);
map(<<":", Rest/binary>>, {<<>>, Key}, Acc) ->
    map(Rest, {Key, <<>>}, Acc);
map(<<",", Rest/binary>>, {Key, Value}, Acc) ->
    map(Rest, {<<>>, <<>>}, maps:put(Key, to_type(Value), Acc));
map(<<"[", Rest/binary>>, {Key, <<>>}, Acc) ->
    case get_list(Rest, <<>>, 0, []) of
        {List, Out} -> map(Out, {Key, [map(X, {<<>>, <<>>}, #{}) || X <- List]}, Acc);
        _ -> {error, get_list_error}
    end;
map(<<"{", Rest/binary>>, {Key, <<>>}, Acc) ->
    case get_json(Rest, <<>>, 0) of
        {Bin, Out} -> map(Out, {Key, map(Bin, {<<>>, <<>>}, #{})}, Acc);
        _             -> {error, get_json_error}
    end;
map(<<X/utf8, Rest/binary>>, {Key, Value}, Acc) ->
    map(Rest, {Key, <<Value/binary, X>>}, Acc);
map(<<>>, {<<>>, Value}, #{}) ->
    to_type(Value).

get_list(<<"]", Rest/binary>>, BinAcc, 0, Acc) ->
    {lists:reverse([BinAcc|Acc]), Rest};
get_list(<<",", Rest/binary>>, BinAcc, 0, Acc) ->
    get_list(Rest, <<>>, 0, [BinAcc|Acc]);
get_list(<<"{", Rest/binary>>, BinAcc, I, Acc) ->
    get_list(Rest, <<BinAcc/binary, "{">>, I+1, Acc);
get_list(<<"}", Rest/binary>>, BinAcc, I, Acc) ->
    get_list(Rest, <<BinAcc/binary, "}">>, I-1, Acc);
get_list(<<"[", Rest/binary>>, BinAcc, I, Acc) ->
    get_list(Rest, <<BinAcc/binary, "[">>, I+1, Acc);
get_list(<<"]", Rest/binary>>, BinAcc, I, Acc) ->
    get_list(Rest, <<BinAcc/binary, "]">>, I-1, Acc);
get_list(<<X/utf8, Rest/binary>>, BinAcc, I, Acc) ->
    get_list(Rest, <<BinAcc/binary, X>>, I, Acc).

get_json(<<"}", Rest/binary>>, BinAcc, 0) ->
    {<<BinAcc/binary, "}">>, Rest};
get_json(<<"{", Rest/binary>>, BinAcc, I) ->
    get_json(Rest, <<BinAcc/utf8, "{">>, I+1);
get_json(<<"}", Rest/binary>>, BinAcc, I) ->
    get_json(Rest, <<BinAcc/binary, "}">>, I-1);
get_json(<<X/utf8, Rest/binary>>, BinAcc, I) ->
    get_json(Rest, <<BinAcc/binary, X>>, I).

strip(Bin, I, Acc) ->
    case Bin of
        <<" ", Rest/binary>> when I =:= 0 -> strip(Rest, I, Acc);
        <<"'", Rest/binary>> when I =:= 1 -> strip(Rest, 0, Acc);
        <<"'", Rest/binary>> when I =:= 0 -> strip(Rest, I+1, Acc);
        <<"\n", Rest/binary>>             -> strip(Rest, I, Acc);
        <<X/utf8, Rest/binary>>           -> strip(Rest, I, <<Acc/binary, X>>);
        _                                 -> Acc
    end.

to_type(Bin) ->
    case Bin of
        <<"true">> -> true;
        <<"false">> -> false;
        _ -> 
            try binary_to_integer(Bin)
            catch
                error:badarg ->
                    Bin
            end
    end.