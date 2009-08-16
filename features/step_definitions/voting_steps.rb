Given /^a vote exists with three options$/ do
  @vote = Factory(:vote)
  ara = ["This", "That", "The other"]
  @vote.options = ara.map!{|x| Factory(:option, :name => x) } 
end