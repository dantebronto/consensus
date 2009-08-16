Factory.define :vote do |u|
  u.name 'A Vote'
  u.expires_on 2.weeks.from_now 
  u.state 'new' 
  u.kind 'single_option'
end

