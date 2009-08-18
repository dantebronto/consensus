require 'matrix'
require 'lib/runoff' # instant runoff voting

class Vote < ActiveRecord::Base
  has_many :users, :through => :tallies
  has_many :tallies, :dependent => :destroy
  has_many :options, :dependent => :destroy

  validates_presence_of :name

  has_many :options
  
  VOTE_TYPES = ["single_option", "multi_option", "condorcet", "allocation"]
  
  def handle_cast(params, current_user)
    case self.kind.to_sym
    when :single_option
      if params[:option]
        opt = self.options.find_by_id(params[:option].first)
        opt.tallies.create(:vote => self, :user => current_user) if opt
      end
    when :multi_option
      option_ids = params[:options].keys
      self.options.each do |opt|
        opt.tallies.create(:user => current_user, :vote => self, :value => 1) if option_ids.include?(opt.id.to_s)
      end
    when :allocation
      self.options.each do |opt|
        value = params[:options][opt.id.to_s]
        opt.tallies.create(:user => current_user, :vote => self, :value => value)
      end
    when :condorcet
      self.tallies.create(:user => current_user, :option_order => params[:options].join("|"))
    end
  end
  
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

  def option_count
    self.options.count
  end
  
  def tally_count
    self.tallies.count
  end

  def votes_cast
    tally_count / option_count
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
  
  def tally_matrix_sum
    matrices = tallies.map {|x| Matrix[*x.matrix] }
    retval = Matrix.zero(tallies.count)
    matrices.each {|m| retval += m }
    retval.to_a
  end
  
  def ordered_options
    tallies.first.option_order.split("|").sort
  end
  
  def ordered_array_from_sum_matrix
    # self.tally_matrix_sum
    # i = self.ordered_options.length
    # h.sort_by { |k,v| v }
  end
  
  def instant_runoff
    vote_ara = self.tallies.map {|x| x.option_order_array }
    InstantRunoffVote.new(vote_ara).result
  end
  
end
