-module(homeschool_root_controller,[Req]).
-compile(export_all).


hello('GET',[])->
  {ok,[{greeting,"hello world"}]}.


list('GET',[]) ->
  Greetings=boss_db:find(greeting,[]),
  {ok,[{greetings,Greetings}]}.

create('GET',[])->
  ok;
create('POST',[])->
  GreetingText=Req:post_param("greeting_text"),
  NewGreeting=greeting:new(id,GreetingText),
  case NewGreeting:save() of
    {ok,SavedGreeting}->
      {redirect,[{action,"list"}]};
    {error,ErrorList}->
      {ok,[{errors,ErrorList},{new_mesg,NewGreeting}]}
      end.


goodbye('POST',[])->
  boss_db:delete(Req:post_param("greeting_id")),
  {redirect,[{action,"list"}]}.

send_test_message('GET',[])->
  TestMessage="Fee at last",
  boss_mq:push("test-channel",TestMessage),
  {output,TestMessage}.

pull('GET',[LastTimeStamp])->
  {ok,TimeStamp,Greetings}=boss_mq:pull("new-greetings",list_to_integer(LastTimeStamp)),
  {json,[{timestamp,TimeStamp},{greetings,Greetings}]}.

live('GET',[])->
  Greetings=boss_db:find(greeting,[]),
  TimeStamp=boss_mq:now("new-greetings"),
  {ok,[{greetings,Greetings},{timestamp,TimeStamp}]}.



