%% Copyright
-module(homeschool_user,[Id,Fname,Lname,Password::string()]).
-author("dewolfe").

%% API
-compile(export_all).
-define(SALTY_SALT,"There can be only one!").

session_identifier() ->
  mochihex:to_hex(erlang:md5(?SALTY_SALT++Id)).

check_password(PasswordTry)->
  {ok,Password} =:= bcrypt:hashpw(PasswordTry,Password).

login_cookies() ->
  [ mochiweb_cookies:cookie("colosimo_user_id", Id, [{path, "/"}]),
    mochiweb_cookies:cookie("session_id", session_identifier(), [{path, "/"}]) ].