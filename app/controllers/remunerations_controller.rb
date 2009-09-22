class RemunerationsController < ApplicationController

  def categories
    @remuneration = Remuneration.find_by_id(params[:id], :include => :users)
    case params[:category]
    when 'tenure'
      render :action => 'tenure'
    when 'hours'
      render :action => 'hours'
    when 'worker_capital'
      render :action => 'worker_capital'
    when 'peer_review'
      @vote = @remuneration.vote(:include => [:tallies, { :options => :payment }])
      @remuneration.set_peer_review_values
      render :action => 'peer_review'
    when 'worker_misc'
      @remuneration.set_worker_misc_values
      render :action => 'worker_misc'
    else 
      render :action => 'edit'
    end
  end

  def index
    @remunerations = Remuneration.paginate(:page => params[:page], :order => "created_at DESC", :per_page => 10)
  end

  def show
    @remuneration = Remuneration.find(params[:id], :include => [:users, :payments])
  end

  def new
    @remuneration = Remuneration.new
    @remuneration.start_date = Date.today
    @remuneration.end_date = Date.today + 1.week
    @round_robin = Vote.round_robin(7)
  end

  def edit
    @remuneration = Remuneration.find(params[:id])
  end

  def create
    @remuneration = Remuneration.new(params[:remuneration])

    if @remuneration.save
      flash[:notice] = 'Remuneration was successfully created.'
      redirect_to(@remuneration)
    else
      render :action => "new"
    end
  end

  def update
    @remuneration = Remuneration.find(params[:id])
    @remuneration.handle_category(params)

    if @remuneration.update_attributes(params[:remuneration])
      flash[:notice] = 'Remuneration was successfully updated.'
      if params[:category]
        render :action => params[:category]
      else
        redirect_to(@remuneration)
      end
    else
      render :action => "edit"
    end
  end

  def destroy
    @remuneration = Remuneration.find(params[:id])
    @remuneration.destroy
    
    redirect_to(remunerations_url)
  end
end
