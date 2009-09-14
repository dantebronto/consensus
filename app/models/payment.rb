class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :remuneration
  
  def percentage_of_total_tenure
    self.user.tenure / User.total_tenure.to_f * 100
  end

end
