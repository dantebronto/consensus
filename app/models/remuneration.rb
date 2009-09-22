class Remuneration < ActiveRecord::Base
  has_many :payments, :dependent => :destroy
  has_many :users, :through => :payments
  has_many :votes, :dependent => :destroy
  
  CATEGORIES = ["tenure", "peer_review", "hours", "worker_misc", "worker_capital", "org_misc", "org_capital"]
  
  CATEGORIES.each do |cat| # define a reader for each that returns % amt of total profit
    define_method("#{cat}_value".to_sym) do # Renumeration.new.tenure_value => (tenure % * total_profits)
      ((self.send(cat).to_f / 100) * total_profits.to_f).to_i
    end
  end
  
  def after_create
    this_vote = Vote.new({
      :name => "peer review for #{self.start_date} to #{self.end_date}",
      :kind => "prioritization", 
      :remuneration => self
    })
    User.all.each do |u|
      self.payments.create({
        :tenure => u.tenure,
        :hours => 40,
        :user => u
      })
    end
    self.payments.each do |p|
      this_vote.options.build({
        :payment => p,
        :name => p.user.login
      })
    end
    this_vote.save
  end
  
  def set_peer_review_values
    half_prv = self.peer_review_value / 2
    user_percent = 1.0 / self.vote.option_count
    guar_amt = user_percent * half_prv
     
    woos = self.vote.weighted_ordered_option_scores
    woos_total = woos.sum
    
    if woos_total == 0
      fair_percent = 0
    else
      fair_percent = 1.0 / woos_total
    end
    chunk = fair_percent * half_prv
    
    self.vote.ordered_options.each_with_index do |option, i|
      p = option.payment
      cur_val = p.peer_review
      new_val = chunk * woos[i] + guar_amt
      p.peer_review = new_val
      p.save if cur_val != new_val
    end
  end
  
  def handle_category(params)
    return unless params[:category]
    case params[:category]
    when "tenure"         then handle_tenure(params)
    when "worker_capital" then handle_worker_capital(params)
    when "worker_misc"    then handle_worker_misc(params)
    when "hours"          then handle_hours(params)
    end
  end
  
  def handle_tenure(params)
    ten = params[:tenure] || []
    self.payments.each_with_index do |pay,i| 
      pay.update_attribute(:tenure, ten[i])
    end unless ten.blank?
  end
  
  def handle_worker_misc(params)
    # user_percentages"=>{"1"=>"46", "2"=>"10", "3"=>"44"}
    ups = params[:user_percentages] || []
    self.payments.each do |pay| 
      new_val = ups[pay.user_id.to_s]
      pay.update_attribute(:worker_misc, new_val) if new_val 
    end
  end
  
  def handle_hours(params)
    hours = params[:hours] || []
    self.payments.each_with_index do |pay,i| 
      pay.update_attribute(:hours, hours[i])
    end unless hours.blank?
  end
  
  def handle_worker_capital(params)
    capital = params[:capital] || []
    self.payments.each_with_index do |pay, i| 
      pay.update_attribute(:worker_capital, capital[i]) 
    end unless capital.blank?
  end
  
  def set_worker_misc_values
    total = self.payments.map(&:worker_misc).sum
    return if total == 100
    vals = Vote.round_robin(self.payments.length)
    self.payments.each_with_index {|p,i| p.worker_misc = vals[i] }
  end
  
  def vote(opts = {}) # only has one vote for the time being
    @vote ||= self.votes.first(opts)
  end
  
  def completed_peer_review_count
    self.payments.map(&:peer_review).reject {|x| x == 0}.length
  end
  
end
