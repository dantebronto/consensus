class Tally < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote
  belongs_to :option
end
