Given /^there are no users with login "([^\"]*)"$/ do |arg1|
  User.all(:login => arg1).destroy!
end