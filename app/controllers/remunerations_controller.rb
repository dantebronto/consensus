class RemunerationsController < ApplicationController
  # GET /remunerations
  # GET /remunerations.xml
  def index
    @remunerations = Remuneration.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @remunerations }
    end
  end

  # GET /remunerations/1
  # GET /remunerations/1.xml
  def show
    @remuneration = Remuneration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @remuneration }
    end
  end

  # GET /remunerations/new
  # GET /remunerations/new.xml
  def new
    @remuneration = Remuneration.new
    @round_robin = Vote.round_robin(7)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @remuneration }
    end
  end

  # GET /remunerations/1/edit
  def edit
    @remuneration = Remuneration.find(params[:id])
  end

  # POST /remunerations
  # POST /remunerations.xml
  def create
    @remuneration = Remuneration.new(params[:remuneration])

    respond_to do |format|
      if @remuneration.save
        flash[:notice] = 'Remuneration was successfully created.'
        format.html { redirect_to(@remuneration) }
        format.xml  { render :xml => @remuneration, :status => :created, :location => @remuneration }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @remuneration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /remunerations/1
  # PUT /remunerations/1.xml
  def update
    @remuneration = Remuneration.find(params[:id])

    respond_to do |format|
      if @remuneration.update_attributes(params[:remuneration])
        flash[:notice] = 'Remuneration was successfully updated.'
        format.html { redirect_to(@remuneration) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @remuneration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /remunerations/1
  # DELETE /remunerations/1.xml
  def destroy
    @remuneration = Remuneration.find(params[:id])
    @remuneration.destroy

    respond_to do |format|
      format.html { redirect_to(remunerations_url) }
      format.xml  { head :ok }
    end
  end
end
