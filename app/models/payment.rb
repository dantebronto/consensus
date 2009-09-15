class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :remuneration
  
  def percentage_of_total_tenure
    self.user.tenure / User.total_tenure.to_f
  end

  def percentage_of_total_hours
    total = self.remuneration.payments.map(&:hours).sum
    return 0 if total == 0
    self.hours / total.to_f
  end
  
  def percentage_of_total_worker_capital
    total = self.remuneration.payments.map(&:worker_capital).sum
    return 0 if total == 0
    self.worker_capital / total.to_f
  end
  
  def worker_capital_amount
    percentage_of_total_worker_capital * self.remuneration.worker_capital_value
  end
  
  def hours_amount
    percentage_of_total_hours * self.remuneration.hours_value
  end
  
  def tenure_amount
    self.tenure
  end
end
