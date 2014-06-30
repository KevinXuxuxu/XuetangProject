# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{name: "Gougou Jin", stu_id: "2012012000"},
                     {name: "Gougou Dao", stu_id: "2012000111"},
                     {name: "Gougou Ju",  stu_id: "2012012222"},
                     {name: "Xuxu",       stu_id: "2012012333"}])

xuetang = Category.create({name: "Xuetang", description: "A program of pandas"})
yclass = Category.create({name: "Yao Class", description: "A class of hanzi", parent: xuetang})


articles = Article.create([{title: "Encore", content: "What the hell are you waiting for?", author: users[0]},
                           {title: "Catalyst", content: "Will we burn inside the fire of a thousand suns?", author: users[3]},
                           {title: "Gougou Ju gets Turing Award", content: "RT", author: users[1]}])
