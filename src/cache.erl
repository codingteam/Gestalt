-module(cache).

-behaviour(gen_server).

%% API
-export([start/0, start_link/0, stop/0]).
%% Read API, supposed to be used by public_api module
-export([get_news/2, get_activity/1, get_analytics/1]).
%% Write API, supposed to be used by fetcher module
-export([append_to_news/1, update_activity/1, update_analytics/1]).
%% Gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
        code_change/3]).

%% ===================================================================
%% Records
%% ===================================================================

-record(cache_state,
    {}).

%% ===================================================================
%% API
%% ===================================================================

start() ->
    gen_server:start({local, cache}, ?MODULE, {}, []).

start_link() ->
    gen_server:start_link({local, cache}, ?MODULE, {}, []).

stop() ->
    gen_server:call(cache, stop).

%% ===================================================================
%% Read API
%% ===================================================================

get_news(Name, Args) ->
    gen_server:call(Name, {get_news, Args}).

get_activity(Name) ->
    gen_server:call(Name, get_activity).

get_analytics(Name) ->
    gen_server:call(Name, get_analytics).

%% ===================================================================
%% Write API
%% ===================================================================

append_to_news(News) ->
    gen_server:cast(cache, {append_to_news, News}).

update_activity(Update) ->
    gen_server:cast(cache, {update_activity, Update}).

update_analytics(Update) ->
    gen_server:cast(cache, {update_analytics, Update}).

%% ===================================================================
%% Gen_server callbacks
%% ===================================================================

init(_Args) ->
    {ok, #cache_state{}}.

handle_info(_Msg, State = #cache_state{}) ->
    {noreply, State}.

handle_call(_Msg, _From, State = #cache_state{}) ->
    {noreply, State}.

handle_cast(_Msg, State = #cache_state{}) ->
    {noreply, State}.

code_change(_OldVersion, State = #cache_state{}, _Extra) ->
    {ok, State}.

terminate(_Reason, _State) ->
    ok.
