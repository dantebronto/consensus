class Option < ActiveRecord::Base
  belongs_to :vote
  has_many :tallies
  
  attr_accessor :condorcet_score
  
   # (number-of-tallies for this option / total vote tallies)
  def average_percentage
    count = self.tallies.count
    return 0 if count == 0
    value_total = self.tallies.sum(:value)
    avg = value_total.to_f / count
    sprintf("%.1f", avg)
  end
end