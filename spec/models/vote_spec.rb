require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vote do

  describe 'condorcet voting' do
    
    before do
      @vote = Factory(:condorcet_vote)
      @al_op = Factory(:alice_opt)
      @bo_op = Factory(:bob_opt)
      @ch_op = Factory(:charlie_opt)
      @vote.options = [@al_op, @bo_op, @ch_op]
      
      @vote.tallies[0].option_order = "#{@al_op.id}|#{@bo_op.id}|#{@ch_op.id}" # alice, bob, charlie
      @vote.tallies[1].option_order = "#{@bo_op.id}|#{@al_op.id}|#{@ch_op.id}" # bob, alice, charlie
      @vote.tallies[2].option_order = "#{@ch_op.id}|#{@bo_op.id}|#{@al_op.id}" # charlie, bob, alice
    end
    
    it "should have three options" do
      @vote.options.length.should == 3
    end
    
    it "should have three tallies" do
      @vote.tallies.length.should == 3
    end
    
    it "should return the proper matrix for the first tally" do
      @vote.tallies[0].matrix.should == [[-1, 1, 1], [0, -1, 1], [0, 0, -1]]
    end
    
    it "should return the proper matrix for the middle tally" do
      @vote.tallies[1].matrix.should == [[-1, 0, 1], [1, -1, 1], [0, 0, -1]]
    end
    
    it "should return the proper matrix for the last tally" do
      @vote.tallies[2].matrix.should == [[-1, 0, 0], [1, -1, 0], [1, 1, -1]]
    end
    
    it "should correctly add the tally matrices" do
      @vote.tally_matrix_sum.should  == [[-3, 1, 2], [2, -3, 2], [1, 1, -3]]
    end
    
    it "should return the proper ordered options" do
      @vote.ordered_options.should == [@al_op.id, @bo_op.id, @ch_op.id].map(&:to_s)
    end
    
    it "should create an ordered array from the ordered options" do
      # @vote.ordered_options_weights.should == [@al_op.id, ]]
    end
    
    #it "should correctly convert an array to a hash" do
  end
end