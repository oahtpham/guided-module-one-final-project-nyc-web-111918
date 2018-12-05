class CreateGroceryLists < ActiveRecord::Migration[5.0]
  def change
    create_table :grocery_lists do |t|
      t.integer :user_id
      t.integer :item_id
      t.boolean :purchased?
      t.string  :note
      t.string  :quantity
      # t.timestamps :date_purchased
    end
  end
end
