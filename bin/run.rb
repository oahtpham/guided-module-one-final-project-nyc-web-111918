require_relative '../config/environment.rb'


welcome_user
username = get_username
user_id = return_user_id(username)


run(username, user_id)
