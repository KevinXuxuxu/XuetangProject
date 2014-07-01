Given /^the following categories exist/ do |categories_table|
  categories_table.hashes.each do |category|
    category[:parent] = Category.find_by_name(category[:parent])
    Category.create!(category)
  end
end
