require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Payment do
  before(:each) do
    @valid_attributes = {
      :tenure => 1,
      :peer_review => 1,
      :hours => 1,
      :worker_misc => 1,
      :worker_capital => 1,
      :total_profits => 1,
      :user_id => 1,
      :remuneration_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Payment.create!(@valid_attributes)
  end
end
