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
  
  def after_initialize
    self.start_date = Date.today
    self.end_date = Date.today + 1.week
  end
  
  def after_create
    this_vote = Vote.create({
      :name => "peer review for #{self.start_date} to #{self.end_date}",
      :kind => "prioritization", 
      :remuneration => self
    })  
    User.all.each do |u|
      self.payments.create({ 
        :tenure => u.tenure / User.total_tenure.to_f * self.tenure_value,
        :user => u
      })
      this_vote.options.create({
        :name => u.login
      })
    end
  end
  
  def handle_category(params)
    return unless params[:category]
    case params[:category]
    when "worker_capital" then handle_worker_capital(params)
    when "worker_misc"    then handle_worker_misc(params)
    when "hours"          then handle_hours(params)
    end
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
  
  def vote # only has one vote for the time being
    self.votes.first
  end
  
  def completed_peer_review_count
    self.payments.map(&:peer_review).reject {|x| x == 0}.length
  end
  
end
