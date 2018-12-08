require_relative '../config/environment.rb'

puts "

  .oooooo.
 d8P'  `Y8b
888           oooo d8b  .ooooo.   .ooooo.  oooo d8b
888   ooooo  `888""8P    d88' `88b d88'      `888""8P
`88.    .88'   888     888   888 888    oo  888
 `Y8bood8P'   d888b    `Y8bod8P' `Y8bod8P' d888b
                                     ______
                                    /
              _ _ _ _ _ _ _\_ _ _ _|
             |_|_|_|_|_|_|_|\|_|_|_|
             |-|-|-|-|-|-|-|-\-|-|-|
             |_|_|_|_|_|_|_|_|\|_|_|
             |-|-|-|-|-|-|-|-|-\-|-|
             |_|_|_|_|_|_|_|_|_|\|_|
             |-|-|-|-|-|-|-|-|-|-|-|
             |_|_|_|_|_|_|_|_|_|_|_|\
                         \           \
                          \           |
             ____ ____ ____\___ ____ _/
            /  |____|          |____|
                \__/            \__/

".blue

welcome_user
username = get_username
user_id = return_user_id(username)


run(username, user_id)
