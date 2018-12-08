User.create(name: "Isaac", weekly_budget: 125.0)
User.create(name: "Thao", weekly_budget: 150.0)
User.create(name: "Tony", weekly_budget: 10.0)
User.create(name: "V.Chan", weekly_budget: 300.0)


500.times do
 Item.create(name: Faker::Food.ingredient.downcase, price: (1..20).to_a.sample.to_f, brand: ["Amy","Trader Joe", "Whole Food 365", "Campbell"].sample)
end

10.times do
  GroceryList.create(user_id: 1, item_id: rand(0..100), purchased?: false, quantity: 1, note: "" )
  GroceryList.create( user_id: 2, item_id: rand(0..100), purchased?: false, quantity: 1, note: "" )
  GroceryList.create( user_id: 3, item_id: rand(0..100), purchased?: true, quantity: 1, note: "" )
end
