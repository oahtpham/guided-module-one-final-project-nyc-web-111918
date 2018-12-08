require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'
# require_all 'db'
require 'pry'
require 'colorize'

#welcome user to console
#gets user Name
#to list out grocery lists associated to user
#get input of list wanted
# returns items in the list

def welcome_user

  puts "Welcome! Let's figure out what you're shopping for today!"
end

def get_username
  loop do
  puts "What is your name?"
  user_name = gets.chomp
    if user_name == '' || user_name.delete(' ') == ''
      puts 'That is not a valid name'
    else
    return  user_name
      break
    end
  end
end

def user_grocery_items(username)
  system "clear"
  u1 = User.find_by(name: username)
  if u1.items == []
    puts "
    AAAHHHH your list is empty. Add to your list, homie!
    ".upcase
  else
    puts "Here are your items in your grocery list: "
      u1.grocery_lists.each_with_index do |listed_item, i|
        # binding.pry
        puts "
        #{i+1}. #{listed_item.item.brand}'s #{listed_item.item.name} (quantity: #{listed_item.quantity}) | TOTAL: $#{format_float(listed_item.item.price * listed_item.quantity)}"
        if listed_item.note != ""
        puts  "
        NOTE: #{listed_item.note} "
        end
      end
    end
  end

def format_float(float)
  '%.2f' % float
end

def budget(username)
  system "clear"
  puts "

    ~*~*~*~*~*~*~*~*
  "
  u1 = User.find_by(name: username)
  sum = 0
  u1.grocery_lists.each do |listed_item|
    sum = sum + (listed_item.item.price * listed_item.quantity)
  end
  if sum > u1.weekly_budget
    puts "Your grocery list total is $#{format_float(sum)}. You are over your budget by $#{format_float(sum - u1.weekly_budget)}.".upcase.bold.red
  else
    puts "Your grocery list total is $#{format_float(sum)}. You have $#{format_float(u1.weekly_budget-sum)} left in your budget.
    ".upcase.bold
  end
end



#
#
#   @options = {
#     "Add new item to grocery list" => -> do add(user_id) end,
#     "Delete an item from your list" => -> do delete(user_id) end
#   }
#
# prompt.expand('Do this?', options)
#
#


# def run(username, user_id)
#   options
# end
#
#




def help(username)

  user_instance= User.find_by(name: username)

  choices = ["VIEW your grocery list",
     "ADD a new item to your grocery list",
     "DELETE an item from your grocery list",
     "CALCULATE the price of items in your grocery list",
     "UPDATE your weekly budget", "EXIT"]
  prompt = TTY::Prompt.new
  response = prompt.select("Would you like to...", choices)

end


def run(username, user_id)

  loop do
    puts "
    ~*~*~*~*~*~*~*~*
    "
    user_response = help(username)
    if user_response == 'EXIT'
      puts "Goodbye!".bold.green
      break
    elsif user_response == "ADD a new item to your grocery list"
      add(user_id)
      sleep(2)
      user_grocery_items(username)
    elsif user_response == "DELETE an item from your grocery list"
      user_grocery_items(username)
      delete(user_id)
      sleep(2)
      user_grocery_items(username)
    elsif user_response == "VIEW your grocery list"
      user_grocery_items(username)
    elsif user_response == "CALCULATE the price of items in your grocery list"
      budget(username)
    elsif user_response == "UPDATE your weekly budget"
      update_budget(user_id)
    end
  end
end
#
# def edit(username)
#   user_grocery_items(username)
#   puts "What is the the name of the item you want to edit:"
#   item_name = gets.chomp
#   u1 = User.find_by(name: username)
#   item_instance = u1.grocery_lists.find do |listed_item|
#     listed_item.item.name == item_name
#   end
#   if item_instance == nil
#     puts "
#     That's not on your list! What're you doing?!"
#
#   else
#
#     puts "Change quantity or just push enter to move on to notes"
#     input
#
#
#
# end
#

def update_budget(user_id)
  system "clear"
  puts "What is your budget?"
  new_budget = gets.chomp.delete(',$').to_f
    if new_budget == 0.0
      User.update(user_id, weekly_budget: new_budget)
      puts "
      Invalid entry, Dick Ward! Your budget is $0, but you can update it : )
      ".upcase.bold.red
    else
      User.update(user_id, weekly_budget: new_budget)
      puts "
      Your budget has been set to $#{format_float(new_budget)}
      ".upcase.bold
    end
end

#
#
# def budget_input
#   puts "What would you like to update your budget to?"
#     budget = gets.chomp.to_f
# end

def add(user_id)
  loop do
    puts "Search item from Grocery Store to add:"
    item_name = gets.chomp.downcase
    if Item.find_by(name: item_name) == nil
      puts "Ahhh your item doesn't exist in our directory. ".bold.red
      choices = ["SEARCH again",
         "CREATE an item and add it to your list", "EXIT"]
      prompt = TTY::Prompt.new
      response = prompt.select("Would you like to...", choices)
        if response == "SEARCH again"
        elsif response == "CREATE an item and add it to your list"
          puts "Put price of #{item_name}:"
            price = gets.chomp.to_f
              if price == 0.0
                puts "Sorry you either put zero or we could not read. The price will be listed as 0.0, but it will probably cost more than that!".bold.red
                Item.create(name: item_name, brand: "N/A", price: price)
                GroceryList.add_to_grocery_list(item_name, user_id)
                break
              end #not valid price end
           Item.create(name: item_name, brand: "N/A", price: price)
           GroceryList.add_to_grocery_list(item_name, user_id)
        break
      elsif response == "EXIT"
        # breaks loop if item is created
        system "clear"
        break
      end
    else Item.find_by(name: item_name) != nil
      GroceryList.add_to_grocery_list(item_name, user_id)
      break #breaks out of loop if item is found in directory


    end

    end

  end

    #check spelling and search again or add i
  # item_id = Item.find_by(name: item_name).id
  # binding.pry
  # #or_create_by(name: item_name, brand: "store brand").id
  # puts "How much do you need to purchase?"
  # item_quantity = gets.chomp
  # puts "Add a special note to this item:"
  # item_note = gets.chomp
  # new = GroceryList.create(user_id: user_id, item_id: item_id, quantity: item_quantity, note: item_note)
  # puts "Your item has been added to your list!"



def return_user_id(username)
  user_id  = User.find_or_create_by(name: username).id
    if User.find_by(name: username).weekly_budget == nil


      update_budget(user_id)
    end
    user_id
end


def delete(user_id)
  puts "
  ~*~*~*~*~*~*~*~*
  "
  puts "What item would you like to delete? Please identify the item by number."
  item_number = gets.chomp
    if item_number.to_i == 0
      item_number = -1
    else
      item_number = item_number.to_i
    end
      list_array = User.find(user_id).grocery_lists.map do |list_instance|
        list_instance
        end
        if list_array[item_number - 1] == nil || item_number < 0
          puts "That ain't a valid input".bold.red
        else
        list_array[item_number - 1].delete
      puts "The item has been deleted from your list!".bold.red
        end

end

# def add_to_grocery_list (item_name, user_id)
#   item_id = Item.find_by(name: item_name).id
#
#   #or_create_by(name: item_name, brand: "store brand").id
#   puts "How much do you need to purchase?"
#   item_quantity = gets.chomp
#   puts "Add a special note to this item:"
#   item_note = gets.chomp
#   new = GroceryList.create(user_id: user_id, item_id: item_id, quantity: item_quantity, note: item_note)
#   puts "Your item has been added to your list!"
# end



#
 # binding.pry
