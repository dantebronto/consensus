Given /^there are no users with login "([^\"]*)"$/ do |arg1|
  User.destroy_all({:login => arg1})
end

Given /^there is a user with login "([^\"]*)"$/ do |arg1|
  Factory(:user, :login => "bob", :email => "bob@bob.com")
end