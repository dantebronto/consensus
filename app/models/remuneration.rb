class Remuneration < ActiveRecord::Base
  CATEGORIES = ["tenure", "peer_review", "hours", "worker_misc", "org_misc", "worker_capital", "org_capital"]
  
  CATEGORIES.each do |cat|
    define_method("#{cat}_value".to_sym) do # Renumeration.new.tenure_value => (percentage tenure * total profits)
      ((self.send(cat).to_f / 100) * total_profits.to_f).to_i
    end
  end
  
end
