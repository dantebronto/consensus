class Vote
  include DataMapper::Resource
  
  has n, :topics
  
  alias :old_topics= :topics=
  
  def topics=(ara)
    ara.map! { |topic| Topic.new(:name => topic, :vote_id => @id) }
    self.old_topics = ara
  end
  
  VOTE_TYPES = ["single_option", "multi_option", "condorcet", "allocation"]
  
  belongs_to :user
  
  property :id, Serial, :key => true, :protected => true
  property :name, String, :nullable => "false"
  property :type, String, :default => "single_option"
  property :visibiltiy, String, :default => "full"
  property :expires_on, DateTime
  
  def to_param
    @id.to_s
  end
  
  def tally_total
    self.topics.sum(:tally)
  end
end