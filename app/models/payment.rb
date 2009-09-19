class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :remuneration
  has_one :option # for peer reviews
  
  def percentage_of_total_tenure
    self.tenure / self.remuneration.payments.map(&:tenure).sum.to_f
  end
  
  def tenure_amount
    percentage_of_total_tenure * self.remuneration.tenure_value
  end
  
  def peer_review_amount
    self.peer_review
  end
  
  def percentage_of_total_hours
    total = self.remuneration.payments.map(&:hours).sum
    return 0 if total == 0
    self.hours / total.to_f
  end
  
  def hours_amount
    percentage_of_total_hours * self.remuneration.hours_value
  end
  
  def percentage_of_total_worker_capital
    total = self.remuneration.payments.map(&:worker_capital).sum
    return 0 if total == 0
    self.worker_capital / total.to_f
  end
  
  def worker_capital_amount
    (percentage_of_total_worker_capital * self.remuneration.worker_capital_value).to_i
  end
  
  def worker_misc_amount
    0.01 * self.worker_misc * self.remuneration.worker_misc_value
  end
  
  def org_misc_amount; 0; end
  def org_capital_amount; 0; end

  def total_profits
    cur_val = self[:total_profits]
    new_val = 0
    Remuneration::CATEGORIES.each { |cat| new_val += self.send("#{cat}_amount").to_i }
    self.total_profits= new_val
    self.save if cur_val.to_i != new_val.to_i
    return new_val
  end
  
end
