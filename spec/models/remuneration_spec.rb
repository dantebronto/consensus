require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Remuneration do
  before(:each) do
    @valid_attributes = {
      :tenure => 1,
      :peer_review => 1,
      :hours => 1,
      :worker_misc => 1,
      :org_misc => 1,
      :worker_capital => 1,
      :org_capital => 1,
      :start_date => Date.today,
      :end_date => Date.today,
      :total_profits => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Remuneration.create!(@valid_attributes)
  end
end
