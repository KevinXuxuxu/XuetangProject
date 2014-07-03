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

#xuetang = Category.create({name: "Xuetang", description: "A program of pandas"})
#yclass = Category.create({name: "Yao Class", description: "A class of hanzi", parent: xuetang})
top_category_list = [{name: 'Xuetang', description: "A program of pandas"},
                 {name: 'Yao Class', description: "No meizi"},
                 {name: 'Qian Class', description: "No meizi either"},
                 {name: 'Life Science', description: "Some meizi"},
                 {name: 'News', description: "happend few years ago"}]

Category.create(top_category_list)

sub_category_list = [{name: 'Ji20', description: "doubi", parent: Category.find_by_name("Yao Class")},
                     {name: 'Ji10', description: "doubi^2", parent: Category.find_by_name("Yao Class")},
                     {name: 'Ji00', description: "dasi dog", parent: Category.find_by_name("Yao Class")}]

Category.create(sub_category_list)

course_list = [{name: 'Algorithm Design', description: 'hehe', teacher: 'Papa', location: 'Xuetang112', ctime: '000000000000000100000000000000', belong: 'Yaoclass'},
            {name: 'Cryptograpy', description: 'lethal', teacher: 'Yuyu', location: 'Xuetang112', ctime: '001100000000000000000000000000', belong: 'Yaoclass'},
            {name: 'Mechanic', description: 'whatever', teacher: 'Newton', location: '6A105', ctime: '000000000000000000001000000000', belong: 'Qianclass'}]

Course.create(course_list)

articles = Article.create([{title: "Encore", content: "What the hell are you waiting for?", author: users[0], category: Category.find_by_name('Xuetang')},
                           {title: "Catalyst", content: "Will we burn inside the fire of a thousand suns?", author: users[3], category: Category.find_by_name('Xuetang')},
                           {title: "Gougou Ju gets Turing Award", content: "RT", author: users[1], category: Category.find_by_name('Yao Class')}])
