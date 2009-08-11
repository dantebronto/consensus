class UsersController < ApplicationController 
  before_filter :admin_required
   
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.get(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to users_path
    else
      render :action => "new"
    end
  end
  
  def update
    @user = User.get(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to users_path
    else
      render :action => "new"
    end
  end
  
  def destroy
    @user = User.get(params[:id])
    @user.destroy
    flash[:notice] = 'User successfully deleted'
    redirect_to users_path
  end
end