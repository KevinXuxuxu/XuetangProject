require 'debugger' 

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(user)
  end
end

Then /I should see (.*) before (.*)/ do | e1, e2|
  assert( page.body =~ /#{e1}.*#{e2}/m, "#{e2} appeared before #{e1}!")
end
