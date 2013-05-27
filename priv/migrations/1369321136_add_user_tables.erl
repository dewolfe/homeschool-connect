%% Migration: add_user_tables

{add_user_tables,
fun(up) ->
boss_db:execute("create table users (id serial unique, fName varchar(100), lName varchar(100), password string) ");
(down) ->
boss_db:execute("drop table users")

end}.
