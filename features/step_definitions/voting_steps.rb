Given /^a vote exists with three options$/ do
  ara = ["This", "That", "The other"]  
  options = ara.map!{|x| Factory(:option, :name => x) }
  
  @vote = Factory(:vote, :options => options)
end