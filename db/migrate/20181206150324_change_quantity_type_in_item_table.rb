class ChangeQuantityTypeInItemTable < ActiveRecord::Migration[5.0]
  def change
    change_column :grocery_lists, :quantity, :integer

  end
end
