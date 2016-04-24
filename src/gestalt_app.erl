-module(gestalt_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

-include_lib("kernel/include/inet.hrl").

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
  ets:new(computed_stats_cache, [set, public, named_table]),

  Dispatch = cowboy_router:compile([
      {'_', [{"/organizations/codingteam/repos", api_repos_handler, []}]}
  ]),

  HostEnv = application:get_env(gestalt, http_host, "::"),
  {ok, Host} = case inet:parse_address(HostEnv) of
                 {ok, ParsedAddress} -> {ok, ParsedAddress};

                 Other ->
                   case inet:gethostbyname(HostEnv) of
                     {ok, Hostent} ->
                       [HostAddress|_] = Hostent#hostent.h_addr_list,
                       {ok, HostAddress};

                     Other -> Other
                   end
               end,

  PortEnv = application:get_env(gestalt, http_port, 80),
  {ok, Port} = if PortEnv >= 0 andalso PortEnv =< 65535 -> {ok, PortEnv};
                  true -> error
               end,

  {ok, _} = cowboy:start_clear(
              httpd,
              100,
              [{ip, Host}, {port, Port}],
              #{env => #{dispatch => Dispatch}}),

  fetchers_manager_sup:start_link().

stop(_State) ->
  ok.
