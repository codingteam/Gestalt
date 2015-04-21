-module(public_api_sup).

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
    Dispatch = cowboy_router:compile([
        {'_', [{"/", public_api_http_handler, []}]}
    ]),
    {ok, { {one_for_one, 5, 10}, [
        { public_api_process
        , {cowboy, start_http, [public_api_httpd, 5, [{port, 8080}], [{env, [{dispatch, Dispatch}]}]]}
        , permanent
        , 1000
        , worker
        , []
    }]} }.
