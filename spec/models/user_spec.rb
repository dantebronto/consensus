require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  describe 'admin?' do
    it 'should return true if user has permission of -1' do
      admin = Factory(:user, :permission_level => -1)
      admin.admin?.should be_true
    end
    
    it 'should return false if user does not have adequate permissions' do
      not_admin = Factory(:user)
      not_admin.admin?.should be_false
    end
  end

end