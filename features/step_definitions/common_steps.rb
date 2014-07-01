require 'debugger' 

Then /I should see (.*) before (.*)/ do | e1, e2|
  assert( page.body =~ /#{e1}.*#{e2}/m, "#{e2} appeared before #{e1}!")
end

Then /I should( not)? see the following things: (.*)/ do |not_, things|
  things.split(', ').each do |thing|
    step %Q{I should#{not_} see "#{thing}"}
  end
end

Then /I should see the following things in order: (.*)/ do |things|
  assert( page.body =~ /#{things.gsub(/, /, ".*")}/m)
end

Then /I follow "(.*)" of "(.*)"/ do |action, target|
  step %Q{I follow "#{action}_#{target}"}
end
