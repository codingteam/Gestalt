-module(public_api_http_handler).

-export([init/2]).

init(Req, Opts) ->
  {ok, Req, Opts}.
