class Item < ActiveRecord::Base
  has_many :grocery_lists
  has_many :users, through: :grocery_lists


end
