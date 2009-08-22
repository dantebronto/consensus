require 'matrix'

class Vote < ActiveRecord::Base
  has_many :users, :through => :tallies
  has_many :tallies, :dependent => :destroy
  has_many :options, :dependent => :destroy

  validates_presence_of :name

  has_many :options
  
  VOTE_TYPES = ["single_option", "multi_option", "prioritization", "allocation"]
  
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
    when :prioritization
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
    retval = Matrix.zero(options.count)
    matrices.each {|m| retval += m }
    retval.to_a
  end
  
  def ordered_options
    self.condorcet.each do |opt_id, score|
      opt = self.options.select {|x| x.id == opt_id.to_i }.first
      opt.condorcet_score = score
    end
    self.options.sort_by {|x| x.condorcet_score }.reverse
  end

  def condorcet
    sum_matrix = tally_matrix_sum
    sum_matrix.map! {|x| x.sum }
    ret_hsh = {}
    self.options.each_with_index do |opt, i| 
      ret_hsh.merge!({ opt.id.to_s => sum_matrix[i] })
    end
    ret_hsh
  end
end
