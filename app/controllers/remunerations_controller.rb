class RemunerationsController < ApplicationController

  def categories
    @remuneration = Remuneration.find_by_id(params[:id])
    case params[:category]
    when 'tenure'
      render :action => 'tenure'
    when 'hours'
      render :action => 'hours'
    when 'worker_capital'
      render :action => 'worker_capital'
    when 'peer_review'
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
    @remunerations = Remuneration.all
  end

  def show
    @remuneration = Remuneration.find(params[:id])
  end

  def new
    @remuneration = Remuneration.new
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
      redirect_to(@remuneration)
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
