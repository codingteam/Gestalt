-module(fetchers_manager_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
  UpdateInterval = application:get_env(gestalt, update_interval, 60),
  FetchersSpecs = [repo_fetcher],

  {ok, { {one_for_one, 5, 10}, [
      { fetchers_manager
      , {fetchers_manager, start_link, [UpdateInterval, FetchersSpecs]}
      , permanent
      , 1000
      , worker
      , [fetchers_manager] }
  ]} }.
