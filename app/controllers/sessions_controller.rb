class SessionsController < ApplicationController
  before_filter :login_required, :except => ["new", "create"]
  
  def new
  end
  
  def create
    if user = User.authenticate(params[:login], params[:password])
      session[:user] = user.id
      flash[:notice] = "Logged in"
      redirect_to session[:return_to] || root_path
      session[:return_to] = nil
    else
      flash[:error] = "Unknown login or password"
      render :action => 'new'
    end
  end
  
  def destroy
    flash[:notice] = "You have been logged out"
    session[:user] = nil
    redirect_to root_path
  end
end