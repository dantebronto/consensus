Given /^there is a User whose login is "([^\"]*)"$/ do |arg1|
  Factory(:user, :login => "kellen")
end

Given /^there is not a User whose login is "([^\"]*)"$/ do |arg1|
  raise "User found with that login" if User.all.map(&:login).include?(arg1)
end

Given /^I am logged in as an? (.+)$/ do |u|
  user = Factory(u.to_sym)
  visit '/login'
  fill_in(:login, :with => user.login) 
  fill_in(:password, :with => user.password) 
  click_button("Login")
end