require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'
# require_all 'db'
require 'pry'


#welcome user to console
#gets user Name
#to list out grocery lists associated to user
#get input of list wanted
# returns items in the list

def welcome_user
  puts "Welcome! Let's figure out what you're shopping for today!"
end

def get_username
  puts "What is your name?"
  gets.chomp
end

def user_grocery_items(username)
  u1 = User.find_by(name: username)
  if u1.items == []
    puts "
    AAAHHHH your list is empty. Add to your list, homie!
    ".upcase
  else
    puts "Here are your items in your grocery list: "
      u1.grocery_lists.each_with_index do |listed_item, i|
        puts "#{i+1}. #{listed_item.item.brand}'s #{listed_item.item.name} (quantity: #{listed_item.quantity})"
        if listed_item.note != ""
        puts  "Note: #{listed_item.note} "
        end
      end
    end
  end

def format_float(float)
  '%.2f' % float
end

def budget(username)
  puts "
  ~*~*~*~*~*~*~*~*
  "
  u1 = User.find_by(name: username)
  sum = 0
  u1.grocery_lists.each do |listed_item|
    sum = sum + listed_item.item.price
  end
  if sum > u1.weekly_budget
    puts "Your grocery list total is $#{format_float(sum)}. You are over your budget by $#{format_float(sum - u1.weekly_budget)}.".upcase
  else
    puts "Your grocery list total is $#{format_float(sum)}. You have $#{format_float(u1.weekly_budget-sum)} left in your budget.".upcase
  end
end

def help(username)
  user_instance= User.find_by(name: username)

  puts "
  ~*~*~*~*~*~*~*~*
  "

  puts "Hi #{username},
    What would you like to do? Your options are:
      - type 'add' to add an new item to your grocery list
      - type 'delete' to delete an item from your grocery list
      - type 'list' to view your grocery list
      - type 'budget' to calculate the price of items in your grocery list against your weekly budget of $#{user_instance.weekly_budget.to_i}
      - type 'update' to change your weekly budget

      - type 'exit' to leave the app"
  puts "
  ~*~*~*~*~*~*~*~*
      "
end


def run(username, user_id)

  loop do
    help(username)
    user_response = gets.chomp
    if user_response == 'exit'
      puts "Goodbye!"
      break
    elsif user_response == 'add'
      add(user_id)
    elsif user_response == 'delete'
      delete(user_id)
    elsif user_response == 'list'

      user_grocery_items(username)
    elsif user_response == 'budget'
      budget(username)
    elsif user_response == 'update'
      update_budget(user_id)
    else
      puts "
      I am sorry #{username}, but I cannot let you do that!
      ".upcase
    end
  end
end




def update_budget(user_id)
  puts "What is your budget?"
  new_budget = gets.chomp.delete(',$').to_f
    if new_budget == 0.0
      User.update(user_id, weekly_budget: new_budget)
      puts "Invalid entry, Dick Ward! Your budget is $0, but you can update it : )".upcase
    else
      User.update(user_id, weekly_budget: new_budget)
      puts "Your budget has been set to $#{format_float(new_budget)} ".upcase
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
      puts "Ahhh your item doesn't exist in our directory. Would you like to:
      - type 'search' to search again
      - type 'create' to create item and add it to your list"
      #helper method to search again
      search_or_create = gets.chomp.downcase
        if search_or_create == 'search'
        elsif search_or_create == 'create'
          #create by name and estimated price
          puts "Put price of #{item_name}:"
          price = gets.chomp.to_f
          #if someone enters a not valid price
          if price == 0.0
            puts "Sorry you either put zero or we could not read. The price will be listed as 0.0, but it will probably cost more than that!"
          end #not valid price end
          Item.create(name: item_name, store: "Not your local grocer", brand: "N/A", price: price)
          GroceryList.add_to_grocery_list(item_name, user_id)
          break # breaks loop if item is created
        else
          puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
          stop messing with this app! You think this is a game!!!
          I'm sending you back to the last search option as a punishment
          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!".upcase
          break
        end #search or create if statement end
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
  puts "What item would you like to delete?"
  item_name = gets.chomp


  if Item.find_by(name: item_name) == nil
    puts "
    I'm sorry, I can't let you do that. #{item_name} is not on your grocery list.
      "
    else
      item_id = Item.find_by(name: item_name).id
      GroceryList.find_by(user_id: user_id, item_id: item_id).delete
      puts "The item has been deleted from your list!"
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
 #binding.pry
