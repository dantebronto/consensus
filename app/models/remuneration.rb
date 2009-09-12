class Remuneration < ActiveRecord::Base
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
  
  
  
end
