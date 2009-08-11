class Option < ActiveRecord::Base
  belongs_to :vote
  has_many :tallies
end
