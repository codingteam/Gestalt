-module(repo_fetcher).

-export([fetch/0]).

fetch() ->
  Header = <<"{ result: ">>,
  Time = integer_to_binary(erlang:system_time()),
  Footer = <<" }">>,

  Result = <<Header/binary, Time/binary, Footer/binary>>,

  true = ets:insert(computed_stats_cache, {repos, Result}),

  ok.
