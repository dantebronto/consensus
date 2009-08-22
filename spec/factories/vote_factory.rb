Factory.define :vote do |u|
  u.name 'A Vote'
  u.expires_on 2.weeks.from_now 
  u.state 'new' 
  u.kind 'single_option'
end

Factory.define :prioritization_vote, :class => :vote do |u|
  u.name 'Condorcet'
  u.expires_on 2.weeks.from_now 
  u.state 'new'
  u.kind 'prioritization'
  u.tallies {
    [Factory(:alice_tally), Factory(:bob_tally), Factory(:charlie_tally)]
  }
end