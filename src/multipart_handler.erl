-module(multipart_handler).
-behaviour(cowboy_http_handler).
-export([init/3, handle/2, terminate/2]).

init({_Transport, http}, Req, []) ->
    {ok, Req, {}}.

handle(Req, State) ->
    {Parts, Req2} = cowboy_http_req:multiparts(Req),
    Result = [ begin
                   {{_SubType, Params}, Part2} = cowboy_multipart:parse_header(<<"Content-Disposition">>, Part),
		   {Body, Part3} = cowboy_multipart:body(Part2),
                   {<<"filename">>, FN} = lists:keyfind(<<"filename">>, 1, Params),
                   io_lib:format("Got file: ~p of size ~p~n", [FN, iolist_size(Body)])
               end || Part <- Parts ],
    {ok, Req3} = cowboy_http_req:reply(200, [], Result, Req2),
    {ok, Req3, State}.

terminate(_Req, _State) ->
    ok.
