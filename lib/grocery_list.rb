class GroceryList < ActiveRecord::Base
  belongs_to :item
  belongs_to :user

  # def grocery_list_items
  #   self.map do |list|
  #     list.name
  #   end
  # end

  def self.add_to_grocery_list (item_name, user_id)
    item_id = Item.find_by(name: item_name).id

    #or_create_by(name: item_name, brand: "store brand").id
    puts "How many do you need to purchase? Please only put a number and add other detailed under notes"
    item_quantity = gets.chomp.to_i
    
      if item_quantity == 0
        item_quantity = 1
      end
    puts "Add a special note to this item:"
    item_note = gets.chomp
    new = GroceryList.create(user_id: user_id, item_id: item_id, quantity: item_quantity, note: item_note)
    puts "Your item has been added to your list!"
  end

end
