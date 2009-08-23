class WelcomeController < ApplicationController
  before_filter :login_required, :except => [:index, :about]

  def index; end
  def about; end  
end