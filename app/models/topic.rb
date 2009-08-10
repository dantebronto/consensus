class Topic
  include DataMapper::Resource
  
  belongs_to :vote
  
  property :id, Serial, :key => true, :protected => true
  property :vote_id, Integer, :nullable => "false"
  property :name, String, :nullalbe => "false"
  property :tally, Integer, :default => 0
end