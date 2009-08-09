class UsersController < ApplicationController
  before_filter :admin_required, :except => [:index]
  
  def index
  end
  
  def new
    @user = User.new
  end
  
  def edit
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
end