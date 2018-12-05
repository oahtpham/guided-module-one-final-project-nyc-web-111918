class User < ActiveRecord::Base
  has_many :grocery_lists
  has_many :items, through: :grocery_lists

  # def grocery_list_items
  #   self.grocery_lists.map do |list|
  #     list.name
  #   end
  # end


  def update_budget(user_id, budget_input)
    user_instance = find_by(user_id: user_id)
    user_instance.weekly_budget = budget_input
  end

end
