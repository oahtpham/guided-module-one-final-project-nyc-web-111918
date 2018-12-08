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
    puts "#{item_name} is $#{format_float(Item.find(item_id).price)} for one unit.
What quantity would like to add to your list? (NUMBER VALUES ONLY!)"
    item_quantity = gets.chomp.to_i

      if item_quantity == 0
        item_quantity = 1
      elsif item_quantity > 500
        puts "What are you a ship captain? There is a 500 quantity limit"
        item_quantity = 500
      end
    puts "Add a special note to this item:"
    item_note = gets.chomp
    new = GroceryList.create(user_id: user_id, item_id: item_id, quantity: item_quantity, note: item_note)
    puts "Your item has been added to your list!".bold.blue
  end

end
