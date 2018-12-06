class DropStoreColumnFromItems < ActiveRecord::Migration[5.0]
  def change
    remove_column :items, :store
  end
end
