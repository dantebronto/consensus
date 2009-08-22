require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Vote do

  describe 'prioritization voting' do
    
    before do
      @vote = Factory(:prioritization_vote)
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
      @vote.tallies[0].matrix.should == [[0, 1, 1], [-1, 0, 1], [-1, -1, 0]]
    end
    
    it "should return the proper matrix for the middle tally" do
      @vote.tallies[1].matrix.should == [[0, -1, 1], [1, 0, 1], [-1, -1, 0]]
    end
    
    it "should return the proper matrix for the last tally" do
      @vote.tallies[2].matrix.should == [[0, -1, -1], [1, 0, -1], [1, 1, 0]]
    end
    
    it "should correctly add the tally matrices" do
      @vote.tally_matrix_sum.should  == [[0, -1, 1],  # alice: lost against bob, won against charlie
                                         [1, 0, 1],   # bob: beat both alice and charlie (condorcet winner)
                                         [-1, -1, 0]] # charlie: lost to alice and bob
    end
    
    it "should return the proper ordered options" do
      @vote.ordered_options.should == [@bo_op, @al_op, @ch_op] # expected order: bob, alice, charlie
    end
    
  end
end