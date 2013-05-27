%% Copyright
-module(greeting, [Id, GreetingText]).
-author("dewolfe").

%% API
-compile(export_all).


validation_tests() ->
  [{fun() -> length(GreetingText) > 0 end,
    "Geeting must bo non-empty"},
    {fun() -> length(GreetingText) =< 140 end,
      "Greeting my be twwetabel"}].

after_create()->
  boss_mq:push("new-greetings",THIS).

