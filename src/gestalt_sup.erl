-module(gestalt_sup).

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
  {ok, { {one_for_one, 5, 10}, [
      { fetcher_sup_process
      , {fetcher_sup, start_link, []}
      , permanent
      , 1000
      , supervisor
      , [fetcher_sup]
      }
  ,   { public_api_sup_process
      , {public_api_sup, start_link, []}
      , permanent
      , 1000
      , supervisor
      , [public_api_sup]
      }
  ]} }.

