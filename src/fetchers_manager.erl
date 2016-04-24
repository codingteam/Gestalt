-module(fetchers_manager).

-behaviour(gen_server).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
         code_change/3]).

-export([start_link/2]).

-record(fetchers_manager_state,
        { update_interval = 60
        , fetchers_specs = []
        , timer
        }).

start_link(UpdateInterval, FetcherSpecs) ->
  gen_server:start_link(?MODULE, [UpdateInterval, FetcherSpecs], []).

init(Args) ->
  [UpdateIntervalSec, FetcherSpecs] = Args,
  UpdateInterval = 1000 * UpdateIntervalSec,

  Timer = erlang:send_after(UpdateInterval, self(), tick),
  {ok,
   #fetchers_manager_state{ update_interval = UpdateInterval
                          , fetchers_specs = FetcherSpecs
                          , timer = Timer},
  hibernate}.

handle_call(_Request, _From, State) ->
  {noreply, State, hibernate}.

handle_cast(_Request, State) ->
  {noreply, State, hibernate}.

handle_info(tick, State) ->
  erlang:cancel_timer(State#fetchers_manager_state.timer),

  % spawning fetchers
  lists:map(fun(Module) ->
                spawn(fun() -> erlang:apply(Module, fetch, []) end)
            end,
            State#fetchers_manager_state.fetchers_specs),

  Timer = erlang:send_after(State#fetchers_manager_state.update_interval,
                            self(),
                            tick),
  {noreply, State#fetchers_manager_state{timer = Timer}, hibernate};
handle_info(_Info, State) ->
  {noreply, State, hibernate}.

terminate(_Reason, State) ->
  erlang:cancel_timer(State#fetchers_manager_state.timer).

code_change(_OldVsn, _State, _Extra) ->
  {error, "fetchers_manager doesn't support upgrades"}.
