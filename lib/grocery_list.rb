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
    puts "How much do you need to purchase?"
    item_quantity = gets.chomp
    puts "Add a special note to this item:"
    item_note = gets.chomp
    new = GroceryList.create(user_id: user_id, item_id: item_id, quantity: item_quantity, note: item_note)
    puts "Your item has been added to your list!"
  end

end
