class VotesController < ApplicationController
  
  def prioritize
    @vote = Vote.find_by_id(params[:id])
  end
  
  def allocate
    @vote = Vote.find_by_id(params[:id])
    @allocation = @vote.round_robin
  end
  
  def index
    @votes = Vote.all
  end
  
  def show
    @vote = Vote.find_by_id(params[:id]) #, :include => [ {:tallies => :option}, :options ])
    case @vote.kind.to_sym
    when :allocation then render :action => 'view_allocation'
    when :condorcet  then render :action => 'view_condorcet'
    end
  end
  
  def new
    @vote = Vote.new
  end
  
  def cast
    @vote = Vote.find_by_id(params[:id])
    case @vote.kind.to_sym
    when :allocation then redirect_to :action => 'allocate'
    when :condorcet  then redirect_to :action => 'prioritize'
    end
  end
  
  def create
    @vote = Vote.new(params[:vote])
    params[:options].each { |opt| @vote.options.build(:name => opt) } if params[:options]

    if @vote.save
      flash[:notice] = 'Vote was successfully created.'
      redirect_to votes_path
    else
      render :action => "new"
    end
  end
  
  def update
    @vote = Vote.find_by_id(params[:id])  
    @vote.handle_cast(params, current_user)
    
    flash[:notice] = 'Vote was successfully cast.'
    redirect_to @vote
  end
  
  def destroy
    @vote = Vote.find_by_id(params[:id])
    @vote.destroy
    flash[:notice] = 'Vote successfully deleted'
    redirect_to votes_path
  end
end