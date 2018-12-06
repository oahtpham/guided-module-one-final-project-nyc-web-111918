class User < ActiveRecord::Base
  has_many :grocery_lists
  has_many :items, through: :grocery_lists

  # def grocery_list_items
  #   self.grocery_lists.map do |list|
  #     list.name
  #   end
  # end
  # def user_grocery_items(username)
  #   u1 = User.find_by(name: username)
  #   if u1.items == []
  #     puts "
  #     AAAHHHH your list is empty. Add to your list, homie!
  #     ".upcase
  #   else
  #     puts "Here are your items in your grocery list: "
  #       u1.grocery_lists.each_with_index do |listed_item, i|
  #         # binding.pry
  #         puts "
  #         #{i+1}. #{listed_item.item.brand}'s #{listed_item.item.name} (quantity: #{listed_item.quantity}) | TOTAL: $#{format_float(listed_item.item.price * listed_item.quantity)}"
  #         if listed_item.note != ""
  #         puts  "
  #         NOTE: #{listed_item.note} "
  #         end
  #       end
  #     end
  #   end


  def update_budget(user_id, budget_input)
    user_instance = find_by(user_id: user_id)
    user_instance.weekly_budget = budget_input
  end

end
