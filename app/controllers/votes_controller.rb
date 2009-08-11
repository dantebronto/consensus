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
    topic_ids = params[:topics].keys

    @vote.topics.each do |v|
      if topic_ids.include?(v.id.to_s)
        v.tally = v.tally + 1
        v.save
      end
    end
    
    flash[:notice] = 'Vote was successfully cast.'
    redirect_to @vote
  end
  
  def destroy
    @vote = Vote.get(params[:id])
    @vote.destroy
    flash[:notice] = 'Vote successfully deleted'
    redirect_to votes_path
  end
end