-module(gestalt_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  ets:new(computed_stats_cache, [set, public, named_table]),

  Dispatch = cowboy_router:compile([
      {'_', [{"/organizations/codingteam/repos", api_repos_handler, []}]}
  ]),
  {ok, _} = cowboy:start_clear(http, 100, [{port, 8080}], #{env => #{dispatch => Dispatch}}),

  gestalt_sup:start_link().

stop(_State) ->
  ok.
