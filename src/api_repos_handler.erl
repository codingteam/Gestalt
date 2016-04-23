-module(api_repos_handler).

-export([init/2, known_methods/2, allowed_methods/2, resource_exists/2,
         content_types_provided/2, to_application_json/2]).

-record(state, {result = <<"">>}).

init(Req, _Opts) ->
  {cowboy_rest, Req, #state{}}.

%Req2 = cowboy_req:reply(200, [{<<"content-type">>, <<"application/json">>}], <<"{}">>, Req),
%{ok, Req2, []}.

known_methods(Req, State) ->
  {[<<"OPTIONS">>, <<"HEAD">>, <<"GET">>], Req, State}.

allowed_methods(Req, State) ->
  {[<<"OPTIONS">>, <<"HEAD">>, <<"GET">>], Req, State}.

resource_exists(Req, State) ->
  case ets:lookup(computed_stats_cache, repos) of
    [{repos, Result}] -> {true, Req, State#state{result = Result}};
    [] -> {false, Req, State}
  end.

content_types_provided(Req, State) ->
  {[{<<"application/json">>, to_application_json}], Req, State}.

to_application_json(Req, State) ->
  {State#state.result, Req, State}.
