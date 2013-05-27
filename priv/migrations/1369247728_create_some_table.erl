%% Migration: create_some_table

{create_some_table,
  fun(up) ->
      boss_db:execute("create table greetings ( id serial unique, greetings_text varchar,
	                       created_at timestamp )");
  (down) ->
      boss_db:execute("drop table some_table")
  end}.
