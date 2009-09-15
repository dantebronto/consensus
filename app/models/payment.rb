class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :remuneration
  
  def percentage_of_total_tenure
    self.user.tenure / User.total_tenure.to_f
  end

  def percentage_of_total_hours
    total = self.remuneration.payments.map(&:hours).sum
    puts total
    return 0 if total == 0
    self.hours / total.to_f
  end
  
  def hours_amount
    percentage_of_total_hours * self.remuneration.hours_value
  end
  
  def tenure_amount
    self.tenure
  end
end
