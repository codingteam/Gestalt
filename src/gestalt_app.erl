-module(gestalt_app).

-behaviour(application).

%% Application callbacks
-export([start/0, start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start() ->
    gestalt_sup:start_link().

start(_StartType, _StartArgs) ->
    gestalt_sup:start_link().

stop(_State) ->
    ok.
