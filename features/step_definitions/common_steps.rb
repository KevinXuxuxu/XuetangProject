require 'debugger' 

Then /I should see (.*) before (.*)/ do | e1, e2|
  assert( page.body =~ /#{e1}.*#{e2}/m, "#{e2} appeared before #{e1}!")
end
