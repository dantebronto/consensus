class Remuneration < ActiveRecord::Base
  has_many :payments
  has_many :users, :through => :payments
  
  CATEGORIES = ["tenure", "peer_review", "hours", "worker_misc", "org_misc", "worker_capital", "org_capital"]
  
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
    User.all.each do |u| # associated workers are all those present at creation
      self.payments.create({
        :user => u,
        :tenure => u.tenure / User.total_tenure.to_f * self.tenure_value
      })
    end
  end
  
end
