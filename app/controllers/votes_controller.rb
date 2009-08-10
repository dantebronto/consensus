class VotesController < ApplicationController  
  def index
    @votes = Vote.all
  end
  
  def show
    @vote = Vote.get(params[:id])
  end
  
  def new
    @vote = Vote.new
  end
  
  def edit
    @vote = Vote.get(params[:id])
  end
  
  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user
    if @vote.save
      flash[:notice] = 'Vote was successfully created.'
      redirect_to votes_path
    else
      render :action => "new"
    end
  end
  
  def update
    @vote = Vote.get(params[:id])
    if @vote.update_attributes(params[:vote])
      flash[:notice] = 'Vote was successfully updated.'
      redirect_to votes_path
    else
      render :action => "new"
    end
  end
  
  def destroy
    @vote = Vote.get(params[:id])
    @vote.destroy
    flash[:notice] = 'Vote successfully deleted'
    redirect_to votes_path
  end
end