class VotesController < ApplicationController  
  def index
    @votes = Vote.all
  end
  
  def show
    @vote = Vote.find_by_id(params[:id]) #, :include => [ {:tallies => :option}, :options ])
  end
  
  def new
    @vote = Vote.new
  end
  
  def edit
    @vote = Vote.find_by_id(params[:id])
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
    option_ids = params[:options].keys

    @vote.options.each do |opt|
      opt.tallies.create(:user => current_user, :vote => @vote, :value => 1) if option_ids.include?(opt.id.to_s)
    end

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