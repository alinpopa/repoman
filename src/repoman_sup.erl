-module(repoman_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    ElliOpts = [{callback, test_callback}, {port, 3000}],
    ElliSpec = {
        elli,
        {elli, start_link, [ElliOpts]},
        permanent,
        5000,
        worker,
        [elli]},
    Processes = [ElliSpec],
    {ok, {{one_for_one, 10, 10}, Processes}}.

