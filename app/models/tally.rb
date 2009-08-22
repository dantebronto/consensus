class Tally < ActiveRecord::Base
  belongs_to :user
  belongs_to :vote
  belongs_to :option
  
  def matrix
    retval = []
    original_order = self.option_order.split("|")
    option_ids = original_order.sort
    option_ids.each_with_index do |outer_id, i|
      current_row = []
      option_ids.each_with_index do |inner_id, j|
        if outer_id == inner_id
          current_row << 0
        elsif original_order.index(outer_id) < original_order.index(inner_id)
          current_row << 1
        else
          current_row << -1
        end
      end
      retval << current_row
    end
    retval
  end
  
  def option_order_array
    self.option_order.split("|")
  end
  
end
