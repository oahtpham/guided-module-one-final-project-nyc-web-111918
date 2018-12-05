User.create(name: "Isaac", weekly_budget: 125.0)
User.create(name: "Thao", weekly_budget: 150.0)
User.create(name: "Tony", weekly_budget: 10.0)
User.create(name: "V.Chan", weekly_budget: 300.0)


1000.times do
 Item.create(name: Faker::Food.ingredient.downcase, price: (1..20).to_a.sample.to_f, store: ['Local Food Town', 'Trader Joes','Whole Foods'].sample, brand: 'Goya')
end

10.times do
  GroceryList.create(user_id: 1, item_id: rand(0..100), purchased?: false, quantity: "4", note: "Don't get the grossss one." )
  GroceryList.create( user_id: 2, item_id: rand(0..100), purchased?: false, quantity: "some", note: "Get the cheapest one." )
  GroceryList.create( user_id: 3, item_id: rand(0..100), purchased?: true, quantity: "a bajillion", note: "boop" )
end
