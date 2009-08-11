class Vote < ActiveRecord::Base
  has_many :users, :through => :tallies
  has_many :tallies
  has_many :options

  validates_presence_of :name

  has_many :options
  
  VOTE_TYPES = ["single_option", "multi_option", "condorcet", "allocation"]
    
  def tally_total
    self.topics.sum(:tally)
  end
end
