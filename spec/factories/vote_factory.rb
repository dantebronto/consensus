Factory.define :vote do |u|
  u.name 'A Vote'
  u.expires_on 2.weeks.from_now 
  u.state 'new' 
  u.kind 'single_option'
end

Factory.define :condorcet_vote, :class => :vote do |u|
  u.name 'Condorcet'
  u.expires_on 2.weeks.from_now 
  u.state 'new'
  u.kind 'condorcet'
  # u.options {
  #   [Factory(:alice_opt), Factory(:bob_opt), Factory(:charlie_opt)]
  # }
  u.tallies {
    [Factory(:alice_tally), Factory(:bob_tally), Factory(:charlie_tally)]
  }
end