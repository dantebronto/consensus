class Vote < ActiveRecord::Base
  has_many :users, :through => :tallies
  has_many :tallies
  has_many :options

  validates_presence_of :name

  has_many :options
  
  VOTE_TYPES = ["single_option", "multi_option", "condorcet", "allocation"]
  
  def tally_total
    self.tallies.count
  end
  
  def assign_options(ara)
    self.options = ara.map { |opt| Option.new(:name => opt) }
  end
  
  def percentage(option)
    return 0 if self.tally_total == 0
    percent = (option.tallies.count.to_f / self.tally_total) * 100
    sprintf("%.1f", percent)
  end

  def round_robin
    opts = options.count
    ara = Array.new(opts, 0)
    j=0
    100.times do |i|
      ara[j] += 1
      if(j == opts - 1)
        j = 0
      else
        j += 1
      end
    end
    return ara
  end
  
end
