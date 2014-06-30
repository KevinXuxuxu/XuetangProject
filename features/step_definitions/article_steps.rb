Given /^the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    article[:category] = Category.find_by_name(article[:category])
    article[:author] = User.find_by_name(article[:author])
    Article.create!(article)
  end
end
